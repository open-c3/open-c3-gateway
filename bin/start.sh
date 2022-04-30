#!/bin/bash

X=$(docker inspect openc3-gateway 2>&1|grep Created|wc -l)

if [ "X1" == "X$X"  ]; then
    docker start openc3-gateway
else
    IMAGE='openresty/openresty:1.9.15.1-trusty'
    docker run -d --name="openc3-gateway"\
        -p 7788:7788 \
        -v /data/open-c3-gateway/conf/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
        -v /data/open-c3-gateway/conf/lua:/usr/local/openresty/nginx/conf/lua \
        -v /data/open-c3-gateway/conf/js:/usr/local/openresty/nginx/conf/js \
        -v /data/open-c3-gateway/logs/lua:/usr/local/openresty/nginx/logs \
        -v /data/open-c3-gateway/data/locked:/locked \
        $IMAGE
fi
