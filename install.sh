#!/bin/bash

wget -qO- https://get.docker.com/ | sh

curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

sysctl -w vm.max_map_count=262144

docker-compose up -d & wait

sleep 20

apt-get install -y unzip

apt-get install -y redis-server

apt-get install -y nginx

apt-get install -y certbot

`certbot certonly --non-interactive --agree-tos --email hello@nirm.al --webroot -w /var/libreread -d www.libreread.org`

./server