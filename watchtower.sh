#!/bin/bash

docker run -d  --name watchtower -v /var/run/docker.sock:/var/run/docker.sock --restart unless-stopped talmai/rpi-watchtower 7 --cleanup --interval 86400

