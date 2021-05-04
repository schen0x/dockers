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
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

# ./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit
# ./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

# ENABLING MOD
# the IDs are suppose to go into a declare an indexed array first.
# However array is it is shell dependent. And I fail to push new element into it(/bin/bash):
#
# modIDs=()
#   ...
#   then
#       modIDs+=( "$modID" ) # does not work
#   fi
#   ...
# echo "${modIDs[@]}" # value is not inserted
#
# so I stop bother
cat ./cluster-content/Master/modoverrides.lua | while read line
do
    if [[ $line == '["workshop-'* ]]
    then
        # $line === ["workshop-378160973"] = { enabled = true }, 
        modID=`echo "$line" | sed -e 's/\["workshop-//g' -e 's/"\].*//g'`
        # $modID === 378160973
        echo "ServerModSetup(\"$modID\")" >> $install_dir/mods/dedicated_server_mods_setup.lua 
    fi
done 

check_for_file "$install_dir/bin"

cd "$install_dir/bin" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer)
run_shared+=(-console)
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
