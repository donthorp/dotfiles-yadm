# Global Claude Code Context

## Inference (vedfolnir00)

vedfolnir00: Framework Desktop, Ryzen AI Max+ 395 (gfx1151), 128GB LPDDR5x.

- **LiteLLM proxy**: `100.115.44.2:4000` — Anthropic-format gateway over Tailscale
- **Ollama**: localhost only (not directly reachable from other nodes)

Use Claude Code against vedfolnir00 models from any node:

```bash
ANTHROPIC_BASE_URL=http://100.115.44.2:4000 claude
```
