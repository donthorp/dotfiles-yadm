#!/usr/bin/env bash
# Collects a hardware/software snapshot of the local machine and prints markdown to stdout.
# Usage: sudo system-report.sh [> output.md]

run() {
    local label="$1"; shift
    echo "### $label"
    echo '```'
    "$@" 2>&1 || echo "NOT AVAILABLE"
    echo '```'
    echo
}

run_or() {
    # Like run, but prints a note when the command is missing
    local label="$1"
    local note="$2"; shift 2
    echo "### $label"
    echo '```'
    if command -v "$1" &>/dev/null || [[ "$1" == /* ]] || [[ "$1" == ./* ]]; then
        "$@" 2>&1 || echo "NOT AVAILABLE — command failed"
    else
        echo "NOT AVAILABLE — $note"
    fi
    echo '```'
    echo
}

HOSTNAME_SHORT="$(hostname -s)"
NOW="$(date '+%Y-%m-%d %H:%M:%S %Z')"

echo "# ${HOSTNAME_SHORT} System Report"
echo "*Captured: ${NOW}*"
echo

# ---------------------------------------------------------------------------
echo "## System"
echo

run "Kernel version" uname -r
run "OS release" cat /etc/os-release
run "Active kernel parameters" cat /proc/cmdline
run "Memory overview" free -h
run "Root disk usage" df -h /
run "Uptime / load" uptime

# ---------------------------------------------------------------------------
echo "## GPU & Memory Configuration"
echo

run "modprobe.d settings" bash -c 'cat /etc/modprobe.d/*.conf 2>/dev/null || echo "No modprobe.d conf files found"'
run "GPU PCI detection" bash -c 'lspci | grep -i "vga\|display\|amd"'
run_or "Vulkan summary" "vulkaninfo not installed" vulkaninfo --summary
run "amdgpu VRAM/GTT dmesg" bash -c 'dmesg | grep -i amdgpu | grep -E "VRAM|GTT|GART|gtt|vram" | head -20'

# ---------------------------------------------------------------------------
echo "## ROCm Status"
echo

run_or "rocminfo" "ROCm not installed" bash -c 'rocminfo | grep -E "Name|Marketing|Max Clock|Compute Unit" | head -20'
run_or "rocm-smi" "ROCm not installed" rocm-smi
run "/opt/rocm presence" bash -c 'ls /opt/rocm* 2>/dev/null || echo "No ROCm in /opt"'

# ---------------------------------------------------------------------------
echo "## Ollama"
echo

run_or "Ollama version" "ollama not in PATH" ollama --version
run "Ollama service status" systemctl status ollama --no-pager
run "Ollama service file" bash -c 'systemctl cat ollama 2>/dev/null || echo "No ollama unit file"'
run_or "Installed models" "ollama not in PATH" ollama list
run "~/.ollama contents" bash -c 'ls -la ~/.ollama/ 2>/dev/null || echo "No ~/.ollama directory"'

# ---------------------------------------------------------------------------
echo "## llama.cpp"
echo

run "llama.cpp binaries in PATH" bash -c 'which llama-cli llama-server llama-bench 2>/dev/null || echo "No llama.cpp binaries in PATH"'
run "llama.cpp binary search" bash -c 'find /opt /usr/local /home -name "llama-cli" -o -name "llama-server" 2>/dev/null | head -10 || echo "None found"'

# ---------------------------------------------------------------------------
echo "## Network"
echo

run "Hostname (FQDN)" hostname -f
run "IP addresses" bash -c 'ip addr show | grep -E "inet |^[0-9]"'
run_or "Tailscale status" "tailscale not installed" bash -c 'tailscale status | head -20'

# ---------------------------------------------------------------------------
echo "## Performance Profile"
echo

run_or "tuned active profile" "tuned not installed" tuned-adm active
run "CPU frequency governor" bash -c 'cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "cpufreq governor not readable"'

# ---------------------------------------------------------------------------
echo "## Memory by Process (>100 MB total RSS)"
echo

run "Aggregated RSS" bash -c 'ps -eo comm,rss | awk '\''NR>1 {rss[$1]+=$2; cnt[$1]++}
  END {for (p in rss) if (rss[p]>102400)
    printf "%s: %.1f GB (%d procs)\n", p, rss[p]/1048576, cnt[p]}'\'' | sort -t: -k2 -rn'

# ---------------------------------------------------------------------------
echo "## Running Services (selected)"
echo

run "Relevant running units" bash -c 'systemctl list-units --state=running --no-pager | grep -E "ollama|cockpit|rustdesk|tailscale" || echo "None matched"'
