#!/bin/bash

docker run \
    -it \
    -e XMODIFIERS="@im=fcitx" \
    -e GTK_IM_MODULE=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e XIMPROGRAM=fcitx \
    -e LC_CTYPE=ja_JP.UTF-8 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v "${HOME}/Dropbox/private/1Password/1Password.opvault:/home/wineuser/.wine/drive_c/users/wineuser/My Documents/1Password.opvault" \
    --name=1password \
    nabezokodaikon/ubuntu:1password
