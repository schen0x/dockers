#!/bin/bash
# shell dependent
# usage: bash ./restore_handler.sh $SERVER_IP
HOST="root@$1"
echo ""
read -p "restoring save files for HOST: $HOST, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

BACKUP_FILE_NAME="cluster_content_backup.zip"
TMP_FOLDER="/tmp"
BASE_FOLDER="/root/dockers/dont-starve-server"
TARGET_FOLDER="/root/dockers/dont-starve-server/cluster-content"
if scp ./$BACKUP_FILE_NAME "$HOST:$TMP_FOLDER/$BACKUP_FILE_NAME"; then
    ssh -t "$HOST" "tar -xvzf $TMP_FOLDER/$BACKUP_FILE_NAME -C $TARGET_FOLDER/"
    ssh "$HOST" "nohup docker-compose -f $BASE_FOLDER/docker-compose.yml up"
fi
