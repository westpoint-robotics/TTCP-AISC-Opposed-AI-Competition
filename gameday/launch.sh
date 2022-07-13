#!/bin/bash
entries=manifest.csv
shoreside_script=/comp/shoreside.sh
shoreside_repo=westpointrobotics/aquaticus:jammy
compdir=`pwd`
blue_id=${1:-unknown}
blue=`cat $entries | grep $blue_id`
red_id=${2:-unknown}
red=`cat $entries | grep $red_id`
warp=${3:-4}

if [ -z "$blue" -o -z "$red" ]; then
    echo "usage: $0 <blue_id> <red_id> [warp]"
    echo "select from:"
    cat $entries | grep -v "#" | awk -F, '{print "\t"$1}'
    echo ""
    exit 0
fi

IFS=',' read -ra b  <<< $(echo $blue)
IFS=',' read -ra r  <<< $(echo $red)

# initialize log folder
logdir=`date -u +%Y%m%d_%H%M%SZ`_${b[0]}-vs-${r[0]}
mkdir -p $compdir/log/$logdir
logpath=--logpath=/comp/log/$logdir

# if creds, login
if [ -n "${b[2]}" ]; then
    host=`echo ${b[1]} | awk -F/ '{print $1}'`
    docker login $host -u ${b[2]} -p ${b[3]}
fi
if [ -n "${r[2]}" ]; then
    host=`echo ${r[1]} | awk -F/ '{print $1}'`
    docker login $host -u ${r[2]} -p ${r[3]}
fi

# pull team images
docker pull ${b[1]}
echo ""
docker pull ${r[1]}
echo ""

# run shoreside
docker run --rm -d --name shoreside\
    -e DISPLAY -v /tmp/.X11-unix \
    --net host \
    -v $compdir:/comp \
    $shoreside_repo $shoreside_script $warp $logpath
echo "**** shoreside launched..."
echo ""

# run red
echo docker run --rm -d --name team_red -v $compdir:/comp --net host ${r[1]} ${r[4]} red $warp $logpath
docker run --rm -d --name team_red -v $compdir:/comp --net host ${r[1]} ${r[4]} red $warp $logpath
echo "**** team_red launched..."
echo ""

# run blue
echo docker run --rm -d --name team_blue -v $compdir:/comp --net host ${b[1]} ${b[4]} blue $warp $logpath
docker run --rm -d --name team_blue -v $compdir:/comp --net host ${b[1]} ${b[4]} blue $warp $logpath
echo "**** team_blue launched..."
echo ""

# wait for quit
echo "****"
echo "**** ${d[0]} simulation running\!"
echo "****"
cancel=""
while [ -z "$cancel" ]; do
    echo -n "Quit? [q] "
    read -n 1 cancel
    echo ""
    if [ "$cancel" != "q" ]; then cancel=""; fi
done

# clean up
echo cleaning up...
docker stop shoreside team_blue team_red
