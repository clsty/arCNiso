#!/bin/bash
if [ -z "$1" ];then
  docker exec -it arCNiso /bin/bash
else
  docker exec -it arCNiso "$@"
fi
