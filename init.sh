#!/bin/bash

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.1password-docker.xauth
touch ${XAUTH}
xauth nlist ${DISPLAY} | sed -e 's/^..../ffff/' | xauth -f ${XAUTH} nmerge -

docker run \
    -it \
    -e GTK_IM_MODULE=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e XMODIFIERS='@im=fcitx' \
    -e LC_CTYPE=ja_JP.UTF-8 \
    -e DISPLAY=${DISPLAY} \
    -e XAUTHORITY=${XAUTH} \
    -u wineuser \
    -v "${XSOCK}":"${XSOCK}":rw \
    -v "${XAUTH}":"${XAUTH}":rw \
    -v "${HOME}/Dropbox/private/1Password/1Password.opvault:/home/wineuser/.wine/drive_c/users/wineuser/My Documents/1Password.opvault":rw \
    --name=1password \
    nabezokodaikon/ubuntu:1password \
    /usr/bin/wine /home/wineuser/.wine/drive_c/1Password/1Password.exe
