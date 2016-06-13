#!/bin/bash

docker run -ti --rm \
    -e XMODIFIERS="@im=fcitx" \
    -e GTK_IM_MODULE=fcitx \
    -e QT_IM_MODULE=fcitx \
    -e XIMPROGRAM=fcitx \
    -e LC_CTYPE=ja_JP.UTF-8 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    nabezokodaikon/ubuntu:wine
