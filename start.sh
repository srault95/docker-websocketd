#!/bin/bash

echo "--> start.sh script running..."

printf "${DEFAULT_USER:-root}:$(openssl passwd -apr1 ${DEFAULT_PASSWORD:-root})\n" > /etc/nginx/htpasswd

/usr/local/bin/websocketd --port=8010 --staticdir=/usr/local/web-vmstats/web /usr/bin/vmstat -n 1 &

exec /usr/sbin/nginx 
