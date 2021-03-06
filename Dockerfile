FROM ubuntu:16.04
MAINTAINER nabezokodaikon <nabezoko.daikon@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture i386

RUN apt-get update -y && \
    apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    software-properties-common
RUN add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update -y && \
    apt-get upgrade -y

# Install tools.
RUN apt-get install -y --no-install-recommends \
    xauth \
    xvfb

# Install Wine.
RUN apt-get install -y \
    wine1.8:i386 \
    winetricks \
    winbind

# Japanese support.
RUN apt-get install -y --no-install-recommends \
    language-pack-ja
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    update-locale LANG=ja_JP.UTF-8 && \
    echo 'Asia/Tokyo' > /etc/timezone && \
    sed -e 's;UTC=yes;UTC=no;' -i /etc/default/rcS
ENV LANG ja_JP.UTF-8

# Create user.
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/wineuser && \
    groupadd -g ${gid} wineuser && \
    useradd -g ${gid} -u ${uid} wineuser -d /home/wineuser -s /bin/bash && \
    chown -R ${uid}:${gid} /home/wineuser

# Install 1Password.
USER wineuser
ENV HOME /home/wineuser
ENV WINEPREFIX ${HOME}/.wine
ENV WINEDLLOVERRIDES mscoree,mshtml=
WORKDIR ${HOME}
RUN wget -P ${HOME} -O installer.exe https://d13itkw33a7sus.cloudfront.net/dist/1P/win4/1Password-4.6.1.616.exe
RUN xvfb-run -a bash -c "\
    /usr/bin/wine ${HOME}/installer.exe /VERYSILENT /DIR=c:\1Password && \
    grep -A4 Installation ${WINEPREFIX}/drive_c/1Password/1Password.InnoSetup.log.txt && \
    /usr/bin/wineserver -k 2"
RUN rm ${HOME}/installer.exe

# Clean up.
USER root
RUN apt-get purge -y \
    software-properties-common \
    xvfb
RUN apt-get clean && \
    apt-get autoremove -y && \
    apt-get autoclean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

# ENTRYPOINT ["/usr/bin/wine"]
# CMD ["/home/wineuser/.wine/drive_c/1Password/1Password.exe"]
# CMD ["/home/wineuser/.wine/drive_c/1Password/Agile1pAgent.exe"]
