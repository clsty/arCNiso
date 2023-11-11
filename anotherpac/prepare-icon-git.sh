#!/bin/bash
echo "icons 准备流程开始。"
set -e

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/icons

ping -c1 github.com||if true;then echo "请确保能够连接到网络。";exit 1;fi
echo "!! 现在将准备 icons（使用 git），请确保网络通畅。"
read -p "按回车继续：" tmpvar

cd $target
git clone https://github.com/clsty/papirus-icon-theme||(cd papirus-icon-theme&&git pull)

echo "icons 准备流程完毕。"
