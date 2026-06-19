# case is used when you need to compare one variable against multiple possible values. 
# It is cleaner than writing many if-elif-else statements.

# Syntax
case "$var" in
    value1)
        commands
        ;;
    value2)
        commands
        ;;
    *)
        commands
        ;;
esac

# 1. Menu Selection
read -p "Choose (start/stop/restart): " action

case "$action" in
    start) echo "Starting service" ;;
    stop) echo "Stopping service" ;;
    restart) echo "Restarting service" ;;
    *) echo "Invalid option" ;;
esac

# 2. OS Detection

case "$(uname)" in
    Linux) echo "Linux OS" ;;
    Darwin) echo "macOS" ;;
    *) echo "Unknown OS" ;;
esac

# 3. File Extension Handling
file="report.txt"

case "$file" in
    *.txt) echo "Text file" ;;
    *.sh) echo "Shell script" ;;
    *.log) echo "Log file" ;;
    *) echo "Unknown type" ;;
esac

# 4. Multiple Matching Patterns
case "$answer" in
    y|Y|yes|YES)
        echo "Proceeding"
        ;;
    n|N|no|NO)
        echo "Cancelled"
        ;;
esac

# 5. Command Line Arguments
case "$1" in
    start) service nginx start ;;
    stop) service nginx stop ;;
    status) service nginx status ;;
    *) echo "Usage: $0 {start|stop|status}" ;;
esac