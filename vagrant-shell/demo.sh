#!/usr/bin/env bash

echo "Entering Demo"
date +"%F %T"

yum install git --assumeyes

git clone https://github.com/spkane/docker-node-hello.git

cd docker-node-hello

IMAGE="example/docker-node-hello:latest"

MYIP=`ip --oneline --family inet address show dev eth1 | awk '{ print $4 }' | sed 's/\/.*$//'`
echo "MyIP=$MYIP"
echo " "

docker build --no-cache -t $IMAGE .

CID=`docker run -d -p 8080:8080 $IMAGE`
sleep 30
curl http://$MYIP:8080
docker stop $CID
docker rm $CID
echo " "

CID=`docker run -d -p 8080:8080 -e WHO="Sean and Karl" $IMAGE`
sleep 30
curl http://$MYIP:8080
docker stop $CID
docker rm $CID
echo " "

docker image rm $IMAGE

date +"%F %T"
echo "Exiting Demo"
echo " "
