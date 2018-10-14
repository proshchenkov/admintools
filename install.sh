#!/bin/bash

apt update
apt upgrade

apt install p7zip mc texlive-full texstudio keepassx chromium-browser openjdk-8-jdk whois samba vlc evince ocaml ghostscript gparted htop kolourpaint4 shotwell kontact unetbootin unrar inkscape openvpn

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
echo deb http://download.onlyoffice.com/repo/debian squeeze main >> /etc/apt/sources.list
apt update
apt install onlyoffice-desktopeditors

snap install shotcut --classic

apt autoremove
