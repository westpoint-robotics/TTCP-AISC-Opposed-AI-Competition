#!/bin/bash
. /comp/surveyor_positions.sh
folder=/home/moos/moos-ivp-rlagent/missions/uk_training
flag=${1:-blue}
mission=${2:-ukdstl_attack}
shift
shift
role=AGENT_BEH

# clean up container
cd $folder
sudo chown -R moos:moos *
./clean.sh

# cd $folder/surveyor
# ./launch_surveyor.sh $red_one --role=$role $@ &

python3 /comp/ukdstl_attack.py

# Note the last command is run in the foreground
