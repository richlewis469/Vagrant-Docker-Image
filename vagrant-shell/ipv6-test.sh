#!/usr/bin/env bash

echo "Entering IPv6-Test"
date +"%F %T"

systemctl stop docker

sysctl net.ipv4.ip_forward=1
sysctl net.ipv4.conf.all.forwarding=1
sysctl net.ipv6.conf.default.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv4.conf.all.forwarding=1
sysctl -w net.ipv6.conf.default.forwarding=1
sysctl -w net.ipv6.conf.all.forwarding=1

cat >> /etc/sysctl.conf << EOF
net.ipv4.ip_forward=1
net.ipv4.conf.all.forwarding=1
net.ipv6.conf.default.forwarding=1
net.ipv6.conf.all.forwarding=1
EOF

# Enable IPv6 Support per https://docs.docker.com/config/daemon/ipv6/
cat >> /etc/docker/daemon.json << EOF
{
  "ipv6": true,
  "fixed-cidr-v6": "fc00:172:17:0:0::/64"
}
EOF

IMAGE="richarvey/nginx-php-fpm"
INTER="eth1"
IPV4ADDR="192.168.1.201"
IPV6ADDR="2600:1700:1b70:a9b0::fa"
CLIENT="ipv6-test"

echo "ipv6-test: Configuring Ethernet Interface $INTER"
ip addr add $IPV4ADDR/32 dev $INTER
ip addr add $IPV6ADDR/128 dev $INTER
ip addr show dev $INTER

systemctl start docker

echo "ipv6-test: Executing Docker Pull"
docker pull $IMAGE

echo "ipv6-test: Executing Docker Run"
CMD="docker run -d -t \
  -v /vagrant-share/www:/var/www/html \
  --name ${CLIENT} \
  --hostname ${CLIENT}.lab.net \
  -p ${IPV4ADDR}:80:80 \
  -p [${IPV6ADDR}]:80:80 \
  ${IMAGE}"
echo $CMD

CID=`$CMD`
echo $CID

echo "ipv6-test: Waiting on Docker Run"
MAXLOOP=12
SLEEP_SECONDS=5
while [ true ]; do
  STATE=`docker inspect --format='{{json .State.Status}}' ipv6-test`
  RC=$?
  if [ $RC == 0 ] && [ $STATE == '"running"' ] ; then
    break
  fi
  if [ $MAXLOOP -gt 0 ] ; then
    sleep $SLEEP_SECONDS
    : $((MAXLOOP--))
  else
    break
  fi
done

echo "ipv6-test: First PS Test"
ps -ef | grep -i docker

# https://www.snas.io/docs/aio_ipv6/
ADDR=$(sudo docker inspect $CLIENT | \
  grep GlobalIPv6Address | head -1 | awk -F ": " '{ gsub(/[,\"]/, "", $2); printf("%s", $2) }')
echo "ipv6-test: Client Address = $ADDR"

echo "ipv6-test: Second PS Test"
ps -ef | grep -i docker

echo "ipv6-test: Configuring ip6tables"
# Add the IPv6 DNAT rule
sudo ip6tables -t nat -A PREROUTING \! -i docker0 -p tcp -m tcp --dport 80 -j DNAT --to-destination "[${ADDR}]:80"
echo "-----"
iptables  -t nat -L
echo "-----"
ip6tables -t nat -L

date +"%F %T"
echo "Exiting IPv6-Test"
echo " "
