#!/bin/bash

# Function to execute a command with a 1-second delay
execute_with_delay() {
    echo "Executing: $1"
    eval "$1"
    sleep 1
    echo ""
}

# Clear log files
execute_with_delay 'find /home -type f \( -name "error_log" -o -name "access_log" -o -name "*.log" \) -exec sh -c '\''echo "Truncating: $1"; > "$1"'\'' sh {} \;'

# Remove softaculous backups
execute_with_delay 'find /home -type f -path "*/softaculous_backups/wp.*.tar.gz" -exec rm -v {} \;'

# Remove user backups
execute_with_delay 'for user in `/bin/ls -A /var/cpanel/users` ; do rm -fv /home/$user/backup-*$user.tar.gz ; done'

# Remove Cpanel temp files
execute_with_delay 'rm -fv /home/*/tmp/Cpanel_*'

# Final message
echo "Thank You all Log files cleared"
