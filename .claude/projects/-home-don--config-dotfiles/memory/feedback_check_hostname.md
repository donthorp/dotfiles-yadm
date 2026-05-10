---
name: Check host before SSH
description: Check current hostname before attempting SSH to avoid connecting to yourself
type: feedback
originSessionId: 76c837a4-8bfb-4130-bbb2-1abfd7c31fc3
---
Before using SSH to reach a host, check the current hostname. If already on that host, run commands directly.

**Why:** Wasted a round trip trying to SSH to vedfolnir00 from vedfolnir00.

**How to apply:** When about to `ssh <host>`, check `hostname` or the environment first. If the target matches the current host, run the command locally instead.
