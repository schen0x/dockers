#!/bin/bash
# VPS server setup script, assume root

# === [optional] setup-ssh keys, or use ssh-copy-id instead ===
# mkdir -p /root/.ssh
# chmod 700 /root/.ssh
# echo ssh-rsa AA... youremail@example.com > /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys

PKG_LISTS="docker docker-compose git vim"
if apt-get install -y $PKG_LISTS then
else
    apt-get update -y && apt-get upgrade -y && apt-get install -y $PKG_LISTS
fi

cd ~/
git clone https://github.com/schen0x/dockers.git
cd ~/dockers/dont-starve-server/

./setup-swap.sh
docker-compose build
