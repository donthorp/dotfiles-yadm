---
name: Local Ansible run needs a real TTY
description: The ! prefix in Claude Code can't handle Ansible's become password prompt — use a real terminal
type: feedback
originSessionId: acc21912-1bd5-49fb-ba5e-cf6aa417e661
---
`bb install-workstation` (and any Ansible playbook with `become_ask_pass=True`) requires a real TTY for the sudo password prompt. Running it via the `!` prefix in Claude Code fails with "sudo: a password is required" because the pseudo-TTY can't echo the password correctly.

**Why:** `ansible.cfg` has `become_ask_pass=True`. Python's `getpass` falls back to echoing input when it can't control the TTY, and the prompt either doesn't get a response or gets an empty one.

**How to apply:** Tell the user to run `bb install-workstation 2>&1 | tee /tmp/ansible-run.log` in a real terminal, then read `/tmp/ansible-run.log` to review output.
