# Install PHP 7.3
echo "Install PHP.01: Installing PHP 7.3"
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Import Remi GPG key
rpm --import /etc/pki/rpm-gpg/*
rpm -q gpg-pubkey --qf '%{NAME}-%{VERSION}-%{RELEASE}\t%{SUMMARY}\n'
gpg --list-keys

# Enable Remi repo & install PHP
yum-config-manager --enable remi-php73
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
php -v
echo "Install PHP.01:..................................................done"
