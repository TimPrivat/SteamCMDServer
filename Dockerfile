FROM ubuntu:latest

# create user for steam
RUN whoami

# install dependencies
RUN apt-get update && \
    apt-get install -y curl lib32gcc1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Downloading SteamCMD and make the Steam directory owned by the steam user
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz &&\
    chown -R steam /opt/steamcmd

RUN git clone https://github.com/TimPrivat/SteamTOTPGenerator.git

WORKDIR /opt/steamcmd

COPY steamscript.txt steamscript.txt
# SteamCMD should not be used as root, here we set up user and variables
USER steam


# Execution vector
ENTRYPOINT ["entrypoint.sh"]