#!/bin/bash

mkdir -p ~/docker/data/dokuwiki

docker run -d \
  --name=dokuwiki \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -p 81:80 \
  -v ~/docker/data/dokuwiki:/var/www/html \
  --restart unless-stopped \
  php:7-apache-bullseye

echo https://loganmarchione.com/2022/03/the-best-way-to-run-dokuwiki-in-docker/
echo docker exec -it dokuwiki /bin/bash
echo cd /var/www/html
echo curl --remote-name https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
echo tar -xzvf dokuwiki-stable.tgz --strip-components=1
echo rm dokuwiki-stable.tgz
echo chown -R www-data:www-data /var/www/

