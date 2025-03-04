#!/bin/bash


echo "====== Server Performance Stats ======"

# --- CPU Usage ---
# Get the idle CPU percentage from top and calculate total usage
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | sed 's/id,//')
cpu_usage=$(echo "100 - $cpu_idle" | bc)
echo ""
echo "Total CPU Usage: $cpu_usage%"

# --- Memory Usage ---
# Get memory info from free command (in MB)
mem_info=$(free -m | grep Mem:)
total_mem=$(echo $mem_info | awk '{print $2}')
used_mem=$(echo $mem_info | awk '{print $3}')
mem_percent=$(echo "scale=2; $used_mem/$total_mem*100" | bc)
echo ""
echo "Total Memory Usage: Used: ${used_mem}MB / Total: ${total_mem}MB (${mem_percent}%)"

# --- Disk Usage ---
# Get disk usage info for the root filesystem
disk_info=$(df -h / | tail -1)
disk_used=$(echo $disk_info | awk '{print $3}')
disk_total=$(echo $disk_info | awk '{print $2}')
disk_percent=$(echo $disk_info | awk '{print $5}')
echo ""
echo "Disk Usage (Root Filesystem): Used: $disk_used / Total: $disk_total ($disk_percent)"

# --- Top Processes by CPU Usage ---
echo ""
echo "Top 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6

# --- Top Processes by Memory Usage ---
echo ""
echo "Top 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6

echo ""
echo "========================================"

