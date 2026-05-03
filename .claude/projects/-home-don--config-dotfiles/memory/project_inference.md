---
name: Inference node support — planned next step
description: Inventory has inference group stub; no play or role exists yet
type: project
originSessionId: acc21912-1bd5-49fb-ba5e-cf6aa417e661
---
`inventory/hosts.yml` has an `inference` group with hosts commented out, ready to fill in real GPU box details.

`main.yml` only has plays for `workstations`. An inference play targeting the `inference` group still needs to be written, along with any inference-specific roles (e.g., CUDA, GPU drivers, ML tooling).

**Why:** The branch `claude/review-ansible-config-tZRle` established the inventory scaffold and got the test harness working. Inference node provisioning is explicitly the next step.

**How to apply:** When starting inference node work, add real hosts to `inventory/hosts.yml` under `inference`, write an inference play in `main.yml`, and create any needed roles.
