#!/bin/bash

cat $PWD/config/* > config.yaml

docker stop mock-server > /dev/null 2>&1
docker rm mock-server > /dev/null 2>&1

docker run \
  --name mock-server \
  -p 9876:8080 \
  --volume $PWD/config.yaml:/config.yaml \
  --volume $PWD/monkey.yaml:/monkey.yaml \
  quii/mockingjay-server:1.12.0 \
  -config=/config.yaml \
  -monkeyConfig=/monkey.yaml \
  -port=8080