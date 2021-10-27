#!/bin/bash

mkdir -p ~/docker/data/heimdall
docker run -d  --name=heimdall -e PUID=1000 -e PGID=1000 -e TZ=Europe/Berlin -p 8080:80 -p 8443:443 -v ~/docker/data/heimdall:/config --restart unless-stopped ghcr.io/linuxserver/heimdall
