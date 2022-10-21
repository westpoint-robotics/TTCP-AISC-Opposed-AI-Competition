#!/bin/bash
. /comp/surveyor_positions.sh
folder=/home/moos/aquaticus-ctf/moos-ivp-rlagent/missions/oct_wp_competition-2022
flag=${1:-blue}
role=${2:-mitll_defend}
warp=${3:-1}
shift
shift

if [ "${CONDA_DEFAULT_ENV}" != "aquaticus-ctf" ]; then
    eval "$(conda shell.bash hook)"
    conda activate aquaticus-ctf
fi

cd $folder/surveyor

if [ "$flag" == "blue" ]; then
    # Blue Kirk
    ./launch_surveyor.sh $blue_one --role=CONTROL $@
else
    # Red Gus
    ./launch_surveyor.sh $red_one --role=CONTROL $@
fi

cd $folder

if [ "$role" == "mitll_attack" ]; then
    python3 $folder/deploy_rllib_defender_policy.py --agent=${flag}_one --timewarp=$warp $folder/rllib_checkpoints/ppo_defender_localframe/checkpoint_000543/checkpoint-543
else
    python3 $folder/deploy_rllib_attacker_policy.py --agent=${flag}_one --timewarp=$warp $folder/rllib_checkpoints/ppo_attacker_localframe/checkpoint_002105/checkpoint-2105
fi
