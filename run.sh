#!/bin/bash

cd `dirname $0`
THIS_DIR=`pwd`

_enter() {
    count=$(docker ps | grep 'otctf/env' | awk '{print NR}')
    if [ "$count" != "1" ]; then
      echo -e "\033[31mONLY ONE RUNNING OTCTF/ENV IS ALLOWED!\033[0m"
      exit 1
    fi
    docker exec -it `docker ps | grep 'otctf/env' | awk '{print $1}'` /bin/bash
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
