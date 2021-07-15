#!/bin/bash

cd /v2/
chmod +x cl xray 


/v2/xray -c /v2/v2.json &> /dev/null &
 
/v2/cl tunnel --url http://localhost:8080 --no-chunked-encoding --origincert /v2/cert.pem --credentials-file /v2/8a599fc5-e520-4397-a6d5-47028c5ac399.json  run azus  &> /opt/1.log &


echo 'nameserver 8.8.8.8' > /etc/resolv.conf

sleep 5

rm -rf /v2/*

cd /tmp/

python3 -m http.server 80
