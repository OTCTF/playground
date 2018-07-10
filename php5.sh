#!/bin/bash

cd `dirname $0`
THIS_DIR=`pwd`

_enter() {
    docker exec -it `docker ps | grep 'otctf/default:php5' | awk '{print $1}'` /bin/bash
}

start() {
    cd $THIS_DIR
    docker-compose up -d -f ./docker-compose-php5.yml
    _enter
}

stop() {
    cd $THIS_DIR
    docker-compose down -f ./docker-compose-php5.yml
}

case "$1" in
        start|stop)
            COMMAND=$1
            shift
            $COMMAND
            ;;
        *)
            echo $"Usage: $0 {start|stop}"
            exit 1
esac
