

#!/bin/bash

USER=root
NAME=zm
CONTAINER=$(sudo /usr/bin/docker ps -aqf "name=$NAME")

if [[ -z $CONTAINER ]]; then
    echo "no previous"
else
    echo "Container=$CONTAINER"
    sudo /usr/bin/docker stop $CONTAINER
    sudo /usr/bin/docker rm $CONTAINER
fi

sudo docker create  --name="$NAME"  \
		-p 1080:80/tcp \
		-p 8443:443/tcp \
		-p 9000:9000/tcp \
        -e TZ=Europe/Oslo \
		--shm-size="512m" \
		-v /mnt/SS1/zm/events:/var/lib/zoneminder/events \
		-v /mnt/SS1/zm/images:/var/lib/zoneminder/images \
		-v /mnt/SS1/zm/mysql:/var/lib/mysql \
		-v /mnt/SS1/zm/logs:/var/log/zm \
    zoneminder/zoneminder
