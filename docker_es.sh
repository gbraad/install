#!/bin/bash

wget -qO- https://get.docker.com/ | sh

sysctl -w vm.max_map_count=262144

docker build -t my_es .

docker run -d -p 9200:9200 -p 9300:9300 --name my_es_instance -i -t my_es

./es_setup