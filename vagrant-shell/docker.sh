#!/usr/bin/env bash

echo "Entering Docker Provisoning"
date +"%F %T"

sysctl -w net.ipv4.ip_forward=1

# installing docker-engine vs docker
yum install docker-engine \
  --assumeyes

systemctl start docker
systemctl enable docker

# https://stackoverflow.com/questions/23111631/cannot-download-docker-images-behind-a-proxy
#mkdir /etc/systemd/system/docker.service.d
#cat >> /etc/systemd/system/docker.service.d/http-proxy.conf << EOF
#[Service]
#Environment="HTTP_PROXY=http://adc-proxy.oracle.com:80/"
#EOF

systemctl reload docker

systemctl status docker

uname -a
ip addr show

usermod -aG docker vagrant

docker run --name hello-world --rm hello-world
docker rmi hello-world

date +"%F %T"
echo "Exiting Docker Provisoning"
echo " "
