#!/bin/bash
# usage: sh ./restore_handler.sh $SERVER_IP
HOST=$1
echo ""
read -p "restoring save files for HOST: $HOST, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

BACKUP_FILE_NAME="cluster_content_backup.zip"
TARGET_PATH=~/dockers/dont-starve-server/cluster-content/
if scp ./$BACKUP_FILE_NAME "$HOST:~/$BACKUP_FILE_NAME"; then
    ssh -t "$HOST" "cd ~/; tar -xvzf $BACKUP_FILE_NAME -C $TARGET_PATH; cd $TARGET_PATH/../ "
fi
