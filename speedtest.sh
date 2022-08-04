#!/bin/bash

mkdir -p ~/docker/data/speedtest

docker run -d \
      --name=speedtest \
      -p 8765:80 \
      -v ~/docker/data/speedtest:/config \
      -e OOKLA_EULA_GDPR=true \
      --restart unless-stopped \
      henrywhitaker3/speedtest-tracker:dev-arm
