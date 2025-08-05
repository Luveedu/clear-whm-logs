#!/bin/bash

echo "Starting log file and backup cleanup..."

# Step 1: Truncate error_log, access_log, and other *.log files in /home
echo "---"
echo "Truncating log files in /home..."
find /home -type f \( -name "error_log" -o -name "access_log" -o "*.log" \) -exec sh -c 'echo "Truncating: $1"; > "$1"' sh {} \;
sleep 1

# Step 2: Remove Softaculous WordPress backup files
echo "---"
echo "Removing Softaculous WordPress backup files..."
find /home -type f -path "*/softaculous_backups/wp.*.tar.gz" -exec rm -v {} \;
sleep 1

# Step 3: Remove cPanel user backup files
echo "---"
echo "Removing cPanel user backup files..."
for user in `/bin/ls -A /var/cpanel/users` ; do
    echo "Checking for backup files for user: $user"
    rm -fv /home/$user/backup-*$user.tar.gz
done
sleep 1

# Step 4: Remove cPanel temporary files
echo "---"
echo "Removing cPanel temporary files..."
rm -fv /home/*/tmp/Cpanel_*
sleep 1

echo "---"
echo "Thank You all Log files cleared"
echo "Cleanup complete!"
