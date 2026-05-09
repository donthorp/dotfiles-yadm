Working directory is ~/.config/dotfiles. Do not make changes outside this directory.

## Version control

This repo is managed with **yadm**, not plain git. The working tree is `$HOME`; the bare repo is at `~/.local/share/yadm/repo.git`. Always use `yadm` for all git operations (status, add, commit, log, push, etc.). Plain `git` commands will fail with "not a git repository."

## Task runner

**babashka (`bb`)** is the task runner. Key tasks defined in `bb.edn`:

| Task | What it does |
|---|---|
| `bb install` | All applicable plays for this machine (driven by inventory) |
| `bb install-common` | Common play only (base + neovim) |
| `bb install-workstation` | Workstation + DE plays only |
| `bb install-inference` | Inference play only |
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

- **HWE kernel selection:** vedfolnir00 (gfx1151/Strix Point) needs `linux-image-generic-hwe-24.04` (6.17) for ROCm render node support — stock 6.8 doesn't create `/dev/dri/renderD*`. Add logic to the inference role (or base role) to detect GPU architecture and install the HWE kernel automatically during `bb install-inference`.
- **ROCm version pin:** `roles/inference/tasks/rocm.yml` targets ROCm 6.3 / noble. Update the repo URL when upgrading.
- **NPU:** `inference_enable_npu: false` in vedfolnir00 host_vars. Enable once Lemonade/FastFlowLM is validated on gfx1151.
