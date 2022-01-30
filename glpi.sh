#!/bin/bash
# GLPI
# https://services.glpi-network.com/
# https://www.osradar.com/how-to-install-glpi-on-debian-10-buster/

apt update && apt upgrade
apt install mc phpmyadmin
apt install php php-curl php-zip php-gd php-intl php-pear php-imagick php-imap php-memcache php-pspell recode php-tidy php-xmlrpc php-xsl php-mbstring php-php-gettext php-ldap php-cas php-apcu libapache2-mod-php php-mysql php-bz2
apt install mariadb-server
#mysql -u root -p
#CREATE DATABASE glpidb;
#GRANT ALL PRIVILEGES ON glpidb.* TO 'glpiuser'@'localhost' IDENTIFIED BY 'password';
#FLUSH PRIVILEGES;
#EXIT;
wget https://github.com/glpi-project/glpi/releases/download/9.5.7/glpi-9.5.7.tgz
tar -xvf glpi-9.5.7.tgz
mv glpi /var/www/html/
chmod 755 -R /var/www/html/
chown www-data:www-data -R /var/www/html/
echo "<VirtualHost *:80>
     ServerAdmin admin@your_domain.com
     DocumentRoot /var/www/html/glpi
     ServerName your-domain.com
     <Directory /var/www/html/glpi>
          Options FollowSymlinks
          AllowOverride All
          Require all granted
     </Directory>
     ErrorLog \${APACHE_LOG_DIR}/glpi.ckb-rubin.local_error.log
     CustomLog \${APACHE_LOG_DIR}/glpi.ckb-rubin.local_access.log combined
</VirtualHost>" > /etc/apache2/sites-available/glpi.conf
ln -s /etc/apache2/sites-available/glpi.conf /etc/apache2/sites-enabled/glpi.conf
#a2enmod rewrite
systemctl restart apache2

# По умолчанию логины / пароли:
#    glpi/glpi для учетной записи администратора
#    tech/tech для технической учетной записи
#    normal/normal для обычной учетной записи
#    post-only/postonly только для подачи заявок
# Вы можете изменить или удалить эти учетные записи.
