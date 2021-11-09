#!/bin/bash
# Run with root privileges.

# Repositories
apt-get update
apt-get upgrade -y

# CLI utils
apt install tree -y
apt-get install tshark -y

# Python
apt install python3 -y
apt install python3-pip -y
snap install jupyter
snap install pycharm-professional --classic

# Java
apt install default-jre -y

# Virtual Box
apt install virtualbox -y

# Web Browser - Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
dpkg -i /tmp/google-chrome-stable_current_amd64.deb

# Wireless config utils
apt install net-tools -y
apt install nmap -y
snap install curl
# Wireshark
echo | add-apt-repository ppa:wireshark-dev/stable
apt-get update
apt-get install wireshark
adduser $USER wireshark

# Microsoft Teams
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.5153_amd64.deb -P /tmp
dpkg -i /tmp/teams_1.3.00.5153_amd64.deb

# Editors
snap install code --classic
snap install notepad-plus-plus

# Media
snap install gimp
snap install vlc
apt-get install nomacs -y

# Social
snap install rambox
snap install slack
snap install spotify

# Signal
cd /tmp
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop
cd 

# Mendeley
# visit this site: https://www.mendeley.com/guides/download-mendeley-desktop/ubuntu/instructions
# then: dpkg -i mendeleydesktop_1.19.8-stable_amd64.deb 

# Gnome
add-apt-repository universe
apt install gnome-tweak-tool -y

# Firewall
apt install gufw -y

# Cleaner
add-apt-repository ppa:gerardpuig/ppa
apt-get update
apt-get install ubuntu-cleaner -y

# Repositories again
apt-get update
apt-get upgrade -y
