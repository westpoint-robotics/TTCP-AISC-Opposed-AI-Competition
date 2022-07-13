#!/bin/bash
folder=/home/moos/moos-ivp-aquaticus/missions/competition-2022
flag=${1:-blue}
shift

cd $folder/heron

if [ "$flag" == "blue" ]; then
    # Blue Kirk
    ./launch_heron.sh k b1 b1 -s --start-x=20 --start-y=45 --start-a=60 --role=ATTACK_E $@
else
    # Red Gus
    ./launch_heron.sh g r1 r1 -s --start-x=140 --start-y=45 --start-a=240 --role=ATTACK_E $@
fi

# Note the last command is run in the foreground
