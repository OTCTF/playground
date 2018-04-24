#!/bin/bash

cd `dirname $0`
THIS_DIR=`pwd`

_enter() {
    docker exec -it `docker ps -q | head -n 1` /bin/bash
}

start() {
    cd $THIS_DIR
    docker-compose up -d $@
    _enter
}

stop() {
    cd $THIS_DIR
    docker-compose down
}

case "$1" in
        start|stop)
            COMMAND=$1
            shift
            $COMMAND $@
            ;;
        *)
            echo $"Usage: $0 {start|stop}"
            exit 1
esac
