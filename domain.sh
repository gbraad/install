#!/bin/bash

echo Please enter your domain address, Eg: www.example.com
read domain_address

echo Please enter your LetsEncrypt email address
read le_email_address

apt-get install -y nginx

systemctl stop nginx

apt-get install -y certbot

certbot certonly --non-interactive --agree-tos --email $le_email_address --standalone --preferred-challenges http -d $domain_address

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

./nginx $domain_address

cp nginx.conf /etc/nginx/sites-available/default

cp ssl-libreread.org.conf /etc/nginx/snippets/ssl-libreread.org.conf

cp config/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

systemctl start nginx