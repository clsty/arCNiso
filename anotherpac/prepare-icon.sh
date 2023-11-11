#!/bin/bash
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/papirus-icons
tmpdir="/tmp/anotherpac/icons"

rm -rf "$tmpdir"
mkdir -p "$tmpdir"
mkdir -p "$target"
cd "$tmpdir"

# 如果只需要部分目录，为什么使用 svn？
# 见 https://unix.stackexchange.com/questions/233327/is-it-possible-to-clone-only-part-of-a-git-project
# 对比过多种方法，都没有达到“因为我只想下载特定目录所以别花费多余流量，也别花费多余时间”的目的（shallow clone 并没有减少不需要下载的目录所占用的流量，sparse-checkout 则一个一个文件下载也太慢）
# 除了上面 stackexchange 的贴子，别的网站的某些教程也是用到 sparse-checkout 特性，但给的步骤大错特错，比如甚至在 git remote 这一步就开始用 -f 下载整个 git 仓库了；而没用 -f 的也好不到哪去，前面明明是设置了 sparse-checkout 特性，后面却竟然还是调用 git pull 来下载文件，而 git pull 在下载阶段并不会遵守前面设置的特性（等于设置了个寂寞），完全没有节省流量，只是最后从 .git 目录把文件放到主目录里时才遵守了 sparse-checkout 指定的目录，这完全就是自欺欺人（要用 sparse-checkout 省流量的话，就必须让下载文件的步骤放在 git checkout，所以应当先进行不会下载主体文件的 git fetch 而不是 git pull）
echo "现在开始下载主要文件。"
svn export https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/trunk/Papirus-Dark
svn export https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/trunk/Papirus
echo "下载完毕。"
ls -al
rsync -rDtl --info=PROGRESS2 --delete "Papirus-Dark"/ "$target"/"Papirus-Dark"/
rsync -rDtl --info=PROGRESS2 --delete "Papirus"/ "$target"/"Papirus"/
rm -rf "$tmpdir"

echo "icons 准备流程完毕。"
