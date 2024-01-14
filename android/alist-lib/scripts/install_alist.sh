#!/bin/bash

export dir=$PWD
function build() {
    echo "Building $1 $2 ${PWD}"

    export CGO_ENABLED=1
    export GOOS=android
    export GOARCH="$1"

    FN="libalist.so"
    rm -f ${FN}

    go build -ldflags "-s -w" -o ${FN}

    mkdir -p ${dir}/../app/libs/$2
    cp -f ${FN} ${dir}/../app/libs/$2
}

#cp -f ./frp-*/conf/* ../app/src/main/assets/defaultData

build $1 $2

# function build_all() {
#     rm -f $1
#     build $1 "arm" "armeabi-v7a"
#     build $1 "arm64" "arm64-v8a"
#     build $1 "386" "x86"
#     build $1 "amd64" "x86_64"
# }

# cd frp-*/cmd
# cd ./frpc
# build_all frpc

# cd ./frps
# build_all frps
