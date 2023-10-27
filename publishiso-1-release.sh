#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

echo ${1? 错误：请指定一个参数，作为版本号（git tag），例如 v1.0.0。当前已有版本号：$(git tag -l)} || exit
echo $1 >publishiso-version

git add .
# git commit 在无文件要提交时会 exit 1
try git commit -am "Update of $1 Release."
git tag -f $1
git push
git push --tags -f

originiso="$(fd --base-directory OUT .iso)"
source profiledef.sh
iso="${iso_name}-${iso_version}-$1-${arch}.iso"
echo $iso >publishiso-filename
mkdir -p release
cp -f OUT/$originiso release/$iso || if ! test -f release/$iso; then exit 1; fi

sed -i "1c\文件名：$iso" result.log
sed -i "1c\文件名：$iso" result.md
