#!/bin/bash 

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

mkdir -p /home/vagrant/.ssh
touch /home/vagrant/.ssh/authorized_keys

chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys

apt-get update 
apt-get install -y apache2 openssl 
 
mkdir -p /etc/apache2/ssl 

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/codeby.local.key -out /etc/apache2/ssl/codeby.local.crt -subj "/CN=codeby.local" 

cat <<EOF > /etc/apache2/sites-available/codeby.local.conf
<VirtualHost *:80> 
    ServerName codeby.local 
    ServerAlias codeby.local 
    Redirect permanent / https://codeby.local/ 
</VirtualHost> 
 
<VirtualHost *:443> 
    ServerName codeby.local 
    ServerAlias www.codeby.local 
 
    DocumentRoot /var/www/html 
    SSLEngine on 
    SSLCertificateFile /etc/apache2/ssl/codeby.local.crt 
    SSLCertificateKeyFile /etc/apache2/ssl/codeby.local.key 
 
    # redirect www.codeby.local codeby.local 
    RewriteEngine On 
    RewriteCond %{HTTP_HOST} ^www\.codeby\.local$ [NC] 
    RewriteRule ^(.*)$ https://codeby.local$1 [L,R=301] 
</VirtualHost> 
EOF


# module ssl
a2enmod ssl 
a2enmod rewrite 
a2ensite codeby.local.conf 
systemctl restart apache2
