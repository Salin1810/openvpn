#!/bin/bash
userPassword=$1

#download the packages
cd /tmp
wget -c https://static.adguard.com/adguardhome/release/AdGuardHome_linux_amd64.tar.gz

#install the software
sudo dpkg -i openvpn-as-2.1.9-Ubuntu16.amd_64.deb

#update the password for user openvpn
sudo echo "openvpn:$userPassword"|sudo chpasswd

#configure server network settings
PUBLICIP=$(curl -s ifconfig.me)
sudo apt-get install sqlite3
sudo sqlite3 "/usr/local/openvpn_as/etc/db/config.db" "update config set value='$PUBLICIP' where name='host.name';"

#restart OpenVPN AS service
sudo systemctl restart openvpnas
