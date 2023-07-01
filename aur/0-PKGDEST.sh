#!/bin/bash
# @Author: clsty <ph-tyhu@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
# 若需要手动 makepkg ，可以 source 此脚本以确保所打的包输出到正确位置。

cd $(dirname $0) && base=$(pwd)
export PKGDEST="$base/pkgs"
