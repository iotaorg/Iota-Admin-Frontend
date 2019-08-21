#!/bin/bash

export GIT_DIR=$(git rev-parse --show-toplevel)
#export MYIP=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
export MYIP=172.17.0.1

echo "Make sure API is listening on $MYIP:5000 ";
(sleep 1; export X=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' iota-frontend 2>&1`; echo "http://$X/frontend" ) &

docker run --rm --add-host=api_server:$MYIP --name iota-frontend -p 8080:80 -v $GIT_DIR:/data/frontend:ro iota/frontend-nginx

