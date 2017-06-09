#!/usr/bin/env bash

# Used
#DEV_USERNAME='dev'
#DEV_PASSWD='secrethardtofind'
ROOT_PASSWD='secrethardertofind'
IP_LAN='10.0.0.50'



###########################################
##### SYSTEM GENERAL ######################
###########################################

# Definition des mot de passe utilisateurs - on fait taire la bell-ring
echo -e "$ROOT_PASSWD\n$ROOT_PASSWD" | passwd --quiet  &> /dev/null 
#useradd -mU -s /bin/bash $DEV_USERNAME 
sed -i -e "s/\#\ set\ bell-style\ none/set\ bell-style\ none/g" /etc/inputrc ## petit goodies pour ne pas avoir de sonnette sur le bash windows
sed -i -e "s/XKBLAYOUT\=\"us\"/XKBLAYOUT\=\"fr\"/g" /etc/default/keyboard ## clavier FR
service keyboard-setup restart

# Personnalisation du compte root: bash vim
cp  /vagrant/misc/hosts /etc/hosts
cp  /vagrant/misc/bashrc  /root/.bashrc
cp  /vagrant/misc/vimrc  /root/.vimrc

###########################################
############ SALT #########################
###########################################
apt-get update
apt-get install -y linux-headers-$(uname -r)  curl chrony htop  vim
wget -O - https://repo.saltstack.com/apt/debian/8/amd64/2016.11/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/apt/debian/8/amd64/latest jessie main' > /etc/apt/sources.list.d/saltstack.list


#apt-get update
#apt-get install -y salt-master salt-ssh salt-syndic salt-cloud salt-api
apt-get install -y salt-master 
sed -i -e "s/\#interface\:\ 0\.0\.0\.0/interface\:\ $IP_LAN/g" /etc/salt/master
/etc/init.d/salt-master restart
 
cd /
git clone https://github.com/wako057/salt-master-01.git src

