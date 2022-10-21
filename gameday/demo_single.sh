#!/bin/bash
. /comp/surveyor_positions.sh
folder=/home/moos/moos-ivp-aquaticus/missions/oct_wp_competition-2022
flag=${1:-blue}
mission=${2:-demo_de}
shift
shift

role=DEFEND_E
if [ "$mission" = "demo_dm" ]; then role=DEFEND_MED; fi
if [ "$mission" = "demo_am" ]; then role=ATTACK_MED; fi
if [ "$mission" = "demo_ae" ]; then role=ATTACK_E; fi

cd $folder/surveyor

if [ "$flag" == "blue" ]; then
    # Blue Kirk
    ./launch_surveyor.sh $blue_one --role=$role $@
else
    # Red Gus
    ./launch_surveyor.sh $red_one --role=$role $@
fi

# Note the last command is run in the foreground
