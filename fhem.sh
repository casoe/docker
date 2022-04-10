#!/bin/bash

mkdir -p ~/docker/data/fhem

docker run -d \
  --name fhem \
  --restart unless-stopped \
  --net=host \
  -e FHEM_UID=1000 \
  -e FHEM_GID=1000 \
  -e TZ=Europe/Berlin \
  -v ~/docker/data/fhem:/opt/fhem \
  --device=/dev/lesekopf \
  ghcr.io/fhem/fhem/fhem-docker:bullseye
