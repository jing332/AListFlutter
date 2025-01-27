#!/bin/bash
# 0. 进入scripts目录 执行 ./clear.sh

mkdir /tmp/alist
rm -rf /tmp/alist/*
cp -r ../scripts /tmp/alist
cp -r ../alistlib /tmp/alist

rm -rf ../*

cp -r /tmp/alist/* ../