#!/bin/bash
. /comp/surveyor_positions.sh
folder=/home/moos/moos-ivp-rlagent/missions/uk_training
sleep 3
cd $folder/surveyor
./launch_surveyor.sh $red_one --role=AGENT_BEH $@ &
sleep 5

echo "Running simulation..."
cd $folder/shoreside
uPokeDB targ_shoreside.moos DEPLOY_ALL=true MOOS_MANUAL_OVERRIDE_ALL=false RETURN_ALL=false >/dev/null 2>&1
echo "empty_sim complete"
