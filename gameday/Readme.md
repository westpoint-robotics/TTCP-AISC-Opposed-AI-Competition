# Gameday

Collection of scripts for smooth execution of a live event.

# Manifest

Before the event collect the pertinent data for each performer and record it
in `manifest.csv`.
This includes the submission name, the docker image, and the name of the launch script to execute.

If collecting submitted docker images before gameday, ensure they are loaded on the host
executing the event.

# Launch

We launch a shoreside container, a team_blue container, and a team_red container.

We inject a launch scripts into the container. So it is helpful if entries have
a readme file in the working directory describing how the behavior(s) can be launched.

Ideally, the image can support running as red or blue. 
Or separate images could be submitted.
For example, see how the included *.sh files accept a flag parameter and launched
herons based in its color value.

This allows the possibility of pairing any entry against another entry.
The usage is `./launch.sh <blue> <red> [warp]` (warp defaults to 4).
So we can run any combination:

```bash
# run usma_de (1 boat, defend, easy) against demo_am (1 boat, attack, medium)
./launch demo_de demo_am

# run usma_2mm (2 boats, mixed, medium) against usma_1am (1 boat, attack, medium)
./launch usma_2mm usma_1am
```

This folder is mounted into the container, so the event director can launch modified
scenario scripts prepared in advance while maintaining the flexibility the easily
alter the environment on the fly (but still capitalizing on the benefits of containers).
