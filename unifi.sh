#!/bin/bash

mkdir -p ~/docker/data/unifi
docker run -d \
  --name=unifi \
  --restart=unless-stopped \
  --init \
  -p 8081:8080 \
  -p 8443:8443 \
  -p 3478:3478/udp \
  -p 10001:10001/udp \
  -e TZ='Europe/Berlin' \
  -v ~/docker/data/unifi:/unifi \
  jacobalberty/unifi
