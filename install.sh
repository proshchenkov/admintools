#!/bin/bash

apt -y update
apt -y upgrade

apt -y install p7zip mc texlive-full texstudio keepassx chromium-browser openjdk-8-jdk whois samba vlc evince ocaml ghostscript gparted htop kolourpaint shotwell kontact unetbootin unrar

#apt-key -y adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
#echo deb http://download.onlyoffice.com/repo/debian squeeze main >> /etc/apt/sources.list
#apt update
#apt -y --force-yes install onlyoffice-desktopeditors

snap install shotcut --classic
