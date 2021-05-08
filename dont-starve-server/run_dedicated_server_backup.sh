#!/bin/bash
# the script is passed to the server in literal, then the tilde is expanded before the execution.
WORKPATH=~/dockers/dont-starve-server/cluster-content/
TARGET="./"
OUTPUT="/tmp/cluster_content_backup.zip"
cd $WORKPATH
tar -cvzf $OUTPUT $TARGET
