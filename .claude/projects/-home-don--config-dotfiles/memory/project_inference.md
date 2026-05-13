---
name: Inference node — vedfolnir00
description: vedfolnir00 is live; inference role has ollama, ROCm, cockpit, NPU tasks (LiteLLM removed)
type: project
originSessionId: db8085c4-ea8e-490d-9343-0845db0377ea
---
vedfolnir00 (Framework Desktop, Ryzen AI Max+ 395, 128GB) is the inference node.
Tailscale IP: `100.115.44.2`

**Confirmed live state (2026-05-13 audit):**
- Kernel 6.17.0-23-generic (HWE) — already installed, planned work item is DONE
- ROCm 6.3.0 at /opt/rocm-6.3.0 — functional, rocminfo sees 40-CU GPU as gfx1101 (compatibility target for gfx1151)
- GTT allocation: 118784 MB set via kernel cmdline (not modprobe.d)
- Ollama 0.23.2 running, bound to 100.115.44.2:11434, OLLAMA_MODELS=/home/don/.ollama/models
- CPU governor: powersave (needs to be set to performance)
- /opt/rocm/bin not in system PATH (rocm-smi unreachable)
- NPU via Lemonade disabled pending gfx1151 validation
- LiteLLM removed 2026-05-10

**How to apply:** vedfolnir00 Tailscale IP is 100.115.44.2 — don't ask the user for it again.
HWE kernel install is no longer a TODO. Remaining priorities: CPU governor fix, ROCm PATH, gfx1101 vs gfx1151 ROCm target investigation.
