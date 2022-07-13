# Gameday

Collection of scripts for smooth execution of a live event.

# Manifest

Before the event collect the pertinent data for each performer and record it
in `manifest.csv`.
This includes the submission name, the docker image, container registry creds (if necessary),
and the name of the launch script to execute.

__** NOTE **__ Because the `manifest.csv` could hold docker registry login secrets, care should be taken
to prevent it from being displayed to an audience.  

If collecting submitted docker images before gameday, ensure they are loaded on the host
executing the event.

# Launch

We launch a shoreside container, an team_blue container, and a team_red container.

Ideally, the container's launch script can support running as red or blue.
For example, see how the included *.sh files accept a flag parameter and launched
herons based in its color value.

This allows the possibility of pairing any entry against another entry.
The usage is `./launch.sh <blue> <red> [warp]` (warp defaults to 4).
So we can run any combination:

```bash
# run usma_1ae (1 boat, attack, easy) against usma_1dm (1 boat, defend, medium)
./launch usma_1ae usma_1dm

# run usma_2mm (2 boats, mixed, medium) against usma_1am (1 boat, attack, medium)
./launch usma_2mm usma_1am
```

This folder is mounted into the container, so the event director can launch modified
scenario scripts prepared in advance while maintaining the flexibility the easily
alter the environment on the fly (but still capitalizing on the benefits of containers).

The *actual* performer launch script should be in the working directory of the submitted docker image.

# Logs

Each container collects logs to a location specified by a `--logpath=...` argument
to the container execution script.  For contestants, ensure your primary script
accepts that parameter and propagates it to moos. See the 
`/home/moos/moos-ivp-aquaticus/missions/competition-2022/launch_demo.sh` script 
for an example.
