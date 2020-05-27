#!/bin/bash

# Add welcome message for SSH
cp /vagrant/conf/motd.txt /etc/motd

# Add EPEL yum Repositories
echo "Boot.01: installing epel repos....."
yum install -y epel-release
echo "Boot.01: ..........................................done"

# Update core packages
echo "Boot.02: Updating....."
yum update -y
yum clean all
echo "Boot.02: ...........................................done"

# Install system tools
echo "Boot.03: Installing system tools"
yum install -y wget curl net-tools lsof bash-completion psmisc yum-utils expect pygpgme
echo "Boot.03: ..............................................done"

# Install semanage
echo "Boot.04: Installing semanage"
yum install -y policycoreutils-python
echo "Boot.04: ...............................................done"


# Install Apache
echo "Boot.05: Installing Apache"
yum install -y httpd
yum install -y mod_ssl openssl
echo "Boot.05:................................................done"

# Install PHP 7.3
echo "Boot.06: Installing PHP 7.3"
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php73
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
php -v
echo "Boot.06:..................................................done"

# Install MySQL 5.7.30
echo "Boot.07: Installing MySQL 5.7.30"
cd /tmp
cp /vagrant/data/mysql57-community-release-el7-9.noarch.rpm .
yum localinstall -y mysql57-community-release-el7-9.noarch.rpm
yum install -y mysql-community-server
rm -rf mysql57-community-release-el7-9.noarch.rpm
echo "MySQL.01:..................................................done"
