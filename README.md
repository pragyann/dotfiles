# dotfiles

Personal macOS configuration, version controlled and symlinked into place.

## Setup on a new machine

```sh
git clone git@github.com:pragyann/dotfiles.git ~/github/pragyann/dotfiles
cd ~/github/pragyann/dotfiles
brew bundle
./install.sh --dry-run
./install.sh
```

Open a new shell afterwards.

## What's tracked

| Config | Repo path | Links to |
|---|---|---|
| zsh | `home/.zshrc`, `home/.zprofile` | `~/.zshrc`, `~/.zprofile` |
| Starship | `home/.config/starship/` | `~/.config/starship` |
| Neovim | `home/.config/nvim/` | `~/.config/nvim` |
| WezTerm | `home/.config/wezterm/` | `~/.config/wezterm` |
| herdr | `home/.config/herdr/config.toml` | `~/.config/herdr/config.toml` |
| Claude Code | `home/.claude/` | `~/.claude/*` |
| Agent memory | `home/AGENTS.md` | `~/.claude/CLAUDE.md` **and** `~/.codex/AGENTS.md` |
| Packages | `Brewfile` | n/a (`brew bundle`) |

`home/` mirrors the layout of `~`, so a repo path tells you where it lands.

### Agent memory

`home/AGENTS.md` is linked to two places at once, so Claude and Codex read the
same instructions from one file.

### Whole directories vs single files

Starship, Neovim, and WezTerm are linked as **directories**, since they contain
nothing but config, so new files are picked up automatically.

`.claude`, `.codex`, and `herdr` are linked **file by file**. Those directories
also hold live sockets, session state, auth tokens, and hundreds of megabytes
of logs, none of which belong in git. Adding a new file from one of them means
adding a manifest line.

## Adding a config

1. Move the real file into `home/` at the path mirroring its location in `~`
2. Add a `source  target` line to `manifest.conf`
3. Run `./install.sh`
4. Commit

## How install.sh behaves

- Idempotent, so correct links are left alone and re-running is free
- Anything else at a target is moved to `backups/<timestamp>/` before the link
  is made, mirroring its path under `~`. Nothing is deleted outright.
  `backups/` is gitignored, so displaced configs stay local
- Missing parent directories are created
- `--dry-run` (or `-n`) prints the plan and changes nothing
