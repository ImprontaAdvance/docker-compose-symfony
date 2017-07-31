#!/bin/bash

{ # this ensures the entire script is downloaded #

#
# @param string directory
#
create_project() {
    local TMP_DIR
    TMP_DIR=$(mktemp -d)
    local TMP_FILE
    TMP_FILE="$TMP_DIR/dcs.tmp.zip"

    wget https://github.com/ImprontaAdvance/docker-compose-symfony/archive/master.zip -O "$TMP_FILE"
    unzip "$TMP_FILE" -d "$TMP_DIR"
    mkdir -p "$1"
    cp -R "$TMP_DIR/docker-compose-symfony-master/." "$1/"
    rm -rf "$TMP_DIR"
}

if [ "$#" -ne 1 ]
then
    echo "Missing target directory"
else
    create_project $1
    cd $1
fi

}