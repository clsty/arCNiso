#!/bin/bash
echo "注：此脚本暂时没有什么作用。"&&exit
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/sweet-theme

ping -c1 github.com||if true;then echo "请确保能够连接到网络。";exit 1;fi
echo "!! 现在将准备 sweet theme，请确保网络通畅。"
read -p "按回车继续：" tmpvar

mkdir -p "$target"
cd "$target"
try git init -b master
try git remote add origin https://github.com/EliverLara/Sweet.git
git pull --depth=1 origin master

echo "sweet theme 准备流程完毕。"
