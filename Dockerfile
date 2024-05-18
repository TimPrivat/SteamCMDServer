FROM ubuntu:latest


ENV DEBIAN_FRONTEND=noninteractive


WORKDIR /tmp
# create user for steam
RUN useradd -m steam
RUN mkdir -p /home/steam/Steam
# install dependencies
RUN apt-get update && apt-get install -y software-properties-common

RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y curl git-all lib32gcc-s1 xfonts-100dpi

RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN mv linux32 /home/steam/Steam
#RUN linux32/steamcmd



RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git



WORKDIR /tmp/SteamTOTPGenerator

RUN mv SteamTOTPGenerator-linux /home/steam/Steam/ && rm -rf /tmp/*

WORKDIR  /home/steam/Steam/


# SteamCMD should not be used as root, here we set up user and variables


WORKDIR /home/steam/Steam

COPY steamscript.txt steamscript.txt
COPY entrypoint.sh entrypoint.sh

RUN chown -R steam:steam /home/steam/ && chmod 777 -R /home/steam/
#RUN linux32/steamcmd

USER steam



# Execution vector
#ENTRYPOINT ["./entrypoint.sh"]
ENTRYPOINT ["tail", "-f", "/dev/null"]