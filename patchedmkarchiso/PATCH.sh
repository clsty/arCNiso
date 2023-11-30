#!/bin/bash
set -e
cd $(dirname $0)

cp -f /usr/bin/mkarchiso ./mkarchiso-original
patch mkarchiso-original -N -p0 -i mkarchiso.patch -o mkarchiso||sleep 0
chmod +x mkarchiso
echo "补丁已打，但可能失败（看上面的提示）并生成 mkarchiso.rej 文件。"
echo "若有失败部分，请一边阅读 ./mkarchiso.rej，一边手动编辑 ./mkarchiso。"
echo "直到手动打完补丁之后，为了下次更好合并，建议在当前目录运行 ./DIFF.sh 以生成新的补丁。"
