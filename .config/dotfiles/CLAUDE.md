Working directory is ~/.config/dotfiles. Do not make changes outside this directory.

## Version control

This repo is managed with **yadm**, not plain git. The working tree is `$HOME`; the bare repo is at `~/.local/share/yadm/repo.git`. Always use `yadm` for all git operations (status, add, commit, log, push, etc.). Plain `git` commands will fail with "not a git repository."

## Task runner

**babashka (`bb`)** is the task runner. Key tasks defined in `bb.edn`:

| Task | What it does |
|---|---|
| `bb install-common` | `ansible-playbook main.yml --tags common` (base + neovim) |
| `bb install-workstation` | common + workstation + DE play for this machine |
| `bb install-inference` | common + inference plays for this machine |
| `bb install-all` | All applicable plays for this machine (no tag filter) |
| `bb test-build` | Build the Docker test image |
| `bb test-check` | Dry-run of the common play in Docker |
| `bb test-syntax` | Syntax-only check in Docker |
| `bb test-clean` | Remove the Docker test image |

## Play structure

`main.yml` has five plays:

| Play | `hosts:` | Roles | Tag |
|---|---|---|---|
| Common | `managed` | base, neovim | `common` |
| Workstation | `workstations` | babashka, workstation | `workstation` |
| GNOME Desktop | `gnome` | gnome | `gnome` |
| COSMIC Desktop | `cosmic` | cosmic | `cosmic` |
| Inference | `inference` | inference | `inference` |

Inventory groups: `managed` (parent of all), `workstations`, `inference`, `gnome`, `cosmic`. DE groups are orthogonal to function groups — a host belongs to exactly one DE group.

## Per-host app overrides

`roles/workstation/defaults/main.yml` — all opt-in (false).
`inventory/group_vars/workstations.yml` — fleet defaults (most enabled).
`inventory/host_vars/<hostname>.yml` — per-host overrides (disable specific apps).

## Testing

`bb test-check` runs `--check --tags common --skip-tags snap,flatpak` inside Docker. It covers the base + neovim roles only. The workstation, gnome, cosmic, and inference plays cannot run in Docker.

The Dockerfile pre-installs Docker and GitHub CLI GPG keys/repos and keeps apt lists so the Python apt library can resolve all packages in check-mode. Font sentinel files and a stub nvim AppImage are pre-created so check-mode's simulated tasks don't leave dependents with missing paths.

## Running the playbook locally

`bb install-workstation` and `bb install-inference` prompt for a sudo password and require a real TTY. The `!` prefix in Claude Code cannot handle the prompt. Run in a regular terminal:

```
bb install-workstation 2>&1 | tee /tmp/ansible-run.log
```

Then read `/tmp/ansible-run.log` to review results.

## Planned work

- **vedfolnir00 COSMIC role:** `roles/cosmic/` exists and installs wl-clipboard + deploys COSMIC Terminal font config. The RON template at `roles/cosmic/templates/cosmic-term-v1.ron.j2` needs verification on a live COSMIC session before trusting its schema.
- **vedfolnir00 Tailscale IPs:** `inventory/host_vars/vedfolnir00.yml` has `ollama_listen_address` and `cockpit_bind_address` set to `127.0.0.1`/empty. Update with the actual Tailscale IP once known.
- **ROCm version pin:** `roles/inference/tasks/rocm.yml` targets ROCm 6.3 / noble. Update the repo URL when upgrading.
- **NPU:** `inference_enable_npu: false` in vedfolnir00 host_vars. Enable once Lemonade/FastFlowLM is validated on gfx1151.
