---
name: Inference node — vedfolnir00
description: vedfolnir00 is live; inference role exists with ollama, ROCm, LiteLLM, cockpit, NPU tasks
type: project
originSessionId: db8085c4-ea8e-490d-9343-0845db0377ea
---
vedfolnir00 (Framework Desktop, Ryzen AI Max+ 395, 128GB) is the inference node.
Tailscale IP: `100.115.44.2`

Inference role is implemented with:
- ROCm (gfx1151, sg_display=0, gttsize=118784)
- Ollama (listens on 127.0.0.1:11434 locally; also reachable on 100.115.44.2:11434 via Tailscale)
- LiteLLM proxy (listens on 100.115.44.2:4000 — bridges Anthropic API format to local ollama/lemonade)
- Cockpit
- NPU via Lemonade (disabled pending gfx1151 validation)

**Why:** LiteLLM is needed so Claude Code on other nodes (e.g. boros03) can point ANTHROPIC_BASE_URL at vedfolnir00 and use local qwen models.

**How to apply:** From boros03: `ANTHROPIC_BASE_URL=http://100.115.44.2:4000 claude`. vedfolnir00 Tailscale IP is 100.115.44.2 — don't ask the user for it again.
