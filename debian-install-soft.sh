#!/bin/bash

apt update
apt upgrade

apt install p7zip mc texlive-full texstudio keepassx chromium chromium-l10n openjdk-8-jdk whois samba vlc evince ocaml 
ghostscript gparted htop kolourpaint4 shotwell kontact unrar inkscape openvpn gedit mtr arp-scan thunderbird thunderbird-l10n-ru 
gaclculator ntp ntpdate netstat acl ffmpeg obs-studio net-tools krita krita-l10n

ntpq -pn #синхронизация времени

sudo netstat -ntulp #посмотреть открытые порты

apt autoremove
