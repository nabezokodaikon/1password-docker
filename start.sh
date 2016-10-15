#!/bin/bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.1password-docker.xauth
touch ${XAUTH}
xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -

docker start -i 1password
