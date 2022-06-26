#!/bin/bash
folder=/home/moos/moos-ivp-aquaticus/missions/competition-2022
cd $folder/heron
# Gus Red
./launch_heron.sh g r1 r2 -s --start-x=140 --start-y=45 --start-a=240 $@ &
# Luke Red
./launch_heron.sh l r2 r1 -s --start-x=140 --start-y=35 --start-a=240 $@

# Note the last command is run in the foreground
