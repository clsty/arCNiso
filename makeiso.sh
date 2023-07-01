#!/bin/bash
# @Author: clsty <ph-tyhu@outlook.com>
# @Title: arCNiso makeiso: auto make iso file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

# 初始设定
set -e # 遇错直接退出
function try { "$@" || sleep 0; }

# 时间测量开始
echo "开始构建。"
TIME1=`date +%Y%m%d-%H:%M:%S`
TIME1_s=`date +%s`

# 位置与权限校正
cd $(dirname $0)
sudo chown -R $(whoami):$(whoami) .

# 家目录就位
rsync -av --delete ./homebase/public/ ./airootfs/etc/skel/
rsync -av --delete ./homebase/public/ ./airootfs/root/
rsync -av ./homebase/skel/ ./airootfs/etc/skel/
rsync -av ./homebase/root/ ./airootfs/root/
# TODO: pandoc 目前无法将org文件中的 "#+begin/end_quote" 中包含的 "=...=" 或 "~...~" 等行内代码块正确地转换出来，无论是输出到md还是html都如此。
# 当前只能避免在 "#+begin/end_quote" 中使用 "=...=" 或 "~...~" 等行内代码块。
pandoc docs/README.org \
       -N \
       --output=./airootfs/etc/skel/README.html \
       --metadata title="arCNiso 自述文档（pandoc 离线版）" \
       --metadata date="$(date +%x)" \
       --to=html5 \
       --css=docs/github.css \
       --highlight-style=haddock \
       --standalone
pandoc docs/Installation_hint.org \
       -N \
       --output=./airootfs/etc/skel/Installation_hint.html \
       --metadata title="Arch Linux 安装提示（pandoc 离线版）" \
       --metadata date="$(date +%x)" \
       --to=html5 \
       --css=docs/github.css \
       --highlight-style=haddock \
       --embed-resources \
       --standalone
#lynx -dump -nolist "https://wiki.archlinux.org/title/Installation_Guide?action=render" >> ./airootfs/etc/skel/Installation_guide.txt
#curl "https://wiki.archlinuxcn.org/wiki/Installation_Guide?action=render" -o ./airootfs/etc/skel/Installation_guide.html
pandoc "https://wiki.archlinuxcn.org/wiki/Installation_Guide?action=render" \
       -N -f html \
       --output ./airootfs/etc/skel/Installation_guide.html \
       --metadata title="安装指南（来自 Arch Linux 中文维基，pandoc 离线版）" \
       --metadata date="$(date +%x)" \
       --to=html5 \
       --css=docs/github.css \
       --highlight-style=haddock \
       --embed-resources \
       --standalone

# 本地软件仓库与源就位
# 以下通过软链接到 /tmp 下，获得不含变量的路径（因为 pacman.conf 似乎不支持含变量的路径），以供后续使用。
mkdir -p /tmp/arCNiso;touch /tmp/arCNiso/touched
rm /tmp/arCNiso/* # 注意这里应当只有软链接及 touched
ln -sf $(pwd)/aur/pkgs /tmp/arCNiso/aur
ln -sf $(pwd)/pacman.d /tmp/arCNiso/pacman.d

# 构建
mkdir -p OUT TMP
sudo rm -rf OUT TMP
sudo mkarchiso -v -w TMP -o OUT ./
sudo rm -rf TMP
sudo chown -R $(whoami):$(whoami) ./OUT
mv OUT/"$(fd --base-directory OUT .iso)" OUT/arCNiso.iso

# 清理临时家目录
try rm -rf ./airootfs/etc/skel
try rm -rf ./airootfs/root

# 输出信息
echo "文件名：$(fd --base-directory OUT .iso)" > result.log
echo -n "大小：" >> result.log
du -a -B MB OUT/*.iso|cut -f1 -d"	" >> result.log
echo "sha256sum：" >> result.log
sha256sum OUT/*.iso |cut -f1 -d" " >> result.log
cat result.log

# 时间测量结束
TIME2=`date +%Y%m%d-%H:%M:%S`
TIME2_s=`date +%s`
TIMEpass=$[ $TIME2_s - $TIME1_s ]
echo "构建结束。"
echo "开始于 $TIME1 -- 经过 $TIMEpass 秒 --> 结束于 $TIME2"
