#!/usr/bin/env bash
# add to [[runner]]
# pre_clone_script = "umask 0022"
# then cleanup runner caches & volumes
DRYRUN=${DRYRUN-}
VOLUMEPATTERN="${VOLUMEPATTERN:-gitlab.*runner}"
JQ="jq -M"
vv() {
    echo "$@">&2
    "$@"
}

drvv() {
    echo "$@">&2
    if [[ -z $DRYRUN ]];then
        "$@"
    fi
}

RUNNER_CACHE_CONTAINERS=$( docker ps -a | egrep "runner.*cache" | awk '{print $1}'; )
RUNNER_VOLUMES=""
# clean docker cache containers
for i in $RUNNER_CACHE_CONTAINERS;do
    infos="$(docker inspect $i)"
    if ( echo "$infos" | $JQ .[0].Mounts | egrep -q "$VOLUMEPATTERN" );then
        declare -a mounts="$( echo "$infos" | $JQ .[0].Mounts )"
        for m in "${mounts[@]}";do
            if ( echo "$m" | $JQ .[0].Destination | egrep -q "$VOLUMEPATTERN" );then
                RUNNER_VOLUMES="$RUNNER_VOLUMES $( echo "$m" | $JQ .[0].Name  -r)"
            fi
        done
    fi
done
# clean docker volumes
for i in $RUNNER_CACHE_CONTAINERS;do
    drvv docker rm -f $i
done
for i in $RUNNER_VOLUMES;do
    drvv docker volume rm -f $i
done
# vim:set et sts=4 ts=4 tw=80:
