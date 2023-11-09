#!/bin/bash
# 此脚本用于获取原版 PKGBUILD 以供参照。
cd $(dirname $0)
mkdir -p origin-PKGBUILD
for i in $(cat<<EOF
plasma5-themes-sweet-full-git
plasma5-themes-sweet-kde-git
EOF
)
do
curl -o origin-PKGBUILD/"$i" "https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=$i"
done
