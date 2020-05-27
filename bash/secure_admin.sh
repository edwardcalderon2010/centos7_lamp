#!/bin/bash

# Add a secure (super) user
echo "Secure.01: Creating super user"
groupadd adm_devops
useradd adm_devops -g adm_devops -G wheel
usermod -aG apache adm_devops
echo "adm_devops" | passwd --stdin adm_devops
sudo echo "%adm_devops ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/adm_devops
echo 'alias la="ls -altr"' >> /home/adm_devops/.bashrc
echo "Secure.01: .....................done"

# Enable passwordless SSH access
echo "Secure.02: Installing SSH key"
mkdir -p /home/adm_devops/.ssh
cat /vagrant/conf/centos7_lamp_ssh.pub > /home/adm_devops/.ssh/authorized_keys
chown -R adm_devops:adm_devops /home/adm_devops/.ssh
chmod -R u=rwX,go= /home/adm_devops/.ssh
echo "Secure.02: .................done"

# Enable & configure firewall
echo "Secure.03: Configuring firewall"
systemctl enable firewalld
systemctl start firewalld
echo "Secure.03: .................done"

# Enable SELinux
echo "Secure.04: Configuring SELiniux"
#sestatus
#getenforce
#setenforce 0
#setenforce 1
#sestatus
echo "Secure.04: ......................done"

# Configure secure SSH
echo "Secure.05: Securing SSHD"
setenforce 0
sed -i 's/#Port 22/Port 63717/g' /etc/ssh/sshd_config
semanage port -a -t ssh_port_t -p tcp 63717
firewall-cmd --zone=public --add-port=63717/tcp --permanent
firewall-cmd --remove-service ssh --permanent
firewall-cmd --reload
systemctl restart sshd
setenforce 1
echo "Secure.05: ..........................done"

