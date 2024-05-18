FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
# create user for steam
RUN useradd -m steam
RUN mkdir -p /home/steam/Steam && mkdir -p /srv/samba/games/Steam/steamapps/common

# install dependencies
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y curl git-all lib32gcc-s1 xfonts-100dpi jq

#install steamcmd
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN mv linux32 /home/steam/Steam

#install TOTPGenerator
RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git

WORKDIR /tmp/SteamTOTPGenerator

RUN mv SteamTOTPGenerator-linux /home/steam/Steam/ && rm -rf /tmp/*

WORKDIR /home/steam/Steam

#Copy Script
COPY entrypoint.sh entrypoint.sh

#Manage UserAccess
RUN chown -R steam:steam /home/steam/ && chmod 777 -R /home/steam/
RUN chown -R steam:steam /srv/ && chmod 777 -R /srv/

# Switch to Steamuser
USER steam

#Setup SteamCMD
#weird error that can be ignored
RUN linux32/steamcmd || :

# StartingPoint
ENTRYPOINT ["./entrypoint.sh"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
