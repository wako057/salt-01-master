#!/usr/bin/env bash

# Used
DEV_USERNAME='greg'
DEV_PASSWD='toto'
ROOT_PASSWD='toto42'
IP_LAN='10.0.0.50'

# Unused
PHP_VERSION='7.0.13'
PHP_INSTALL_DIR='/usr/local'
MYSQL_ROOT_PASSWD='toto42'
MYSQL_USER_LOGIN='greg'
MYSQL_USER_PASSWD='blublu'


###########################################
##### SYSTEM GENERAL ######################
###########################################

# Definition des mot de passe utilisateurs - on fait taire la bell-ring
echo -e "$ROOT_PASSWD\n$ROOT_PASSWD" | passwd --quiet  &> /dev/null 
useradd -mU -s /bin/bash $DEV_USERNAME 
echo -e "$DEV_PASSWD\n$DEV_PASSWD" | passwd --quiet $DEV_USERNAME &> /dev/null 
sed -i -e "s/\#\ set\ bell-style\ none/set\ bell-style\ none/g" /etc/inputrc ## petit goodies pour ne pas avoir de sonnette sur le bash windows
sed -i -e "s/XKBLAYOUT\=\"us\"/XKBLAYOUT\=\"fr\"/g" /etc/default/keyboard ## clavier FR
service keyboard-setup restart

# Personnalisation des comptes: bash vim
cp  /vagrant/misc/hosts /etc/hosts
# customisation prompt bash + aliases
cp  /vagrant/misc/bash_aliases_user /home/$DEV_USERNAME/.bash_aliases
cp  /vagrant/misc/bashrc_root  /root/.bashrc
# customisation vim 
cp  /vagrant/misc/vimrc  /root/.vimrc
cp  /vagrant/misc/vimrc  /home/$DEV_USERNAME/.vimrc

# creation  des reporte ssh et alimentation
mkdir -p /home/$DEV_USERNAME/.ssh
mkdir -p /root/.ssh
cp /vagrant/ssh/id_rsa* /root/.ssh/
cp /vagrant/ssh/id_rsa* /home/$DEV_USERNAME/.ssh/
cp /vagrant/ssh/config /home/$DEV_USERNAME/.ssh/config


cp /vagrant/ssh/id_rsa.pub  /home/$DEV_USERNAME/.ssh/authorized_keys

# Avec les bon droits
chown -R $DEV_USERNAME:$DEV_USERNAME /home/$DEV_USERNAME/.ssh
chmod 600 /home/$DEV_USERNAME/.ssh/id_rsa*
chown -R $DEV_USERNAME:$DEV_USERNAME /home/$DEV_USERNAME/
chmod 600 /root/id_rsa*

# On authorise le ssh par mot de passe en plus des clef SSH
sed -i -e "s/PasswordAuthentication\ no/PasswordAuthentication\ yes/g" /etc/ssh/sshd_config
/etc/init.d/ssh restart


###########################################
############ SALT #########################
###########################################
apt-get install -y linux-headers-$(uname -r)  curl chrony htop  vim
wget -O - https://repo.saltstack.com/apt/debian/8/amd64/2016.11/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo 'deb http://repo.saltstack.com/apt/debian/8/amd64/2016.11 jessie main' > /etc/apt/sources.list.d/saltstack.list
apt-get update
apt-get install -y salt-master salt-ssh salt-syndic salt-cloud salt-api
sed -i -e "s/\#interface\:\ 0\.0\.0\.0/interface\:\ $IP_LAN/g" /etc/salt/master


cd /srv/ 
git clone git@github.com:wako057/pillar.git
git clone git@github.com:wako057/salt.git



