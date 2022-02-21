#!/bin/bash

mkdir -p ~/docker/data/homebridge
docker run -d  \
  --name=homebridge \
  --restart unless-stopped \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e HOMEBRIDGE_CONFIG_UI=1 \
  -e HOMEBRIDGE_CONFIG_UI_PORT=8581 \
  -e TZ=Europe/Berlin \
  -v ~/docker/data/homebridge:/homebridge \
  oznu/homebridge:ubuntu
