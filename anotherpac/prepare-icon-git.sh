#!/bin/bash
echo "icons 准备流程开始。"
set -e

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/icons

mkdir -p $target;cd $target
git clone https://github.com/clsty/papirus-icon-theme||(cd papirus-icon-theme&&git pull)

echo "icons 准备流程完毕。"
