!#/bin/bash
# Run with root privileges.

# Repositories
apt-get update
apt-get upgrade -y

# Python
apt install python3-pip
snap install jupyter
snap install pycharm-professional

# Java
apt install openjdk-18-jre

# Editors
snap install code --classic
snap install notepad-plus-plus

# Media
snap install gimp
snap install vlc


# Social
snap install rambox
snap install slack
snap install spotify
apt-get install mendeleydesktop

# Gnome
add-apt-repository universe
apt install gnome-tweak-tool

# Firewall
apt install gufw -y

# Cleaner
add-apt-repository ppa:gerardpuig/ppa
apt-get update
apt-get install ubuntu-cleaner

# Repositories again
apt-get update
apt-get upgrade -y
