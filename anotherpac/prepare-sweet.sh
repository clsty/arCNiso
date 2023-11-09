#!/bin/bash
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/sweet-theme-backup

ping -c1 github.com||if true;then echo "请确保能够连接到网络。";exit 1;fi
echo "!! 现在将准备 sweet theme，请确保网络通畅。"
read -p "按回车继续：" tmpvar

mkdir -p "$target"
cd "$target"
try git init -b main
try git remote add origin https://github.com/clsty/sweet-theme-backup.git
git pull --depth=1 origin main

echo "sweet theme 准备流程完毕。"
