#!/bin/bash
## An example script to launch the aquaticus docker container
## You have a different x auth mechanism

docker run --rm -it \
--net host \
-e DISPLAY \
-v /tmp/.X11-unix \
-v $HOME/.Xauthority:/home/moos/.Xauthority \
--name aquaticus \
westpointrobotics/aquaticus $@
