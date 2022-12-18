#!/bin/bash

mkdir -p ~/docker/data/dokuwiki

docker run -d \
  --name=dokuwiki \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 81:80 \
  -v ~/docker/data/dokuwiki:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/dokuwiki:latest
