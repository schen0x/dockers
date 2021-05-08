#!/bin/bash
# shell dependent
# usage: bash ./restore_handler.sh $SERVER_IP
HOST="root@$1"
echo ""
read -p "restoring save files for HOST: $HOST, Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

BACKUP_FILE_NAME="cluster_content_backup.zip"
TMP_FOLDER="/tmp"
TARGET_FOLDER="~/dockers/dont-starve-server/cluster-content"
if scp ./$BACKUP_FILE_NAME "$HOST:$TMP_FOLDER/$BACKUP_FILE_NAME"; then
    ssh -t "$HOST" "cd ~/; tar -xvzf $TMP_FOLDER/$BACKUP_FILE_NAME -C $TARGET_FOLDER/; cd $TARGET_FOLDER/../; docker-compose up &"
    ssh "$HOST" "cd $TARGET_FOLDER/../; nohup docker-compose up"
fi
