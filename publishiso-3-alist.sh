#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

iso="$(cat publishiso-filename)"

# 注意，此自动发布已失效！！
# 当前配置：打开web代理、webdav本地代理，
# 根文件夹ID填0，
# 打开流式上传，
# 结果：要么提示 504 method not allowed，要么提示 object not found，
# （但是上传 README.org 这种级别的小文件就完全没问题。）
# 如果不打开流式上传，则会立即上传到 100%（显然，这是本地缓存）然后等15分钟都没传完（显然是卡了，平时5分钟就传完了的）

# 先安装 aur/alist-bin，然后 sudo systemctl enable --now alist ，再在浏览器打开alist界面（默认是 http://0.0.0.0:5244），用户名和密码则是看 sudo alist admin --data /var/lib/alist
# 然后添加 123pan 的存储，挂载到 /123pan（注意这是 alist 下的某个目录，不是本地目录），填写用户名与密码，选本地代理，最后勾选流式上传，保存。
# 建议 sudo systemctl enable alist，这样之后 alist 会自动运行。
#
# alist 的作用之一是将网盘等存储变成 webdav 服务。接下来应当用 rclone，可以将 webdav 挂载到本地，或想办法直接用 webdav 上传文件。
# 先安装 rclone，再 rclone config，添加一个实例，名为 123pan，webdav，
# 地址是 http://0.0.0.0:5244/dav/123pan （"http://0.0.0.0:5244/dav/" 是 alist 的 webdav 地址）
# 用户名与密码就是 alist 的那个。
# 这样就添加完毕了，可以用 rclone copy 等方法进行传输。
echo "现在可以打开以下网页手动上传了。"
echo "https://www.123pan.com/2433802/2433803"
releasepath="$(pwd)/release"
wl-copy "$releasepath" && echo "Path \"$releasepath\" has been copied."

# rclone delete 会将一个目录下的所有文件（包括子文件夹里的）都删除，且无需确认，也不会报错；但是所有子文件夹都不会被删除
#try rclone delete clsty:/public/arCNiso/release
#rclone copy -P ./release/"$iso" clsty:/public/arCNiso/release/
function testthefile {
echo "正在测试 $1 是否存在..."
echo "此测试将无限循环，直到 $1 存在"
aaa test -f "$1"
}
testthefile ./ignored/rsyncpath

echo "正在用 rsync 删除已存在的 iso..."
aaa rsync --delete-before --info=progress2 -avre ssh ./emptyfolder/ $(cat ./ignored/rsyncpath)
echo "正在用 rsync 同步 iso..."
cp -f ./result.md ./release/README.md
aaa rsync --delete-before --info=progress2 -avre ssh ./release/ $(cat ./ignored/rsyncpath)

# （以下方法实测不可行）
# 如果想用挂载到本地的方法的话，可以
# mkdir -p ~/123pan
# rclone mount 123pan:/ ~/123pan --cache-dir /tmp/123pan --vfs-cache-mode full --multi-thread-streams 8  --vfs-read-chunk-size 256M --vfs-read-chunk-size-limit 800M --buffer-size 4096M
# 最后这句会“卡住”，但实际上只是前台运行罢了。可以放到脚本里，后台运行此脚本。
# 这样就可以通过 ~/123pan 访问 123pan 了。
#rsync -av --progress ./release/$iso ~/123pan/release/arCNiso/
