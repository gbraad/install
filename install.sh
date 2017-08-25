#!/bin/bash

echo Please enter your domain address, Eg: www.example.com
read domain_address

echo Please enter your SMTP server, Eg: smtp.zoho.com
read smtp_server

export LIBREREAD_SMTP_SERVER=$smtp_server

echo Please enter your SMTP port, Eg: 587
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

# curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

# chmod +x /usr/local/bin/docker-compose

sysctl -w vm.max_map_count=262144

# docker-compose up -d & wait
docker build -t my_es .

docker run -name my_es_instance -i -t my_es

sleep 20

apt-get install -y unzip

apt-get install -y poppler-utils

apt-get install -y redis-server

apt-get install -y nginx

mkdir -p uploads/img/

apt-get install -y certbot

# certbot certonly --non-interactive --agree-tos --email $le_email_address --webroot -w /var/libreread -d $domain_address

cp config/libreread.service /lib/systemd/system/

systemctl enable libreread

systemctl start libreread
