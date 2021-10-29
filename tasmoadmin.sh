#!/bin/bash

mkdir -p ~/docker/data/tasmoadmin:
docker run -d \
  --name=tasmoadmin \
  --restart=always \
  -p 5555:80 \
  -v ~/docker/data/tasmoadmin:/data \
  raymondmm/tasmoadmin:beta

