#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="arCNiso"
iso_label="${iso_name}_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="clsty <https://arcn.celestialy.top>"
iso_application="archiso customed by ${iso_publisher}"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
#          'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
#          'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
# archiso 目前改用 systemd-boot，但体积增大
           'uefi-ia32.systemd-boot.esp' 'uefi-x64.systemd-boot.esp'
           'uefi-ia32.systemd-boot.eltorito' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
# 从文件读取数组变量（一个元素一行）并赋给 airootfs_image_tool_options
# 此文件由 makeiso 写入; touch 是防止其它程序 source 本文件时报错文件不存在
touch /tmp/MKARCHISO_IMAGE_TOOL_PROFILE;readarray -t airootfs_image_tool_options < /tmp/MKARCHISO_IMAGE_TOOL_PROFILE
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
	["/etc/shadow"]="0:0:400"
	["/etc/gshadow"]="0:0:400"
	["/root"]="0:0:750"
	["/root/.automated_script.sh"]="0:0:755"
	["/root/.gnupg"]="0:0:700"
	["/usr/local/bin/pacman"]="0:0:755"
	["/usr/local/bin/pacman-reinit"]="0:0:755"
	["/usr/local/bin/choose-mirror"]="0:0:755"
	["/usr/local/bin/Installation_guide"]="0:0:755"
	["/usr/local/bin/arcnguide"]="0:0:755"
	["/usr/local/bin/livecd-sound"]="0:0:755"
	["/usr/local/bin/modifyrootspace"]="0:0:755"
	["/usr/local/bin/arcnlogout"]="0:0:755"
	["/usr/local/bin/arCNiso-xfce4"]="0:0:755"
	["/usr/local/bin/arCNiso-expac"]="0:0:755"
	["/usr/local/bin/arcnadd-cn"]="0:0:755"
	["/usr/local/bin/arcnot"]="0:0:755"
	["/usr/local/bin/tilix-dconf"]="0:0:755"
	["/usr/local/bin/resetkeymap"]="0:0:755"
	["/usr/local/bin/aaa"]="0:0:755"
	["/usr/local/bin/emacsnw"]="0:0:755"
	["/usr/local/bin/emacstutor"]="0:0:755"
	["/usr/local/bin/eviltutor"]="0:0:755"
	["/usr/local/bin/efibooteditor-launcher"]="0:0:755"
	["/usr/local/bin/sufirefox"]="0:0:755"
	["/usr/local/bin/sufirefoxd"]="0:0:755"
	["/usr/local/bin/setfont"]="0:0:755"
	["/usr/local/bin/loadkeys"]="0:0:755"
	["/usr/local/bin/iwctl"]="0:0:755"
	["/usr/local/bin/setupparu"]="0:0:755"
	["/usr/local/bin/paru"]="0:0:755"
	["/usr/local/bin/parui"]="0:0:755"
	["/usr/local/bin/vi"]="0:0:755"
	["/usr/local/bin/vim"]="0:0:755"
	["/usr/local/bin/lynx"]="0:0:755"
	["/usr/local/bin/README"]="0:0:755"
	["/usr/local/arCNiso/prepare.sh"]="0:0:755"
)
