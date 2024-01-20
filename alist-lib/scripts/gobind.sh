#!/bin/bash

cd ../alistlib || exit
if [ "$1" == "mini" ]; then
  gomobile bind -ldflags "-s -w" -v -androidapi 19 -target="android/arm64"
else
  gomobile bind -ldflags "-s -w" -v -androidapi 19
fi

mv -f *.aar ../../android/app/libs
mv -f *.jar ../../android/app/libs