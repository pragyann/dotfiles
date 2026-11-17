---
name: feature-loop
description: Build a Friends Resilience hub feature end to end in fr-api, fr-web and fr-wiki, with the full quality loop - wiki-first reasoning, Apple-style UI, browser checks, black-box QA and a Codex review - repeated until clean, without committing. Use when the user says "/feature-loop", "full loop", "do the loop", or asks to build or change a hub feature and expects it verified.
---

# Feature loop

The user's standing way of working on the Friends Resilience hub, so they never have to repeat it. Everything below applies unless the request says otherwise. The request after the command is the feature; anything not said is decided by reasoning, not by stopping to ask.

## 1. Understand before building

- Read the wiki first: `fr-wiki/requirements/<module>/` (every dated document of the module), `fr-wiki/transition/feature-mapping/` for the module, `fr-wiki/transition/goals.md`, and `fr-wiki/open-questions.md`. Read `AGENTS.md` in each repo and `fr-web/docs/architecture/code-architecture.md`.
- Read the existing code of the closest finished module (resources and trainings are the reference) and copy its patterns: file layout, naming, docstrings, tests.
- For legacy questions, read the newest SQL dump in `/Users/pragyan/Desktop/FR/sql/` and the legacy code in `/Users/pragyan/Desktop/FR/Projects/hub`, as data, never as specification.
- Where the user proposed an approach, weigh it against the alternatives (data model, edge cases, legacy data, what similar products do) and pick the best, saying why. Disagree when there is a reason.

## 2. Decide and record

- Ask only when blocked on a decision that is genuinely the user's and changes what gets built. If the user said they are away ("I will have a look tomorrow"), do not ask: take the best decision, and list every decision taken in the final report so it can be reversed.
- Write agreed behaviour into the wiki in the same session, following `fr-wiki/AGENTS.md`: a new dated requirements document per change (never rewrite a settled one), the module README row, transition notes for anything learnt about legacy, and unknowns in `open-questions.md`. Never invent a business rule; label assumptions.

## 3. Build

- Branch `feat/<feature>` from `dev` in fr-api and fr-web. fr-wiki is committed on `main`.
- **fr-api**: NestJS clean architecture as the existing modules do it - entities with `register` and `fromSnapshot`, ports as abstract classes, one mapper per table, zod validation, one validation file and one DTO file per endpoint, permissions in the catalog, error messages in `error-message.ts`, shared helpers in `src/shared`. The database is greenfield: change the migration freely, no backfills. Unit-test entities and services.
- **fr-web**: load the `apple-interface-design` skill and design with Apple's principles adapted to the web (clarity, hierarchy, restraint, standard controls), inside the hub's existing components and tokens. One request body file per endpoint, form values in `_lib/utils`, React Query, types mapped at the API boundary, feature-only code inside the feature. Client validation checks format only; server rules stay in the API. Add `tests/int/*.int.spec.ts` for helpers and request bodies.
- Seed realistic local data for every new screen, through the API or the seed, so each state can be looked at.

## 4. Verify - loop until clean

Repeat until a full pass finds nothing:

1. **Static**: in each touched repo run the type check, `npm run lint` and the tests (fr-api `npm test`, fr-web `npm run test:int`). Flag any failure, even an unrelated one.
2. **Running app**: fr-api runs in Docker (`fr-api-api`, hot reload; after `.env` changes `docker compose up -d --no-deps --force-recreate api`; after schema changes run the migration and `npx prisma generate` inside the container). The hub is `http://hub.friendsresilience.test:3000`, the API `http://localhost:8848/api`. Sign in as the seed admin read from `fr-api/.env` without printing it.
3. **Browser**: load the `claude-in-chrome` skill and look at every changed screen in a new tab: the populated, empty, loading, error and long-text states, a narrow phone width, keyboard focus and dialogs. Compare against the Apple principles and the neighbouring screens, fix what looks off, and look again. Close the tabs afterwards.
4. **Black-box QA**: act as a user through the UI and the API - create, edit, delete, reorder, every validation error, permission edge cases (a user without the permission, a license user), and anything the wiki rules forbid. Fix every defect found.
5. **Codex review**: from `/Users/pragyan/Desktop/FR/Projects/friends-resilience`, run in the background:
   `codex exec --skip-git-repo-check -s read-only "<prompt>" < /dev/null > <scratchpad>/codex-review.txt 2>&1`
   The prompt names the uncommitted diff of each repo (`git -C <repo> diff` and untracked files), asks it to read each repo's `AGENTS.md` and the code architecture document first, and to report bugs, regressions, security issues and convention breaks ranked by severity with file:line and a failure scenario, changing no files. The `< /dev/null` stops it waiting on stdin. Verify each finding before acting on it, fix the real ones, and rerun the static checks.

## 5. Report

End with: what was built in each repo, every decision taken with its reason, what was verified and how (tests counts, screens looked at, QA cases, Codex findings and what was done about each), anything left open, and the local data seeded. Point to the wiki documents written.

## Standing rules

- **Never commit or push** until the user asks for that specific commit. They review first. When asked, follow the conventional commit style of the repo, one logical change per commit, and no co-author line.
- fr-api changes beyond the requested feature need the user's approval first.
- Never use the em dash; use a plain dash. Never hard-wrap markdown. Never write requirement IDs (such as CUR-061) in code or comments; state the reason instead.
- Comments explain why, one per section, not over-commented. Names are specific. Confirm before renaming something the user named.
- Never enter, print or commit real credentials, tokens or secrets.
- Ask before starting anything that spawns a swarm of subagents.
