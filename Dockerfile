FROM ubuntu:latest

# create user for steam
RUN useradd steam

# install dependencies
RUN apt-get update && \
    apt-get install -y curl git-all && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Downloading SteamCMD and make the Steam directory owned by the steam user
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz &&\
    chown -R steam /opt/steamcmd

WORKDIR /tmp

RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git

WORKDIR /tmp/SteamTOTPGenerator

RUN mv SteamTOTPGenerator-linux /opt/steamcmd && rm -rf /tmp/*

WORKDIR /opt/steamcmd

COPY steamscript.txt steamscript.txt
COPY entrypoint.sh entrypoint.sh
# SteamCMD should not be used as root, here we set up user and variables
USER steam

RUN chmod 777 entrypoint.sh

# Execution vector
ENTRYPOINT ["./entrypoint.sh"]