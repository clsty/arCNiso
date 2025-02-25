#!/bin/bash
echo "icons 准备流程开始。"
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/icons/papirus-icon-theme

mkdir -p "$target";cd "$target"
#git clone https://github.com/clsty/papirus-icon-theme||(cd papirus-icon-theme&&git pull)
try git init -b master
try git remote add origin https://github.com/clsty/papirus-icon-theme.git
git pull --depth=1 origin master

echo "icons 准备流程完毕。"
