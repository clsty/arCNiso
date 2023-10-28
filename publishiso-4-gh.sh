#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso publishiso: auto publish file.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License

# 利用 github-cli 自动发布。
# iso 文件会上传至 GitHub Releases（需要大小小于 2GiB）
# 需要配置 github-cli 。使用 gh auth login 。

function try { "$@" || sleep 0; }
set -e
cd $(dirname $0)

ver="$(cat publishiso-version)"

iso="$(cat publishiso-filename)"

echo "开始上传 iso 文件至 GitHub Releases。"
gh release upload $ver "$(pwd)/release/$iso"
echo "结束上传 iso 文件至 GitHub Releases。"
