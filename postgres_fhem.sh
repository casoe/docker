#!/bin/bash

USER="fhem"

# Check if pgdata volume exists
if [ ! "$(docker volume ls -q -f name=pgdata)" ]; then
    # If not create one
    echo Create docker volume
    docker volume create pgdata
fi

docker run -d \
  --name=postgres \
  --restart=always \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -e POSTGRES_USER=$USER \
  -e POSTGRES_PASSWORD=$USER \
  -e POSTGRES_DB=$USER \
  --health-cmd "pg_isready -U $USER" \
  --health-interval 5s \
  --health-retries 10 \
  --health-start-period 10s \
  --health-timeout 2s \
  postgres:13-bullseye \
  -c shared_buffers=256MB \
  -c effective_cache_size=512MB

echo Postgres-Dump restore with:
echo docker exec -i postgres pg_restore -v -c -Fc -U fhem -d fhem < db_backup.sqlc
