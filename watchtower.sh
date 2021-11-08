#!/bin/bash

docker run -d \
  --name watchtower \
  --restart unless-stopped \
  -e TZ=Europe/Berlin \
  -e WATCHTOWER_CLEANUP=true \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --schedule "0 0 4 * * *"
