#!/bin/bash

echo Please enter your domain address, Eg: www.example.com
read domain_address

echo Please enter your SMTP server, Eg: smtp.fastmail.com
read smtp_server

export LIBREREAD_DOMAIN_ADDRESS=$domain_address

export LIBREREAD_SMTP_SERVER=$smtp_server

echo Please enter your SMTP port, Eg: 587/465
read smtp_port

export LIBREREAD_SMTP_PORT=$smtp_port

echo Please enter your SMTP email address, Eg: info@example.com
read smtp_address

export LIBREREAD_SMTP_ADDRESS=$smtp_address

echo Please enter your SMTP password. This will be application-specific password or email password
read smtp_password

export LIBREREAD_SMTP_PASSWORD=$smtp_password

echo Please enter your LetsEncrypt email address
read le_email_address

wget -qO- https://get.docker.com/ | sh

sysctl -w vm.max_map_count=262144

docker build -t my_es .

docker run -d -p 9200:9200 -p 9300:9300 --name my_es_instance -i -t my_es

sleep 20

apt-get install -y unzip

apt-get install -y poppler-utils

apt-get install -y redis-server

apt-get install -y nginx

systemctl stop nginx

export GIN_MODE=release

cp config/libreread.service /lib/systemd/system/

systemctl enable libreread

systemctl start libreread

apt-get install -y certbot

certbot certonly --non-interactive --agree-tos --email $le_email_address --standalone --preferred-challenges http -d $domain_address

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

./nginx $domain_address

cp nginx.conf /etc/nginx/sites-available/default

cp ssl-libreread.org.conf /etc/nginx/snippets/ssl-libreread.org.conf

cp config/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

systemctl start nginx
