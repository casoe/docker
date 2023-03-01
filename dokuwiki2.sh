#!/bin/bash

mkdir -p ~/docker/data/dokuwiki2

docker run -d \
  --name=dokuwiki2 \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 82:80 \
  -v ~/docker/data/dokuwiki2:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/dokuwiki:latest
