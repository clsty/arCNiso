#!/bin/bash
set -e

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"

target="$basedir"/skel/.mozilla/firefox/fawis2kz.default-release

cleanff() {
for i in $(cat<<EOF
cert_override.txt
SiteSecurityServiceState.txt
storage-sync-v2.sqlite-shm
favicons.sqlite-wal
favicons.sqlite.corrupt
protections.sqlte
sessionstore.jsonlz4
cookies.sqlite-wal
cookies.sqlite
key4.db
logins.json
sessionstore.js
permissions.sqlite
content-prefs.sqlite
webappsstore.sqlite-wal
webappsstore.sqlite
formhistory.sqlite
cache2
safebrowsing
crashes
storage
datareporting
startupCache
minidumps
saved-telemetry-pings
thumbnails
sessionstore-backups
bookmarkbackups
EOF
)
do rm -rf "$target"/"$i";done
}

cleanff

which firefox || sudo pacman -S --needed firefox
ping -c1 archlinuxcn.org || if true; then
	echo "请确保能够连接到网络。"
	exit 1
fi
echo "!! 现在将准备 Firefox 的配置目录，请确保网络通畅。"
echo "Firefox 将被运行。在此期间，请自行配置插件等。完毕之后，请自行将其退出（建议在退出前，设置>隐私与安全>Cookie 和网站数据>清除数据，以及历史记录>清除历史记录）。"
read -p "按回车继续：" tmpvar
firefox --profile "$target"
sleep 1
cleanff
#for i in "favicons.sqlite-wal" "favicons.sqlite.corrupt" "protections.sqlte" "sessionstore.jsonlz4" "cookies.sqlite-wal" "cookies.sqlite" "key4.db" "logins.json" "sessionstore.js" "permissions.sqlite" "content-prefs.sqlite" "webappsstore.sqlite" "formhistory.sqlite" cache2 safebrowsing crashes storage datareporting startupCache minidumps saved-telemetry-pings thumbnails sessionstore-backups; do
# 注意不要动 "storage-sync-v2.sqlite" 和 "storage-sync-v2.sqlite-wal" ，否则插件数据可能会没，比如 Dark Reader
echo "Firefox 准备流程完毕。"
