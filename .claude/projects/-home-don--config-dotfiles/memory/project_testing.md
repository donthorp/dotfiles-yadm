---
name: Ansible test workflow
description: Docker tests only cover the base play; workstation play requires a real machine with GNOME
type: project
originSessionId: acc21912-1bd5-49fb-ba5e-cf6aa417e661
---
**Docker test (`bb test-check`)** runs `ansible-playbook --check --tags base --skip-tags snap,flatpak`. It covers the base + neovim + babashka roles only.

The workstation play cannot run in Docker because it requires:
- A live GNOME session for `dconf` tasks
- `flatpak` / Flathub
- `snap` / snapd

**Why snap/flatpak are skipped:** They have `tags: [base, snap]` / `tags: flatpak` so `--skip-tags snap,flatpak` excludes them cleanly.

**Why check-mode works now:** The Dockerfile pre-installs Docker + GH CLI GPG keys/repos and keeps apt lists (no `rm -rf /var/lib/apt/lists/*`), so the Python apt library can resolve all packages. Font sentinel files and a stub nvim AppImage are pre-created so check-mode's simulated tasks don't leave dependents with missing paths. `check_mode: false` on `Update apt cache` ensures the cache is actually refreshed.

**Full local run:** `bb install-workstation 2>&1 | tee /tmp/ansible-run.log` — run in a real terminal (not via `!`). After it finishes, read `/tmp/ansible-run.log` to review results.

**How to apply:** Use `bb test-check` for quick CI-style validation. Use `bb install-workstation` on the real machine to validate workstation tasks.
