#!/bin/bash
# 3. 进入scripts目录 执行 ./init_gomobile.sh

go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
go get golang.org/x/mobile/bind