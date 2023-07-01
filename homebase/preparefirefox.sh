#!/bin/bash
set -e

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"

target="$basedir"/skel/.mozilla/firefox/fawis2kz.default-release

which firefox||sudo pacman -S --needed firefox
ping -c1 archlinux.org||if true;then echo "请确保能够连接到网络。";exit 1;fi
echo "!! 现在将准备 Firefox 的配置目录，请确保网络通畅。"
echo "Firefox 将被运行。在此期间，请自行配置插件等。完毕之后，请自行将其退出（建议在退出前，设置>隐私与安全>Cookie 和网站数据>清除数据，以及历史记录>清除历史记录）。"
read -p "按回车继续：" tmpvar
firefox --profile "$target"

echo "Firefox 准备流程完毕。"
