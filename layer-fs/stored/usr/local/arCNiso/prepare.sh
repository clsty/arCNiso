#!/bin/bash
# 此脚本在开机启动时用 systemd 自动运行。
locale-gen
runuser -l archer -c 'tilix-dconf load'

function resetkeymap(){
  rm -f \
    /home/archer/.xmodmap \
    /root/.xmodmap \
    /etc/X11/xorg.conf.d/10-keyboard.conf \
    /etc/vconsole.conf
}
cat /proc/cmdline | grep -q 'swapctrlcaps=true' || resetkeymap
