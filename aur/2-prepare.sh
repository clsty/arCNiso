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
这是用于对 cache 下的各目录自动进行 prepare 的脚本。
此脚本每次进入一个目录，会显示其内容，并询问是否需要 prepare。
-f	不询问，对所有目录进行 prepare。
-h	显示此帮助。
";exit 0; fi
cd $(dirname $0) && base=$(pwd)
cd $base/cache
t=(*)
for i in "${t[@]}";do
	cd "$base/cache/$i"
	echo "========进入 $i"; ls; pp=n
	if [[ "${force}" != f ]]; then read -r -p "以上是 $i 目录的情况。是否 prepare？[a(余下全是)/y(是)/N(否)]" pp;case $pp in
	     [yY]) echo 好的，开始 prepare... ;;
	     [aA]) force=f ;;
	      *) continue ;;esac;fi
        aaa makepkg -o --nodeps
done
