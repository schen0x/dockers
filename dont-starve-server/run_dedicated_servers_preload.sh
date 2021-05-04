#!/bin/bash

DSHOME="/root"
steamcmd_dir="$DSHOME/steamcmd"
install_dir="$DSHOME/dontstarvetogether_dedicated_server"
cluster_name="MyDediServer"
dontstarve_dir="$DSHOME/.klei/DoNotStarveTogether"

function fail()
{
    echo Error: "$@" >&2
    exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
        fail "Missing file: $1"
    fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"
#check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
#check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
#check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
#check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit
