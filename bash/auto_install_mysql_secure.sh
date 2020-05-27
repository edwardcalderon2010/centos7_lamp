#!/bin/bash

#
# Automate mysql secure installation for RHEL based- systems
# 

TEMP_INIT_PASSWORD=$(cat /var/log/mysqld.log | grep password | head -n1 | awk '{print $NF}')
NEW_MYSQL_PASSWORD="${1}"

# The existing password for the user account root has expired. Please set a new password.
#expect \"Change the password for root ?\"
#send \"y\r\"
#expect \"Do you wish to continue with the password provided?\"
#send \"y\r\"


SECURE_MYSQL=$(expect -c "
set timeout 3
spawn mysql_secure_installation
expect \"Enter password for user root:\"
send \"$TEMP_INIT_PASSWORD\r\"
expect \"New password:\"
send \"$NEW_MYSQL_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$NEW_MYSQL_PASSWORD\r\"
expect \"Change the password for root ?\"
send \"n\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

#
# Execution mysql_secure_installation
#
echo "${SECURE_MYSQL}"

exit 0