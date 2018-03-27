#!/usr/bin/env bash

echo "Entering Demo"
date +"%F %T"

IMAGE="richarvey/nginx-php-fpm"

MYIPV4=`ip --oneline --family inet address show dev eth1 | awk '{ print $4 }' | sed 's/\/.*$//'`
echo "MyIPV4=$MYIPV4"
MYIPV6=`ip --oneline --family inet6 address show dev eth1 | grep global | awk '{ print $4 }' | sed 's/\/.*$//'`
echo "MyIPV6=$MYIPV6"
echo " "

yum install bridge-utils --assumeyes

ip addr del 192.168.1.161/24 dev eth1
brctl addbr br1
brctl addif br1 eth1

docker network create --driver bridge --subnet=192.168.1.0/24 --gateway=192.168.1.199 --opt "com.docker.network.bridge.name"="br1" shared_nw
docker run -d --net shared_nw --ip 192.168.1.199 richarvey/nginx-php-fpm

# docker run -d --net host -v /vagrant-share/www:/var/www/html --name ipv6-test --hostname ipv6-test.lab.net richarvey/nginx-php-fpm
# pipework br0 $(docker run -d -v /vagrant-share/www:/var/www/html --name ipv6-test --hostname ipv6-test.lab.net richarvey/nginx-php-fpm) 192.168.1.199/24


CID=`docker run -d --net host -v /vagrant-share/www:/var/www/html $IMAGE`

date +"%F %T"
echo "Exiting Demo"
echo " "
