#!/bin/bash
# GLPI
# https://services.glpi-network.com/
# https://www.osradar.com/how-to-install-glpi-on-debian-10-buster/

echo "---------------------------------------apt update && apt upgrade----------------------------------------"
apt update && apt upgrade
echo "--------------------------------------------apt install mc----------------------------------------------"
apt install mc
echo "------------------------------------------apt install apache2-------------------------------------------"
apt install apache2
echo "--------------------------------------------apt install php---------------------------------------------"
apt install php php-curl php-zip php-gd php7.4-intl php-pear php-imagick php-imap php-memcache php-pspell recode php-tidy php7.4-xmlrpc php-xsl php-mbstring php-php-gettext php7.4-ldap php-cas php-apcu libapache2-mod-php php-mysql php-bz2
echo "---------------------------------------apt install mariadb-server---------------------------------------"
apt install mariadb-server
echo "-----------------------------------------apt install phpmyadmin-----------------------------------------"
apt install phpmyadmin
echo "--------------------------------------------mysql -u root -p--------------------------------------------"
mysql -u root -p -Bse "CREATE DATABASE glpidb;GRANT ALL PRIVILEGES ON glpidb.* TO 'glpiuser'@'localhost' IDENTIFIED BY 'glpipassword';FLUSH PRIVILEGES;EXIT;"
echo "--------------------------------------------------wget--------------------------------------------------"
wget https://github.com/glpi-project/glpi/releases/download/9.5.7/glpi-9.5.7.tgz
echo "--------------------------------------------------tar---------------------------------------------------"
tar -xvf glpi-9.5.7.tgz
echo "---------------------------------------------------mv---------------------------------------------------"
mv glpi /var/www/html/
echo "-------------------------------------------------chmod--------------------------------------------------"
chmod 755 -R /var/www/html/
echo "-------------------------------------------------chown--------------------------------------------------"
chown www-data:www-data -R /var/www/html/
echo "--------------------------------------------------echo--------------------------------------------------"
echo "<VirtualHost *:80>
     ServerAdmin proschenkov_vm@spb.ckb-rubin.local
     DocumentRoot /var/www/html/glpi
     ServerName glpi.ckb-rubin.local
     <Directory /var/www/html/glpi>
          Options FollowSymlinks
          AllowOverride All
          Require all granted
     </Directory>
     ErrorLog \${APACHE_LOG_DIR}/glpi.ckb-rubin.local_error.log
     CustomLog \${APACHE_LOG_DIR}/glpi.ckb-rubin.local_access.log combined
</VirtualHost>" > /etc/apache2/sites-available/glpi.conf
echo "---------------------------------------------------ln---------------------------------------------------"
ln -s /etc/apache2/sites-available/glpi.conf /etc/apache2/sites-enabled/glpi.conf
echo "------------------------------------------------a2enmod-------------------------------------------------"
#a2enmod rewrite
echo "-----------------------------------------------systemctl------------------------------------------------"
systemctl restart apache2

# По умолчанию логины / пароли:
#    glpi/glpi для учетной записи администратора
#    tech/tech для технической учетной записи
#    normal/normal для обычной учетной записи
#    post-only/postonly только для подачи заявок
# Вы можете изменить или удалить эти учетные записи.

