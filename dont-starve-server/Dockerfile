# syntax=docker/dockerfile:1
# ref: https://docs.docker.com/engine/reference/builder/
# ref: https://forums.kleientertainment.com/forums/topic/64441-dedicated-server-quick-setup-guide-linux/
FROM ubuntu:20.04
RUN dpkg --add-architecture i386
RUN apt-get -y update && apt-get -y upgrade
# 64-bit
RUN apt-get -y install libstdc++6:i386 libgcc1:i386 libcurl4-gnutls-dev:i386 wget
RUN mkdir -p /root/steamcmd/
WORKDIR /root/steamcmd/
RUN wget "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz"
RUN tar -xvzf steamcmd_linux.tar.gz
# bind-mount the config inside
RUN mkdir -p /root/.klei/DoNotStarveTogether/MyDediServer
COPY ./run_dedicated_servers.sh /root/run_dedicated_servers.sh
COPY ./run_dedicated_servers_preload.sh /root/run_dedicated_servers_preload.sh
COPY ./cluster-content/Master/modoverrides.lua /root/modoverrides.lua
RUN chmod u+x /root/run_dedicated_servers.sh
RUN chmod u+x /root/run_dedicated_servers_preload.sh
EXPOSE 10889
# Steam related updateds, game contents update, everything other than Mod
RUN bash /root/run_dedicated_servers_preload.sh

# Add Mods
RUN mkdir -p /root/dontstarvetogether_dedicated_server/mods/
RUN touch /root/dontstarvetogether_dedicated_server/mods/dedicated_server_mods_setup.lua 
# Global Position, Health Info
# RUN echo $'ServerModSetup("378160973")\nServerModSetup("375859599")' > /root/dontstarvetogether_dedicated_server/mods/dedicated_server_mods_setup.lua 

CMD ["bash", "/root/run_dedicated_servers.sh"]
