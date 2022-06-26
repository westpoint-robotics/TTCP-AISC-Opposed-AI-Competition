# Gameday

Collection of scripts for smooth execution of a live event.

# Manifest

Before the event collect the pertinent data for each submission and record it
in `manifest.csv`.
This includes the submission name, the docker image, container registry creds (if necessary),
and the name of the script to execute.

__** NOTE **__ Because the `manifest.csv` could hold docker registry login secrets, care should be taken
to prevent it from being displayed to an audience.  

If collecting submitted docker images before gameday, ensure they are loaded on the host
executing the event.

# Launch

Launch runs a shoreside container, an opfor container, and the contestant container.

This folder is mounted into the container, so the event director can launch opfor
scenario scripts prepared in advance while maintaining the flexibility the easily
alter the environment on the fly (but still capitalizing on the benefits of containers).

__** NOTE **__ The `placeholder-*.sh` scripts in this folder are *placeholders* with which to demo these scripts.
The *actual* contestant scripts should be in the working directory of the submitted docker image.

# Logs

Each container collects logs to a location specified by a `--logpath=...` argument
to the container execution script.  For contestants, ensure your primary script
accepts that parameter and propagates it to moos. See the 
`/home/moos/moos-ivp-aquaticus/missions/competition-2022/launch_demo.sh` script 
for an example.
