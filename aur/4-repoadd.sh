#!/bin/bash
# @Author: clsty <celestial.y@outlook.com>
# @Title: arCNiso aur-builder: auto build aur packages to local repo.
# @URL: https://github.com/clsty/arCNiso
# @License: GNU GPL v3.0 License
cd $(dirname $0)
repo-add pkgs/aur.db.tar.gz pkgs/*.pkg.tar.zst
