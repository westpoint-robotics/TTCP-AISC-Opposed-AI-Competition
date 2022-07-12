#!/bin/bash
entries=manifest.csv
shoreside_script=/comp/shoreside.sh
control_repo=westpointrobotics/aquaticus:jammy
compdir=`pwd`
target=${1:-unknown}
shift
meta=`grep $target $entries`

if [ -z "$meta" ]; then
    echo "usage: $0 <contestant-entry> [warp]"
    echo "select from:"
    cat $entries | grep -v "#" | awk -F, '{print "\t"$1}'
    echo ""
    exit 0
fi

IFS=',' read -ra d  <<< $(echo $meta | sed s/\ //g)

# initialize log folder
logdir=`date -u +%Y%m%d_%H%M%SZ`_${d[0]}
mkdir -p $compdir/log/$logdir
logpath=--logpath=/comp/log/$logdir

# if creds, login
if [ -n "${d[2]}" ]; then
    host=`echo ${d[1]} | awk -F/ '{print $1}'`
    docker login $host -u ${d[2]} -p ${d[3]}
fi

# pull contestant image
docker pull ${d[1]}

# run shoreside
docker run --rm -d --name shoreside\
    -e DISPLAY -v /tmp/.X11-unix \
    --net host \
    -v $compdir:/comp \
    $control_repo $shoreside_script $logpath $@

# run opfor
docker run --rm -d --name opfor -v $compdir:/comp --net host $control_repo ${d[5]} $logpath $@

# run contestant
docker run --rm -d --name contestant -v $compdir:/comp --net host ${d[1]} ${d[4]} $logpath $@

# wait for quit
echo ${d[0]} simulation running\!
cancel=""
while [ -z "$cancel" ]; do
    echo -n "Quit? [q] "
    read -n 1 cancel
    echo ""
    if [ "$cancel" != "q" ]; then cancel=""; fi
done

# clean up
echo cleaning up...
docker stop shoreside opfor contestant
