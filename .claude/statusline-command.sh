#!/usr/bin/env bash
# Claude Code status line - derived from ~/.bashrc PS1
# Original PS1: \[\033[01;32m\]\u@\h\[\033[00m\][L${SHLVL}|?$?]:\[\033[01;34m\]\w\[\033[00m\]\n\$
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Build the PS1-derived left portion (unchanged)
left=$(printf '\033[01;32m%s@%s\033[00m[L%s]:\033[01;34m%s\033[00m' \
  "$(whoami)" "$(hostname -s)" "${SHLVL:-1}" "$cwd")

# Build the right portion: context usage %, session cost, and rate limits
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost_usd=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

right=""
if [ -n "$used_pct" ] || [ -n "$cost_usd" ] || [ -n "$five_pct" ] || [ -n "$week_pct" ]; then
  pct_str=""
  cost_str=""
  five_str=""
  week_str=""
  [ -n "$used_pct" ] && pct_str=$(printf '%.0f%%' "$used_pct")
  [ -n "$cost_usd" ] && cost_str=$(printf '$%.2f' "$cost_usd")
  [ -n "$five_pct" ] && five_str=$(printf '5h:%.0f%%' "$five_pct")
  if [ -n "$week_pct" ]; then
    if [ -n "$week_resets" ]; then
      week_reset_label=$(date -d "@${week_resets}" '+%b-%d' 2>/dev/null || date -r "${week_resets}" '+%b-%d' 2>/dev/null)
      week_str=$(printf '7d:%.0f%% %s' "$week_pct" "${week_reset_label:+(→${week_reset_label})}")
    else
      week_str=$(printf '7d:%.0f%%' "$week_pct")
    fi
  fi

  inner=""
  for part in "$pct_str" "$cost_str" "$five_str" "$week_str"; do
    [ -z "$part" ] && continue
    if [ -z "$inner" ]; then
      inner="$part"
    else
      inner="${inner} | ${part}"
    fi
  done

  # Dim/neutral color (dark gray): \033[02;37m ... \033[00m
  right=$(printf ' \033[02;37m[%s]\033[00m' "$inner")
fi

printf '%s%s' "$left" "$right"
