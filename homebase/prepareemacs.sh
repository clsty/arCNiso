#!/bin/bash
set -e

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"

target="$basedir"/public/.emacs.d
rsync -av --delete "$target"/ "$target".gitignored/

which emacs||sudo pacman -S --needed emacs-nativecomp
ping -c1 mirrors.ustc.edu.cn||if true;then echo "请确保能够连接到网络。";exit 1;fi
echo "!! 现在将准备 .emacs.d，请确保网络通畅。"
echo "1. 接下来会调用两次 sudo，分别用于 mount --bind 和 umount 到 ~/.emacs.d 。"
echo "2. emacs 将被运行，并自动安装插件。安装成功之后请自行将其退出（为此可使用 Ctrl-x Ctrl-c，或 :qa，或 Alt-x kill-emacs 等），脚本会继续运行并恢复原 emacs 配置（若存在）。"
read -p "按回车继续：" tmpvar
sudo mount -m --bind "$target".gitignored ~/.emacs.d
emacs -nw
sleep 3
sudo umount ~/.emacs.d

rsync -av --delete "$target".gitignored/eln-cache/ "$target"/eln-cache/
rsync -av --delete "$target".gitignored/elpa/ "$target"/elpa/
rm -rf "$target".gitignored

echo ".emacs.d 准备流程完毕。"
