#!/bin/bash
# usage: sh ./backup_handler.sh $SERVER_IP
HOST=$1
BACKUP_SCRIPT_FILE="./run_dedicated_server_backup.sh"
echo "try to backup save files for HOST: $HOST"
if ssh "$HOST" < $BACKUP_SCRIPT_FILE; then
    scp "$HOST:~/cluster_content_backup.zip" ./cluster_content_backup.zip
fi
