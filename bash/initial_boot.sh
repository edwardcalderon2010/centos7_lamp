#!/bin/bash

# Add welcome message for SSH
rm -rf /etc/motd
cp /vagrant/conf/motd.txt /etc/motd

echo "Boot.01: Installing keys........................"
# Setup/prepare gpg conf
gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
gpg --quiet --with-fingerprint /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

# Install Official Centos keys
rpm --import /etc/pki/rpm-gpg/*
rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'
gpg --list-keys

# Install Fedora's Keys
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
curl https://getfedora.org/static/fedora.gpg | gpg --import
rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'
gpg --list-keys
echo "Boot.01: .......................................done"


# Add EPEL yum Repositories
echo "Boot.01a: installing epel repos....."
yum install -y epel-release
echo "Boot.01a: ..........................................done"

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

