
#!/bin/bash

# Configuration
SERVICE="nginx"
EMAIL="admin@example.com"
HOSTNAME=$(hostname)
LOG_FILE="/var/log/nginx_monitor.log"

# Check Nginx service status
if systemctl is-active --quiet "$SERVICE"; then

    echo "$(date): Nginx is running on $HOSTNAME" >> "$LOG_FILE"

else

    echo "$(date): Nginx is stopped. Attempting restart..." >> "$LOG_FILE"

    # Attempt to start Nginx
    systemctl start "$SERVICE"

    # Verify service status
    if systemctl is-active --quiet "$SERVICE"; then

        SUBJECT="ALERT: Nginx Restarted Successfully - $HOSTNAME"

        BODY="Hello Team,
Nginx service was found stopped.
Automatic recovery was successful.
Server: $HOSTNAME
Service: $SERVICE
Status: Running
Action: Service started successfully
Time: $(date)
Regards,
Monitoring Script"

    else
        SUBJECT="CRITICAL: Nginx Failed to Start - $HOSTNAME"
        BODY="Hello Team,
Nginx service was found stopped.
Automatic restart FAILED.
Server: $HOSTNAME
Service: $SERVICE
Status: Failed
Time: $(date)
Please investigate immediately.
Regards,
Monitoring Script"

    fi

    # Send email notification
    echo "$BODY" | mail -s "$SUBJECT" "$EMAIL"

fi
