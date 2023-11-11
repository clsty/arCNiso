#!/bin/bash
echo "sweet theme 准备流程开始。"
set -e
function try { "$@" || sleep 0; }

selfpath="${BASH_SOURCE[0]}"
cd "$(dirname $selfpath)"
basedir="$(pwd)"
target="$basedir"/cache/sweet-theme-backup

mkdir -p "$target"
cd "$target"
try git init -b main
try git remote add origin https://github.com/clsty/sweet-theme-backup.git
git pull --depth=1 origin main

echo "sweet theme 准备流程完毕。"
