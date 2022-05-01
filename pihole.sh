#!/bin/bash

# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

mkdir -p ~/docker/data/pihole
cd  ~/docker/data/pihole

MY_IP=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
echo My ip address: $MY_IP

echo To remove password:
echo docker exec -it pihole /bin/bash
echo and then:
echo sudo pihole -a -p

PIHOLE_BASE="${PIHOLE_BASE:-$(pwd)}"
[[ -d "$PIHOLE_BASE" ]] || mkdir -p "$PIHOLE_BASE" || { echo "Couldn't create storage directory: $PIHOLE_BASE"; exit 1; }

# Note: ServerIP should be replaced with your external ip.
docker run -d \
    --name pihole \
    --restart=unless-stopped \
    -p 53:53/tcp -p 53:53/udp \
    -p 80:80 \
    -e TZ="Europe/Berlin" \
    -e FTLCONF_REPLY_ADDR4=$MY_IP \
    -v "${PIHOLE_BASE}/etc-pihole/:/etc/pihole/" \
    -v "${PIHOLE_BASE}/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=$MY_IP --dns=1.1.1.1 \
    --hostname pi.hole \
    -e VIRTUAL_HOST="charon" \
    -e PROXY_LOCATION="charon" \
    -e ServerIP=$MY_IP \
    pihole/pihole:latest

printf 'Starting up pihole container '
for i in $(seq 1 20); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" == "healthy" ] ; then
        printf ' OK'
        echo -e "\n$(docker logs pihole 2> /dev/null | grep 'password:') for your pi-hole: https://${IP}/admin/"
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ $i -eq 20 ] ; then
        echo -e "\nTimed out waiting for Pi-hole start, consult your container logs for more info (\`docker logs pihole\`)"
        exit 1
    fi
done;
