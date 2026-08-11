#!/usr/bin/env bash
#
# install.sh - symlink every config in this repo into its place on disk.
#
#   ./install.sh --dry-run    print what would happen, change nothing
#   ./install.sh              do it
#
# Reads manifest.conf, which pairs a file in this repo with where it belongs
# in the home directory. Whatever sits at a target is replaced by a symlink
# pointing back here, so editing the repo edits the live config.
#
# Re-running is free: targets that already point at the right file are left
# alone. Targets holding something else are moved into a timestamped backup
# directory before being relinked, so nothing is ever destroyed outright.

set -euo pipefail


# --- where things are --------------------------------------------------------
# Resolve the repo from the script's own location rather than the working
# directory, so ./install.sh works when called from anywhere.

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$REPO_DIR/manifest.conf"

# Backups live in the repo under backups/, one timestamped directory per run
# so repeated runs never overwrite each other. Created lazily, so a run with
# nothing to back up leaves no empty directory behind. backups/ is gitignored.
BACKUP_DIR="$REPO_DIR/backups/$(date +%Y%m%d-%H%M%S)"


# --- arguments ---------------------------------------------------------------
# Only one flag: --dry-run (or -n) reports without touching the filesystem.

DRY_RUN=false
[[ "${1:-}" == "--dry-run" || "${1:-}" == "-n" ]] && DRY_RUN=true


# --- output formatting -------------------------------------------------------
# Colour codes only when stdout is a terminal, so piping to a file or another
# program produces clean text instead of escape sequences.

if [[ -t 1 ]]; then
  BOLD=$'\033[1m'; DIM=$'\033[2m'; GREEN=$'\033[32m'
  YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
else
  BOLD=''; DIM=''; GREEN=''; YELLOW=''; RED=''; RESET=''
fi

die() { printf '%serror:%s %s\n' "$RED" "$RESET" "$1" >&2; exit 1; }


# --- counters ----------------------------------------------------------------
# Tallied as we go and printed as a summary at the end.

n_linked=0     # symlinks created
n_skipped=0    # already correct, or source missing from the repo
n_backed_up=0  # something was in the way and got moved aside first


# --- the actual work ---------------------------------------------------------
# Handles one manifest line: repo-relative source, then target path where a
# leading ~ means the home directory.

link_one() {
  local src_rel="$1" target_raw="$2"
  local src="$REPO_DIR/$src_rel"
  local target="${target_raw/#\~/$HOME}"

  # A manifest line can name a file that isn't in the repo yet. Report it and
  # keep going rather than aborting the whole run.
  if [[ ! -e "$src" ]]; then
    printf '%s  skip%s %s %s(missing in repo)%s\n' \
      "$YELLOW" "$RESET" "$target_raw" "$DIM" "$RESET"
    n_skipped=$((n_skipped + 1))
    return
  fi

  # Nothing to do if this link already points where we want it. This is what
  # makes the script safe to run repeatedly.
  if [[ -L "$target" && "$(readlink "$target")" == "$src" ]]; then
    printf '%s    ok%s %s\n' "$DIM" "$RESET" "$target_raw"
    n_skipped=$((n_skipped + 1))
    return
  fi

  # Something else occupies the target: a real file, a real directory, or a
  # symlink pointing somewhere stale. Move it into the backup directory so ln
  # has a clear path and the original stays recoverable. The path under the
  # backup mirrors its path under ~, so ~/.config/nvim lands at
  # backups/<timestamp>/.config/nvim and it is obvious where each item came from.
  if [[ -e "$target" || -L "$target" ]]; then
    local backup_path="$BACKUP_DIR/${target#"$HOME"/}"
    printf '%sbackup%s %s %s-> %s%s\n' \
      "$YELLOW" "$RESET" "$target_raw" "$DIM" "${backup_path#"$REPO_DIR"/}" "$RESET"
    if ! $DRY_RUN; then
      mkdir -p "$(dirname "$backup_path")"
      mv "$target" "$backup_path"
    fi
    n_backed_up=$((n_backed_up + 1))
  fi

  # Create any missing parent directories, then link. mkdir -p matters for
  # first runs on a new machine where ~/.claude/agents may not exist yet.
  printf '%s  link%s %s %s-> %s%s\n' \
    "$GREEN" "$RESET" "$target_raw" "$DIM" "$src_rel" "$RESET"
  if ! $DRY_RUN; then
    mkdir -p "$(dirname "$target")"
    ln -s "$src" "$target"
  fi
  n_linked=$((n_linked + 1))
}


# --- main loop ---------------------------------------------------------------
# Read the manifest line by line, ignoring blanks and # comments. Each line is
# "source target"; _rest absorbs the padding spaces used to align the columns.

[[ -f "$MANIFEST" ]] || die "manifest not found at $MANIFEST"

$DRY_RUN && printf '%s-- dry run: nothing will be changed --%s\n\n' "$BOLD" "$RESET"

while read -r src target _rest; do
  [[ -z "${src:-}" || "$src" == \#* ]] && continue
  [[ -z "${target:-}" ]] && die "manifest line has a source but no target: $src"
  link_one "$src" "$target"
done < "$MANIFEST"


# --- summary -----------------------------------------------------------------

printf '\n%s%d linked, %d already fine, %d backed up%s\n' \
  "$BOLD" "$n_linked" "$n_skipped" "$n_backed_up" "$RESET"

# Point at the backup directory only when something actually landed in it.
if (( n_backed_up > 0 )) && ! $DRY_RUN; then
  printf 'originals saved in %s\n' "${BACKUP_DIR#"$REPO_DIR"/}"
fi

$DRY_RUN && printf '%sre-run without --dry-run to apply%s\n' "$DIM" "$RESET"

exit 0
