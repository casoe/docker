#!/bin/bash

SCRIPT="postgres_fhem"
USER="fhem"

mkdir -p ~/docker/data/$SCRIPT
docker run -d \
  --name=postgres \
  --restart=always \
  -p 5432:5432 \
  -v ~/docker/$SCRIPT/data:/var/lib/postgresql/data \
  -e POSTGRES_USER=$USER \
  -e POSTGRES_PASSWORD=$USER \
  -e POSTGRES_DB=$USER \
  postgres:13 \
  -c shared_buffers=256MB \
  -c effective_cache_size=512MB
