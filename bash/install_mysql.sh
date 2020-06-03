# Install MySQL 5.7.30

echo "Mysql.01: Installing MySQL public key"
#gpg --recv-keys 5072E1F5
#gpg --armor --output mysql_public_key.asc --export mysql-build@oss.oracle.com
#rpm --import mysql_public_key.asc
cd /tmp
cp /vagrant/data/mysql57-community-release-el7-9.noarch.rpm .
yum localinstall -y mysql57-community-release-el7-9.noarch.rpm
rpm --import /etc/pki/rpm-gpg/*mysql
rm -rf mysql57-community-release-el7-9.noarch.rpm
echo "MySQL.01:..................................................done"


echo "Mysql.02: Installing MySQL 5.7.30"
cd /tmp
wget --quiet http://repo.mysql.com/yum/mysql-5.7-community/el/7/x86_64/mysql-community-server-5.7.30-1.el7.x86_64.rpm
rpm --checksig mysql-community-server-5.7.30-1.el7.x86_64.rpm
yum localinstall -y mysql-community-server-5.7.30-1.el7.x86_64.rpm
rm -rf mysql-community-server-5.7.30-1.el7.x86_64.rpm
echo "MySQL.02:..................................................done"
