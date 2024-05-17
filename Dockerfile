FROM ubuntu:latest

WORKDIR /tmp
# create user for steam
RUN useradd -m steam

# install dependencies
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y curl git-all
    #&& \
   # apt-get clean && \
   # rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -o steamcmd.deb http://ftp.de.debian.org/debian/pool/non-free/s/steamcmd/steamcmd_0~20180105-4_i386.deb
RUN apt-get install -y steamcmd.deb




RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git

WORKDIR /tmp/SteamTOTPGenerator

RUN mv SteamTOTPGenerator-linux ~/Steam/ && rm -rf /tmp/*

WORKDIR  /home/steam/Steam/

COPY steamscript.txt steamscript.txt
COPY entrypoint.sh entrypoint.sh
# SteamCMD should not be used as root, here we set up user and variables
WORKDIR /root/home/

RUN mv Steam /home/steam
RUN chown -R steam:steam Steam && chmod -R 750

USER steam
WORKDIR /home/steam


# Execution vector
#ENTRYPOINT ["./entrypoint.sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]