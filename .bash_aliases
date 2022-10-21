#! /usr/bin/env bash

alias aws='docker run --rm -ti -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli'
alias bb-nrepl='bb nrepl-server 127.0.0.1:1667'
alias bb-repl='rlwrap bb repl'
alias clear-dns-cache='sudo systemd-resolve --flush-caches'
alias cz=chezmoi
alias espanso-reregister='espanso service unregister && espanso service register'
alias my-ip="curl https://api.ipify.org"

# USG Status
alias 'usg-status'="ssh -t 10.10.0.1 \"vbash -ic 'show load-balance status; show load-balance watchdog'\""

# I prefer macos clipboard CLI names
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# Python
export PIPX_BIN_DIR=~/bin

alias python="/usr/bin/env python3"
alias pip="/usr/bin/env pip3"
alias svenv="source venv/bin/activate"

# Tradeswell 
alias tw-gh-my-reviews='gh search prs --review-requested="@me" --sort="created" --state=open --limit=100 "org:Tradeswell"'
alias tw-gh-repos="gh repo list Tradeswell --limit 100 | grep ^Tradeswell | cut -f 1 | sed -e 's/Tradeswell\///' | sort"
alias tw-gh-settings-all="tw-gh-repos | xargs -n 1 -I % echo - \[ \] \[%\]\(https://github.com/Tradeswell/%/settings\) | pbcopy"

alias tw-open-prs="gh repo list Tradeswell --limit=100 --json name,pullRequests | jq -r '.[] | select(.pullRequests .totalCount > 0) | .name + \" \" + (.pullRequests.totalCount | tostring)' | sort | awk 'BEGIN{printf \" PR  Repo\n---- --------------------\n\"} { printf \"%4d %-30s\n\", \$2, \$1 }'"

