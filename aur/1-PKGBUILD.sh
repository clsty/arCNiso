#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
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

#cd "$base"/custom/PKGBUILD
#t=(*)
#for i in "${t[@]}";do
#	echo "找到了自定义 PKGBUILD $i"
#	mkdir -p "$base"/cache/"$i"
#	cp -f "$i" "$base"/cache/"$i"/PKGBUILD
#done
