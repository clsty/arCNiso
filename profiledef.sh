#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="arCNiso"
iso_label="${iso_name}_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="clsty"
iso_application="archiso customed by ${iso_publisher}"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
	'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
	'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
#airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '15' '-b' '1M')
file_permissions=(
	["/etc/shadow"]="0:0:400"
	["/etc/gshadow"]="0:0:400"
	["/root"]="0:0:750"
	["/root/.automated_script.sh"]="0:0:755"
	["/usr/local/bin/choose-mirror"]="0:0:755"
	["/usr/local/bin/Installation_guide"]="0:0:755"
	["/usr/local/bin/arcnguide"]="0:0:755"
	["/usr/local/bin/livecd-sound"]="0:0:755"
	["/usr/local/bin/modifyrootspace"]="0:0:755"
	["/usr/local/bin/arCNiso-xfce4"]="0:0:755"
	["/usr/local/bin/arCNiso-expac"]="0:0:755"
	["/usr/local/bin/arcnot"]="0:0:755"
	["/usr/local/bin/resetkeymap"]="0:0:755"
	["/usr/local/bin/nofail"]="0:0:755"
	["/usr/local/bin/emacsnw"]="0:0:755"
	["/usr/local/bin/emacstutor"]="0:0:755"
	["/usr/local/bin/eviltutor"]="0:0:755"
	["/usr/local/bin/efibooteditor-launcher"]="0:0:755"
	["/usr/local/bin/sufirefox"]="0:0:755"
	["/usr/local/bin/sufirefoxd"]="0:0:755"
	["/usr/local/bin/setfont"]="0:0:755"
	["/usr/local/bin/loadkeys"]="0:0:755"
	["/usr/local/bin/iwctl"]="0:0:755"
	["/usr/local/bin/paru"]="0:0:755"
	["/usr/local/bin/parui"]="0:0:755"
	["/usr/local/bin/vi"]="0:0:755"
	["/usr/local/bin/vim"]="0:0:755"
	["/usr/local/bin/lynx"]="0:0:755"
	["/usr/local/bin/README"]="0:0:755"
	["/usr/local/arCNiso/prepare.sh"]="0:0:755"
)
