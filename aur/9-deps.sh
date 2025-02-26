#!/bin/bash
# 此脚本的作用是解决某些 PKGBUILD 少给 make 依赖（可能是因为它们是运行所要求的依赖，但实际上 make 也需要？）导致编译不过的问题。

# btrfs-assistant: qt5-tools btrfs-progs
# efibooteditor: qt6-tools efivar
# zsh-theme-powerlevel10k-git: wget

sudo pacman -S --noconfirm --needed qt5-tools qt6-tools btrfs-progs efivar wget patchelf
