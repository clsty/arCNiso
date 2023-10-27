#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

# 利用 github-cli 与 transmission 与 qbittorrent-nox 自动发布。
# 种子文件会上传到 GitHub Releases。此过程中，iso 文件也会一并上传（需要大小小于 2GiB）
# 需要配置 github-cli 。使用 gh auth login 。
#
# 注：为什么一定是两个软件（transmission,qbittorrent）而不是一个呢？
# 因为，经过大量实验，找不到任何通过 bash 让 qbittorrent 制作种子（create seed）的方法；
# 也同样经过大量实验，找不到任何通过 bash 让 transmission 识别到已经存在的 iso 镜像文件从而自动做种（seeding）的方法。
# 各种实验都以失败告终。不要再浪费时间了。
# 目前用 transmission 制作种子，用 qbittorrent-nox 做种，简便易行，这样就足够了。
#
# 未来可能：找个云服务器，使用 seafile 以 https 分享文件。
# 另外，github 好像支持 2G 以内的 release？不过还是不考虑，速度太慢还容易断连（国内），用 kgithub 等也太占用资源了。
# 做得比较成熟、具有一定知名度之后，还可以找 tuna、ustc 等镜像站请求做镜像。

# 用 transmission 做种后，以 qbittorrent 发布的方法（来自网络，出处找不到了，放在这里供备用）
# （直接运行本脚本，实测是可以的，所以不需要看这个）
# 首先配置 qbittorrent：
# In "Downloads" change "Save files to location" to the location of the data in the node that is going to be seeding
# otherwise that node wont know it has the files specified in the torrent and wont seed them.
# In "Speed" tab uncheck "Enable bandwidth management (uTP)"
# Uncheck "Apply rate limit to uTP connections" to avoid issues with the torrents sometimes starting as queued and requiring a "force resume"
# In "BitTorrent" tab uncheck "Torrent Queueing". This doesn't appear to have fixed the problem 100% though
# 然后运行以下命令开始做种：
# $ qbittorrent-nox ~/path/to/torrent/file/name_of_file.torrent

trackerlist="https://gitea.com/XIU2/TrackersListCollection/raw/branch/master/best.txt"

function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

ver="$(cat publishiso-version)"

tf="$(pwd)/bt/arCNiso.$ver.torrent"
tfr="$(pwd)/bt/arCNiso.latest.torrent"
iso="$(cat publishiso-filename)"
try rm $tf
try rm $tfr
mkdir -p bt
# 每天只更新一次tracker
date="$(date +%Y%m%d)"
olddate="$(try cat bt/trackerlistdate)"
if [ y"$date" != y"$olddate" ]; then curl "$trackerlist" -o bt/tracker.txt; fi
echo "$date" >bt/trackerlistdate

echo "开始制作种子。"
# 使用 transmission 制作种子；qbittorrent-nox 不在 cli 中提供此工具
transmission-create "$(pwd)/release/$iso" -o $tf -c "$ver 版本发布的镜像文件。源地址：https://github.com/clsty/arCNiso"
for i in $(cat bt/tracker.txt); do
	transmission-edit -a "$i" $tf
done
echo "结束制作种子。"

echo "开始添加种子。"
# 默认在浏览器访问 http://localhost:8080 即可进入 qbittorrent 界面（WebUI）。
echo "尝试在后台运行 qbittorrent-nox..."
try qbittorrent-nox -d # 尝试在后台运行
echo "尝试向 qbittorrent-nox 添加任务..."
qbittorrent-nox "$tf" --save-path="$(pwd)/release/"
#transmission-remote --add "$tf" --download-dir "$(pwd)/release/"
#transmission-remote -t $(transmission-remote -l | grep "$iso" | awk '{print $ver}') -s --find "$(pwd)/release/"
echo "结束添加种子。"

echo "开始创建 $ver 的 release 。"
cp $tf $tfr
try gh release delete $ver -y
echo "注：若在这上面出现 release not found 是因为尝试删除指定 release 未果，是正常的。"
gh release create $ver $tfr --generate-notes --latest --notes-file result.log --verify-tag
gh release upload $ver "$(pwd)/release/$iso"
echo "结束创建 $ver 的 release 。"
