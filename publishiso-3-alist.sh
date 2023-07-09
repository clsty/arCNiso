#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

iso="$(cat publishiso-filename)"

# 先安装 aur/alist-bin，然后 sudo systemctl enable --now alist ，再在浏览器打开alist界面（默认是 http://0.0.0.0:5244），用户名和密码则是看 sudo alist admin --data /var/lib/alist
# 然后添加 123pan 的存储，挂载到 /123pan（注意这是 alist 下的某个目录，不是本地目录），填写用户名与密码，选本地代理，最后勾选流式上传，保存。
# 建议 sudo systemctl enable alist，这样之后 alist 会自动运行。
#
# alist 的作用之一是将网盘等存储变成 webdav 服务。接下来应当用 rclone，可以将 webdav 挂载到本地，或想办法直接用 webdav 上传文件。
# 先安装 rclone，再 rclone config，添加一个实例，名为 123pan，webdav，
# 地址是 http://0.0.0.0:5244/dav/123pan （"http://0.0.0.0:5244/dav/" 是 alist 的 webdav 地址）
# 用户名与密码就是 alist 的那个。
# 这样就添加完毕了，可以用 rclone copy 等方法进行传输。
try rclone deletefile 123pan:/release/arCNiso/"$iso"
rclone copy -P ./release/"$iso" 123pan:/release/arCNiso/

# （以下方法实测不可行）
# 如果想用挂载到本地的方法的话，可以
# mkdir -p ~/123pan
# rclone mount 123pan:/ ~/123pan --cache-dir /tmp/123pan --vfs-cache-mode full --multi-thread-streams 8  --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 800M --buffer-size 4096M
# 最后这句会“卡住”，但实际上只是前台运行罢了。可以放到脚本里，后台运行此脚本。
# 这样就可以通过 ~/123pan 访问 123pan 了。
#rsync -av --progress ./release/$iso ~/123pan/release/arCNiso/
