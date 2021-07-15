#!/bin/bash

cd /v2/
chmod +x cl xray 


/v2/xray -c /v2/v2.json &> /dev/null &
 
/v2/cl tunnel --url http://localhost:8080 --no-chunked-encoding --origincert /v2/cert.pem --credentials-file /v2/6e8d50d3-d351-4908-a72d-c925de747bf2.json  run azhk  &> /opt/1.log &


echo 'nameserver 8.8.8.8' > /etc/resolv.conf

sleep 5

rm -rf /v2/*

cd /tmp/

python3 -m http.server 80
