#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
while getopts "hf" opt;do
      case $opt in
          "h") help=h;;
          "f") force=f;;
          "?") help=h;;
      esac
done
if [[ "$help" = h ]]; then
echo "
这是用于对 ../../packages.x86_64 中的 AUR 包自动下载 PKGBUILD 的脚本。
-f	不询问，对所有 AUR 包下载 PKGBUILD。
-h	显示此帮助。
";exit 0; fi
cd $(dirname $0) && base=$(pwd)

pkgbeg=$(awk '/# ---- BEGINof AUR ---- #/{print NR}' ../packages.x86_64) 
pkgbeg=$(($pkgbeg+1))
pkgend=$(awk '/# ---- ENDof AUR ---- #/{print NR}' ../packages.x86_64) 
pkgend=$(($pkgend-1))

mkdir -p $base/cache; mkdir -p $base/pkgs; cd $base/cache
get=true
if [[ "${force}" != f ]]; then read -r -p "是否从 AUR 下载 PKGBUILD？[a(余下全是)/y(是)/N(否)]" pp;case $pp in
	     [yY]) echo 好的，开始 prepare... ;;
	     [aA]) force=f ;;
	     *) get=false ;;esac;fi
for i in $(sed -n "$pkgbeg , ${pkgend}p" ../../packages.x86_64) ;
do
  if $get;then aaa paru -G --noredownload $i;fi
done
