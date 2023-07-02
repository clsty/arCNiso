#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
function nofail { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
cd $(dirname $0) && base=$(pwd)

pkgbeg=$(awk '/# ---- BEGINof AUR ---- #/{print NR}' ../packages.x86_64) 
pkgbeg=$(($pkgbeg+1))
pkgend=$(awk '/# ---- ENDof AUR ---- #/{print NR}' ../packages.x86_64) 
pkgend=$(($pkgend-1))

mkdir -p $base/cache; mkdir -p $base/pkgs; cd $base/cache
for i in $(sed -n "$pkgbeg , ${pkgend}p" ../../packages.x86_64) ;
do
  nofail paru -G --noredownload $i
done
