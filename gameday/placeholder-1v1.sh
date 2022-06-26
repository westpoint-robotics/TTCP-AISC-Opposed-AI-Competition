#!/bin/bash
folder=/home/moos/moos-ivp-aquaticus/missions/competition-2022
cd $folder/heron
# Gus Red
./launch_heron.sh k b1 b1 -s --start-x=20 --start-y=45 --start-a=60 $@

# Note the last command is run in the foreground
