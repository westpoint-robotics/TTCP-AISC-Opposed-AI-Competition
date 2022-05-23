#!/bin/bash
## An example script to launch the aquaticus docker container
## You may need to adjust your xauth mechanism to see your X11 ui

docker run --rm -it \
--net host \
-e DISPLAY \
-v /tmp/.X11-unix \
--name aquaticus \
westpointrobotics/aquaticus:jammy $@
