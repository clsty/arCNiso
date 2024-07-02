#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso makeiso-afs: Used by makeiso for preparing airootfs.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

# 此脚本应当由 makeiso 调用（而不是手动运行）。

# 注意部分目录应列于 .gitignore。编辑此脚本时应注意与之同步。

# 初始设定
set -e # 遇错直接退出
function try { "$@" || sleep 0; }

releng="/usr/share/archiso/configs/releng"
cache="anotherpac/cache"
sweet="$cache/sweet-theme-backup"
stored="anotherpac/stored"
AFS="airootfs"
AFSshare="airootfs/usr/share"

function afs-sync {
# releng 就位
# （由于对同一个目标目录、不同来源目录进行多次 rsync，--delete 每次都会导致删文件，这样读写损耗挺大的，不过开启了 CoW 的 btrfs 应该没问题；否则应设法仅在想要刷新时才 --delete；或者将多个 rsync 的任务融合到一起（dry-run 输出列表？）再 --delete）
# 这里暂时先把 --delete 注释掉
#rsync -av --delete "$releng"/airootfs/ $AFS/
rsync -av "$releng"/airootfs/ $AFS/
#rsync -av --delete "$releng"/syslinux/ syslinux/
#rsync -av --delete "$releng"/efiboot/ efiboot/
rsync -av --delete "$releng"/grub/loopback.cfg grub/loopback.cfg
rsync -av --delete "$releng"/bootstrap_packages.x86_64 bootstrap_packages.x86_64

# anotherpac 目录就位
mkdir -p $AFSshare/themes/sweet
mkdir -p $AFSshare/Kvantum
mkdir -p $AFSshare/color-schemes
mkdir -p $AFSshare/icons

rsync -av $stored/usr/ $AFS/usr/
rsync -av $stored/etc/ $AFS/etc/
for i in $(cat<<EOF
choose-mirror.service
iwd.service
systemd-networkd.service
reflector.service
EOF
)
do
rm $AFS/etc/systemd/system/multi-user.target.wants/"$i"
done
rm -r $AFS/etc/systemd/system/reflector.service.d

rsync -av --delete $cache/icons/papirus-icon-theme/Papirus/ $AFSshare/icons/Papirus/
rsync -av --delete $cache/icons/papirus-icon-theme/Papirus-Dark/ $AFSshare/icons/Papirus-Dark/

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
rsync -av ./homebase/public/ ./airootfs/root/
rsync -av ./homebase/skel/ ./airootfs/etc/skel/
rsync -av ./homebase/root/ ./airootfs/root/
pandoc README.md \
  -N \
  --output=./airootfs/etc/skel/README.html \
  --metadata title="arCNiso 自述文档（pandoc 离线版）" \
  --metadata date="$(date +%x)" \
  --to=html5 \
  --css=docs-old/github.css \
  --highlight-style=haddock \
  --standalone
pandoc docs-old/Installation_hint.md \
  -N \
  --output=./airootfs/etc/skel/Installation_hint.html \
  --metadata title="Arch Linux 安装提示（pandoc 离线版）" \
  --metadata date="$(date +%x)" \
  --to=html5 \
  --css=docs-old/github.css \
  --highlight-style=haddock \
  --embed-resources \
  --standalone
#lynx -dump -nolist "https://wiki.archlinux.org/title/Installation_Guide?action=render" >> ./airootfs/etc/skel/Installation_guide.txt

# 直接用 pandoc 加网址，目前会出现 500 Internal Server Error
# 所以先用 curl 下载
curl "https://wiki.archlinuxcn.org/wiki/Installation_Guide?action=render" -o ./airootfs/etc/skel/Installation_guide.curl.html

pandoc "./airootfs/etc/skel/Installation_guide.curl.html" \
  -N -f html \
  --output ./airootfs/etc/skel/Installation_guide.html \
  --metadata title="安装指南（来自 Arch Linux 中文维基，pandoc 离线版）" \
  --metadata date="$(date +%x)" \
  --to=html5 \
  --css=docs-old/github.css \
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
