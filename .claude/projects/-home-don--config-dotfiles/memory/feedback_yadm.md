---
name: Always use yadm, never git
description: In this dotfiles repo, use yadm for all git operations — never plain git
type: feedback
originSessionId: 4aadb7c2-6656-4d2a-9b43-39d5bb33c40f
---
Always use `yadm` for all git operations (log, diff, status, add, commit, push, etc.). Never use `git` directly.

**Why:** The working tree is $HOME and the bare repo is at ~/.local/share/yadm/repo.git. Plain `git` fails with "not a git repository." This has caused tool-call rejections when `git` was used instead of `yadm`.

**How to apply:** Any time you'd reach for `git` in this project, use `yadm` instead. No exceptions, even for read-only operations like `git log`.
