#!/bin/bash

mkdir -p ~/docker/data/portainer
docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v ~/docker/data/portainer:/data --name=portainer --restart=always portainer/portainer --no-auth
