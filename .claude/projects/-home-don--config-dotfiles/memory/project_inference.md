---
name: Inference node — vedfolnir00
description: vedfolnir00 is live; inference role has ollama, ROCm, cockpit, NPU tasks (LiteLLM removed)
type: project
originSessionId: db8085c4-ea8e-490d-9343-0845db0377ea
---
vedfolnir00 (Framework Desktop, Ryzen AI Max+ 395, 128GB) is the inference node.
Tailscale IP: `100.115.44.2`

Inference role is implemented with:
- ROCm (gfx1151, sg_display=0, gttsize=118784)
- Ollama (accessible at 100.115.44.2:11434 over Tailscale)
- Cockpit
- NPU via Lemonade (disabled pending gfx1151 validation)

LiteLLM proxy was removed 2026-05-10 — Ollama is now directly accessible on the Tailscale IP.

**How to apply:** vedfolnir00 Tailscale IP is 100.115.44.2 — don't ask the user for it again.
