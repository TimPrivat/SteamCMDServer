FROM ubuntu:latest


ENV DEBIAN_FRONTEND=noninteractive


WORKDIR /tmp
# create user for steam
RUN useradd -m steam

# install dependencies
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y curl git-all lib32gcc-s1

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
#RUN linux32/steamcmd



RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git

RUN mkdir ~/Steam

WORKDIR /tmp/SteamTOTPGenerator

RUN mv SteamTOTPGenerator-linux ~/Steam/ && rm -rf /tmp/*

WORKDIR  /home/steam/Steam/

COPY steamscript.txt steamscript.txt
COPY entrypoint.sh entrypoint.sh
# SteamCMD should not be used as root, here we set up user and variables

USER steam
WORKDIR /home/steam


# Execution vector
#ENTRYPOINT ["./entrypoint.sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]