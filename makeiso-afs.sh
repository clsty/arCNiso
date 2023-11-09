#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso makeiso-afs: Used by makeiso for preparing airootfs.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

# 此脚本应当由 makeiso.sh 调用（而不是手动运行）。

# 注意部分目录应列于 .gitignore。编辑此脚本时应注意与之同步。

# 初始设定
set -e # 遇错直接退出
function try { "$@" || sleep 0; }

cache="anotherpac/cache"
sweet="$cache/sweet-theme-backup"
stored="anotherpac/stored"
AFSshare="airootfs/usr/share"

function afs-sync {
# anotherpac 目录就位
mkdir -p $AFSshare/themes/sweet
mkdir -p $AFSshare/Kvantum
mkdir -p $AFSshare/color-schemes
mkdir -p $AFSshare/icons
rsync -av --delete $cache/papirus-icons/Papirus/ $AFSshare/icons/Papirus/
rsync -av --delete $cache/papirus-icons/Papirus-Dark/ $AFSshare/icons/Papirus-Dark/

# 利用 clsty/sweet-theme-backup 项目中大多数路径相对 /usr/share/ 保持一致的特性，批量进行同步
# 注意目录的路径结尾要有斜杠
for i in $(cat<<EOF
/icons/Sweet-cursors/
/themes/sweet/index.theme
/themes/sweet/assets/
/themes/sweet/gtk-2.0/
/themes/sweet/gtk-3.0/
/themes/sweet/gtk-4.0/
/themes/sweet/xfwm4/
/Kvantum/Sweet-transparent-toolbar/
/Kvantum/Sweet-transparent-toolbar/
/color-schemes/Sweet.colors
EOF
)
do rsync -av --delete $sweet/"$i" $AFSshare/"$i"
done

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
}

function afs-clean {
# 清理临时文件（夹）
for i in $(cat<<EOF
etc/skel
root
EOF
)
do try rm -rf ./airootfs/"$i"
done
}

case $1 in
	sync)afs-sync;;
	clean)afs-clean;;
esac
