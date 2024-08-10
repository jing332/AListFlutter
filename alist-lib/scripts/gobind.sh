#!/bin/bash

cd ../alistlib || exit
if [ "$1" == "debug" ]; then
  gomobile bind -ldflags "-s -w" -v -target="android/arm64"
else
  gomobile bind -ldflags "-s -w" -v
fi

echo "Moving aar and jar files to android/app/libs"
mkdir -p ../../android/app/libs
mv -f ./*.aar ../../android/app/libs
mv -f ./*.jar ../../android/app/libs
