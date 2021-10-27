#!/bin/bash

mkdir -p ~/docker/data/tasmoadmin:
docker run -d -p 5555:80 -v ~/docker/data/tasmoadmin:/data --name=tasmoadmin --restart=always raymondmm/tasmoadmin:beta
