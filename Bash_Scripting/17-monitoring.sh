#!/bin/bash

# Current date and time
DATE=$(date '+%Y-%m-%d %H:%M:%S')

#CPU Usage
CPU=$(top -bn1 |grep "Cpu(s)" |awk '{print $2+$4}')

# Memory Usage
MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

# Disk Usage
DISK_USAGE=$(df -h | awk '$NF=="/"{printf "%s", $5}')

if["$CPU" -gt 80] || ["$MEMORY_USAGE" -gt 80] || ["$DISK_USAGE" -gt 80]; then
    echo "Warning: High resource usage detected!"
    echo "CPU Usage: $CPU%"
    echo "Memory Usage: $MEMORY_USAGE%"
    echo "Disk Usage: $DISK_USAGE"
    MESSAGE="ALERT: Memory usage is ${MEMORY_USAGE}% on $(hostname) at ${DATE}"
    echo "$MESSAGE" >> /var/log/resource_monitor.log

    echo  "$MESSAGE" | mail -s "High Memory Usage Alert - $(hostname)" your-email@example.com
    # Optional: AWS SNS
    # aws sns publish \
    # --topic-arn arn:aws:sns:region:account-id:MemoryAlerts \
    # --message "$MESSAGE"
else
    echo "Resource usage is within normal limits."
fi
