#!/bin/bash
set -e
cd $(dirname $0)
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }

echo "正在安装所需依赖..."

function install { sudo pacman -S --needed --noconfirm efitools sbsigntools; }

install || (aaa sudo pacman -Sy && install) || aaa sudo pacman -Su --noconfirm || aaa install

echo "正在安装 shim-signed..."
if test -f ../aur/pkgs/shim-signed*.pkg.tar.zst
  then sudo pacman -U --noconfirm ../aur/pkgs/shim-signed*.pkg.tar.zst
  else aaa paru -S --needed --noconfirm shim-signed
fi
