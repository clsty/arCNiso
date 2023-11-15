#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
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
aaa rsync --delete-before --info=progress2 -avr \
  -f._<(echo "$filter") \
  ./release/ $(cat ./ignoredinfo/rsyncpath-local)

ls $(cat ./ignoredinfo/rsyncpath-local)
# （以下方法实测不可行）
# 如果想用挂载到本地的方法的话，可以
# mkdir -p ~/123pan
# rclone mount 123pan:/ ~/123pan --cache-dir /tmp/123pan --vfs-cache-mode full --multi-thread-streams 8  --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 800M --buffer-size 4096M
# 最后这句会“卡住”，但实际上只是前台运行罢了。可以放到脚本里，后台运行此脚本。
# 这样就可以通过 ~/123pan 访问 123pan 了。
#rsync -av --progress ./release/$iso ~/123pan/release/arCNiso/
