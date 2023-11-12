#!/bin/bash
set -e
cd $(dirname $0)

# 除 diff/patch 外，另一种补丁方案（据说主要是 Debian 在用）是 Quilt
patchfile='mkarchiso.patch'
oldfile='mkarchiso-original'
newfile='mkarchiso'
cp -f /usr/bin/mkarchiso ./$oldfile


function try { "$@" || sleep 0; }

function CheckPatchMatch {
echo "开始检查补丁文件($3)是否完全精确地反映了原文件($1)与新文件($2)的文件内容差异。"

originalpath=$(pwd)

echo "正在创建临时目录："
temp_dir=$(mktemp -d)
echo "$temp_dir"

echo "复制待测文件到临时目录中："
cp "$1" $temp_dir/"$1"
cp "$2" $temp_dir/"$2"
cp "$3" $temp_dir/"$3"
cd $temp_dir

# （对原文件的副本）应用补丁文件（若不完全匹配，会生成 $1.orig）
echo "临时目录的文件列表："
ls -l
echo "正在对原文件的临时副本应用补丁文件："
patch $1 -N -p0 -i $3 --backup-if-mismatch

echo "正在检查结果..."
# 双保险，检查应用了补丁的原文件副本与新文件副本的文件内容差异
diff_result=$(diff -q -U5 $temp_dir/"$1" $temp_dir/"$2")
test -f "$1.orig"&&diff_result=notexact
test -f "$1.rej"&&diff_result=notsuccess

echo "正在清理临时目录..."
cd $originalpath&&rm -rf $temp_dir

# 返回判断值
if [ -z "$diff_result" ]; then
  export MATCH=true
else
  export MATCH=false
fi
echo "结束检查流程。"
}

newfileEXIST=1;test -f "$newfile"||newfileEXIST=0
patchfileEXIST=1;test -f "$patchfile"||patchfileEXIST=0

case $newfileEXIST$patchfileEXIST in
  "11")echo "已找到 $newfile 和 $patchfile。";;
  "10")echo "已找到 $newfile，未找到 $patchfile。"
    read -p "要根据 $oldfile 和 $newfile 建立 $patchfile 吗？[y/N]" p
    case $p in
      [yY]) try diff -U5 $oldfile $newfile >$patchfile;;
    esac; exit ;;
  "01")echo "错误：未找到 $newfile，已找到 $patchfile。"
    echo "可能没有运行过 PATCH.sh？";exit 1;;
  "00")echo "致命错误：未找到 $newfile 和 $patchfile。"
    echo "请准备补丁文件或已打补丁的文件。";exit 1;;
esac

try CheckPatchMatch "$oldfile" "$newfile" "$patchfile"
case $MATCH in
  true)echo -e "补丁文件 $patchfile 已精确反映了原文件 $oldfile 和新文件 $newfile 的差异。\n今日无事可做。";exit;;
  false)echo "补丁文件 $patchfile 不是最新的。";;
  *)echo "错误：变量 \$MATCH 的值为\"$MATCH\"。";exit 1;;
esac

read -p "要在当前原文件\"$oldfile\"和新文件\"$newfile\"的基础上更新补丁\"$patchfile\"吗？[y/N]" yn
case $yn in
  [yY]) try diff -U5 $oldfile $newfile >$patchfile;;
  *) exit
esac

echo "补丁文件 $patchfile 已更新。注意，若其位于 Git 仓库中，可能导致 Git 仓库变化。"
