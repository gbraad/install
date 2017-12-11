#!/bin/bash

systemctl stop libreread

wget -qO- https://get.docker.com/ | sh

sysctl -w vm.max_map_count=262144

docker build -t my_es .

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" --name my_es_instance -i -t my_es

sleep 30

./es_setup

systemctl start libreread