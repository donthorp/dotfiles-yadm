---
name: Dotfiles tooling
description: yadm manages the dotfiles git repo; babashka (bb) is the task runner; plain git commands won't work here
type: project
originSessionId: acc21912-1bd5-49fb-ba5e-cf6aa417e661
---
**yadm** is used for dotfiles management. The working tree is `$HOME`; the bare repo lives at `~/.local/share/yadm/repo.git`. Always use `yadm` instead of `git` for status, add, commit, log, push, etc. Plain `git` commands fail with "not a git repository."

**babashka (bb)** is the task runner. Tasks are defined in `~/.config/dotfiles/bb.edn`:
- `bb install-base` — runs `ansible-playbook main.yml --tags base`
- `bb install-workstation` — runs `ansible-playbook main.yml --tags base,workstation`
- `bb test-build` — builds the Docker test image
- `bb test-check` — dry-run of the base play in Docker
- `bb test-syntax` — syntax-only check in Docker
- `bb test-clean` — removes the Docker test image

**Why:** yadm was chosen to manage dotfiles as a git repo without a separate clone directory. bb replaces make/shell scripts with a Clojure-flavored task runner.

**How to apply:** Always use `yadm <git-subcommand>` for version control operations in this repo.
