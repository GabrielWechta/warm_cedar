#!/bin/bash
# Run with root privileges.

# Repositories
apt-get update
apt-get upgrade -y

# Python
apt install python3 -y
apt install python3-pip -y
snap install jupyter
snap install pycharm-professional --classic

# Java
apt install default-jre -y

# Web Browser - Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
dpkg -i /tmp/google-chrome-stable_current_amd64.deb

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
