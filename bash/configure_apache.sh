#!/bin/bash

# Configure Apache
echo "Apache.01: Configuring"
systemctl enable httpd
systemctl start httpd
systemctl status httpd
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --reload
echo "Apache.01:......................done"
