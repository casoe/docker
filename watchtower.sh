#!/bin/bash

docker run -d \
  --name watchtower \
  --restart unless-stopped \
  -e TZ=Europe/Berlin \
  -e WATCHTOWER_CLEANUP=true \
  -e WATCHTOWER_POLL_INTERVAL=86400  \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower
