#!/bin/bash

apt-get install -y redis-server

apt-get install -y unzip

wget -qO- https://get.docker.com/ | sh

curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

sysctl -w vm.max_map_count=262144

docker-compose up -d & wait

./server