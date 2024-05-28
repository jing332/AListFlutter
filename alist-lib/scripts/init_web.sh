#!/bin/bash

curl -L https://github.com/asogii/alist-web/releases/latest/download/dist.tar.gz -o dist.tar.gz
tar -zxvf dist.tar.gz
rm -rf ../public/dist
mv -f dist ../public
rm -rf dist.tar.gz
