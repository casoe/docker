#!/bin/bash
# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

if [ ! -d "~/docker/data/pihole" ]; then
  git clone git@github.com:pi-hole/docker-pi-hole.git ~/docker/data/pihole
  cd  ~/docker/data/pihole
else
  cd  ~/docker/data/pihole
  git pull
fi

mkdir -p  ~/docker/data/pihole/etc-pihole/backup
sudo chown root.root ~/docker/data/pihole/etc-pihole/backup

MY_IP=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
MY_HOSTNAME=$(hostname)
echo My ip address: $MY_IP

PIHOLE_BASE="${PIHOLE_BASE:-$(pwd)}"

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
    --hostname $MY_HOSTNAME \
    -e VIRTUAL_HOST=$MY_HOSTNAME \
    -e PROXY_LOCATION=$MY_HOSTNAME \
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

echo "Removing password by"
echo docker exec pihole /bin/bash -c "echo -ne '\n' | pihole -a -p"
docker exec pihole /bin/bash -c "echo -ne '\n' | pihole -a -p"

echo
echo "How to create backup via crontab"
echo 00 02 * * sat docker exec -it pihole pihole -a teleporter /etc/pihole/backup/pihole-charon-teleporter_$(date -I).tar
