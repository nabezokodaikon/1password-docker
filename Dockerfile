FROM ubuntu:16.04
MAINTAINER nabezokodaikon "nabezoko.daikon@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends software-properties-common
RUN add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update -y
RUN apt-get install -y wine1.8:i386 winetricks winbind

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apt-get install -y language-pack-ja
RUN update-locale LANG=ja_JP.UTF-8
RUN echo 'Asia/Tokyo' > /etc/timezone
RUN sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS

RUN apt-get purge software-properties-common -y
RUN apt-get autoclean -y

RUN export uid=1000 gid=1000 && \
    mkdir -p /home/wineuser && \
    echo "wineuser:x:${uid}:${gid}:Developer,,,:/home/wineuser:/bin/bash" >> /etc/passwd && \
    echo "wineuser:x:${uid}:" >> /etc/group && \
    echo "wineuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wineuser && \
    chmod 0440 /etc/sudoers.d/wineuser && \
    chown ${uid}:${gid} -R /home/wineuser

RUN apt-get install -y firefox

USER wineuser

ENV HOME /home/wineuser
ENV LANG ja_JP.UTF-8

WORKDIR /home/wineuser
CMD /bin/bash
