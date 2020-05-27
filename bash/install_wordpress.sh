#!/bin/bash

# Install WordPress
echo "WordPress.01: Installing......................."
cd /var/www/html/

# Download and extract wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm -rf latest.tar.gz

# Insert the basic .htaccess file
cp /vagrant/conf/.htaccess wordpress/

echo "WordPress.01: ......................................done"

# Configure WordPress
echo "WordPress.02: Configuring......................."
cd /var/www/html/

# Insert the wordpress apache conf
cp /vagrant/conf/wp.conf /etc/httpd/conf.d/

# Insert the wp-config.php file
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Set appropriate directory permissions for the apache user
chown -R apache:apache wordpress/
chmod -R 755 wordpress/

# Create wordpress db and user
cp /vagrant/conf/root.cnf ~/.my.cnf
chmod 600 ~/.my.cnf
mysql < /vagrant/conf/create_wp_db.sql

cd /var/www/html/
sed -i 's/database_name_here/wp_db/g' wordpress/wp-config.php
sed -i 's/username_here/wp_user/g' wordpress/wp-config.php
sed -i 's/password_here/Ma#a5idd#a/g' wordpress/wp-config.php

echo "WordPress.02: ......................................done"

