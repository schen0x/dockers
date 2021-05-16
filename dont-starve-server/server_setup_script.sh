#!/bin/bash
# VPS server setup script, assume root

# === [optional] setup-ssh keys, or use ssh-copy-id instead ===
# mkdir -p /root/.ssh
# chmod 700 /root/.ssh
# echo ssh-rsa AA... youremail@example.com > /root/.ssh/authorized_keys
# chmod 600 /root/.ssh/authorized_keys

PKG_LISTS="docker docker-compose git vim tmux"
if apt-get install -y $PKG_LISTS; then
    echo "$PKG_LISTS installed"
else
    apt-get update -y && apt-get upgrade -y && apt-get install -y $PKG_LISTS
fi

cd ~/
git clone https://github.com/schen0x/dockers.git
git clone https://github.com/schen0x/privateVPN.git
sed -i 's/PASSWORD=/PASSWORD=<password>/g' ~/privateVPN/docker-compose.yml

echo "cd ~/dockers/dont-starve-server/" >> ~/.bash_profile

chmod u+x ~/dockers/dont-starve-server/setup-swap.sh

cd ~/dockers/dont-starve-server/
bash ~/dockers/dont-starve-server/setup-swap.sh && docker-compose build
