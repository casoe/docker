#!/bin/bash

mkdir -p ~/docker/data/portainer
docker run -d \
  --name=portainer \
  --restart=always \
  -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/docker/data/portainer:/data \
  portainer/portainer:1.25.0-alpine \
  --no-auth
