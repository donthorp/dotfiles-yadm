Working directory is ~/.config/dotfiles. Do not make changes outside this directory.

## Version control

This repo is managed with **yadm**, not plain git. The working tree is `$HOME`; the bare repo is at `~/.local/share/yadm/repo.git`. Always use `yadm` for all git operations (status, add, commit, log, push, etc.). Plain `git` commands will fail with "not a git repository."

## Task runner

**babashka (`bb`)** is the task runner. Key tasks defined in `bb.edn`:

| Task | What it does |
|---|---|
| `bb install-base` | `ansible-playbook main.yml --tags base` |
| `bb install-workstation` | `ansible-playbook main.yml --tags base,workstation` |
| `bb test-build` | Build the Docker test image |
| `bb test-check` | Dry-run of the base play in Docker |
| `bb test-syntax` | Syntax-only check in Docker |
| `bb test-clean` | Remove the Docker test image |

## Testing

`bb test-check` runs `--check --tags base --skip-tags snap,flatpak` inside Docker. It covers the base + neovim + babashka roles only. The workstation play cannot run in Docker — it requires a live GNOME session (dconf), flatpak, and snap.

The Dockerfile pre-installs Docker and GitHub CLI GPG keys/repos and keeps apt lists so the Python apt library can resolve all packages in check-mode. Font sentinel files and a stub nvim AppImage are pre-created so check-mode's simulated tasks don't leave dependents with missing paths.

## Running the playbook locally

`bb install-workstation` prompts for a sudo password and requires a real TTY. The `!` prefix in Claude Code cannot handle the prompt. Run it in a regular terminal:

```
bb install-workstation 2>&1 | tee /tmp/ansible-run.log
```

Then read `/tmp/ansible-run.log` to review results.

## Planned work

- **Inference nodes:** `inventory/hosts.yml` has an `inference` group stub with hosts commented out. A play in `main.yml` targeting that group and inference-specific roles (CUDA, GPU drivers, ML tooling) still need to be written.
