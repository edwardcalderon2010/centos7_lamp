#!/bin/bash

# Configure MySQL 5.7
echo "MySQL.01: Configuring MySQL 5.7"
cd /tmp
systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld
cp /vagrant/bash/auto_install_mysql_secure.sh .
chmod +x auto_install_mysql_secure.sh
./auto_install_mysql_secure.sh "21#AryaTara"
rm -rf auto_install_mysql_secure.sh
echo "MySQL.01:.......................done"
