#!/bin/bash

# Configure Apache SSL
echo "Apache_SSL.01: Configuring SSL"
cd /tmp
openssl genrsa -out ca.key 2048 
/vagrant/bash/ssl_csr_gen.exp
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy the files to the correct locations
cp ca.crt /etc/pki/tls/certs
cp ca.key /etc/pki/tls/private/ca.key
cp ca.csr /etc/pki/tls/private/ca.csr
restorecon -RvF /etc/pki

cp /vagrant/data/welcome_ssl.conf /etc/httpd/conf.d/

cd /var/www/html
cp /vagrant/data/welcome_html.gzip .
tar -xvzf welcome_html.gzip
rm -rf welcome_html.gzip
chgrp -R apache welcome/
chmod -R g+w welcome/

firewall-cmd --add-service https --zone=public --permanent
firewall-cmd --reload
firewall-cmd --list-all --zone=public
iptables-save | grep tcp

echo "Apache_SSL.01: ...........................................done"
