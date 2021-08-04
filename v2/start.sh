#!/bin/bash

cd /v2/
chmod +x cl xray 

echo 'uLJpAlGtEh9cJvqocUw+iZKjmZxg/bH/YjfGVGQWbng=' > /root/privatekey

ip link add wg0 type wireguard
ip netns add tunnel
ip link set wg0 netns tunnel

ip netns exec tunnel wg set wg0 \
	private-key /root/privatekey \
	peer bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo= \
endpoint 162.159.192.1:4500 \
allowed-ips  0.0.0.0/1,128.0.0.0/1


ip netns exec tunnel ip addr add 172.16.0.2/32 dev wg0
ip netns exec tunnel ip link set mtu 1280 up dev wg0
ip netns exec tunnel ip route add default dev wg0
ip netns exec tunnel ip link set dev lo up


ip netns exec tunnel /v2/xray -c /v2/v2.json &> /dev/null &

socat tcp-listen:8080,fork,reuseaddr \
	  exec:'ip netns exec tunnel socat STDIO "tcp-connect:127.0.0.1:8080"',nofork &> /dev/null &


 
/v2/cl tunnel --url http://localhost:8080 --no-chunked-encoding --origincert /v2/cert.pem --credentials-file /v2/b136d629-0cbc-4078-a884-31c787758f54.json  run flyus  &> /opt/1.log &


echo 'nameserver 8.8.8.8' > /etc/resolv.conf

sleep 5

rm -rf /v2/*

cd /tmp/

python3 -m http.server 80
