#!/bin/bash
cd $(dirname $0)
set -e
#docker pull quay.io/archlinux/archlinux
docker build -t clsty/arcniso .
set +e
docker run -dt --restart=unless-stopped --privileged -v .:/home/archer/arCNiso --name arCNiso clsty/arcniso
