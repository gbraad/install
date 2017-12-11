#!/bin/bash

echo Please enter your domain address, Eg: www.example.com
read domain_address

echo Please enter your SMTP server, Eg: smtp.fastmail.com
read smtp_server

echo Please enter your SMTP port, Eg: 587/465
read smtp_port

echo Please enter your SMTP email address, Eg: info@example.com
read smtp_address

echo Please enter your SMTP password. This will be application-specific password or email password
read smtp_password

apt-get install -y unzip

apt-get install -y poppler-utils

apt-get install -y redis-server

export GIN_MODE=release

./libreread $domain_address $smtp_server $smtp_port $smtp_address $smtp_password

cp libreread.service /lib/systemd/system/

systemctl enable libreread

systemctl start libreread
