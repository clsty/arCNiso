#!/bin/bash
# @Author: clsty <ph-tyhu@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
while getopts "hf" opt;do
      case $opt in
          "h") help=h;;
          "f") force=f;;
          "?") help=h;;
      esac
done
if [[ "$help" = h ]]; then
  echo "
  这是用于对 cache 下的各目录自动进行下载 PKGBUILD、prepare 和 build 的脚本。
  -f	在 prepare 和 build 时不依次询问是否进行。
  -h	显示此帮助。
  ";exit 0; fi
cd $(dirname $0) && base=$(pwd)
cd $base
if [[ "${force}" != f ]]; then
  bash 1-PKGBUILD.sh
  bash 2-prepare.sh
  bash 3-build.sh
  bash 4-repoadd.sh
else
  bash 1-PKGBUILD.sh
  bash 2-prepare.sh -f
  bash 3-build.sh -f
  bash 4-repoadd.sh
fi
