#!/bin/bash

#! /bin/bash
cd `dirname "$0"`
PATH_DIR=`pwd`

ENV_DIR=$PATH_DIR

setIPEnv() {
    export TEST_SEVER="223.252.216.178"
    if [[ `uname -a | awk '{print $1}'` = 'Darwin' ]]; then
       export IP_ADDRESS=`ifconfig en0 | grep 'inet '| cut -d' ' -f2|head -1`
    fi
    if [[ `uname -a | awk '{print $1}'` = 'Linux' ]]; then
       export IP_ADDRESS=`ifconfig enp3s0 | grep 'inet '| awk '{print $2}' | sed 's/addr://g'`
    fi

    if [[ ! -n $IP_ADDRESS ]]; then
       echo ""
       echo "START ERROR!"
       echo "======================================"
       echo "启动失败，需要ip地址，可以尝试使用『虚拟地址』"
       echo ""
       echo "eg:"
       echo "macOS run    'sudo ifconfig en0 alias 172.31.254.254 255.255.255.0'"
       echo "Linux run    'sudo ifconfig eth0:0 172.31.254.254'"
       echo ""
       exit 1
    fi
    echo 'current ip address: '$IP_ADDRESS
}

up() {
    setIPEnv
    cd $ENV_DIR
    docker-compose up -d $@
}

down() {
    cd $ENV_DIR
    docker-compose down
}

restart() {
    setIPEnv
    cd $ENV_DIR
    docker-compose restart $@
}

case "$1" in
        up|restart|down)
            COMMAND=$1
            shift
            $COMMAND $@
            ;;
        *)
            echo $"Usage: $0 {up|restart|down}"
            exit 1
esac
