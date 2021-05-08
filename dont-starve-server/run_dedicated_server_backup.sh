#!/bin/bash
WORKPATH=~/dockers/dont-starve-server/cluster-content/
TARGET=./
OUTPUT=~/cluster_content_backup.zip
cd $WORKPATH
tar -cvzf $OUTPUT $TARGET
