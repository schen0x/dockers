#!/bin/bash
# VPS server setup script, assume root

# === [optional] setup-ssh keys, or use ssh-copy-id instead ===
mkdir -p /root/.ssh
chmod 700 /root/.ssh
# echo ssh-ed25519 AAA... mail@mail.com > /root/.ssh/authorized_keys
echo <sshPublicKey> > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

sleep 5s

PKG_LISTS="docker docker-compose git vim tmux"
if apt-get install -y $PKG_LISTS; then
    echo "$PKG_LISTS installed"
else
    apt-get update -y && apt-get upgrade -y && apt-get install -y $PKG_LISTS
fi

cd ~/
DIR_ROOT=~/dockers/dont-starve-server
git clone https://github.com/schen0x/dockers.git

echo "cd $DIR_ROOT/" > ~/.bash_profile

chmod u+x $DIR_ROOT/setup-swap.sh && bash $DIR_ROOT/setup-swap.sh && docker-compose -f $DIR_ROOT/docker-compose.yml build
