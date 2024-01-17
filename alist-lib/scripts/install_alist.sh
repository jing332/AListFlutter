#!/bin/bash

function build() {
    echo "Building $1 $2"

    export CGO_ENABLED=1
    export GOOS=android
    export GOARCH="$1"

    FN="libalist.so"
    rm -f ${FN}

    cd ../alist || exit
    go build -ldflags "-s -w" -o ${FN}

    mkdir -p ../../android/app/libs/"$2"
    cp -f ${FN} ../../android/app/libs/"$2"
}

build "$1" "$2"