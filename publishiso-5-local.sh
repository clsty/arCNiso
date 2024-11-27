#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish files.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
#
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

iso="$(cat publishiso-filename)"
filter=$(cat<<EOF
+ $(cat publishiso-filename)
+ README.md
-s *
+r *
EOF
)

cat <(echo "$filter")

function testthefile {
echo "正在测试 $1 是否存在..."
echo "此测试将无限循环，直到 $1 存在"
aaa test -f "$1"
}
testthefile ./ignoredinfo/rsyncpath-local

ls $(cat ./ignoredinfo/rsyncpath-local)

echo "$filterfile"
echo "正在用 rsync 同步 iso..."
cp -f ./result.md ./release/README.md
aaa rsync --delete-before --info=progress2 -vr \
  -f._<(echo "$filter") \
  ./release/ $(cat ./ignoredinfo/rsyncpath-local)

ls $(cat ./ignoredinfo/rsyncpath-local)
