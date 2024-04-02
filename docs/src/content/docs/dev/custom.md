---
title: 如何定制
layout: /src/layouts/autonum.astro
sidebar:
  label: 如何定制
  order: 03
---

简单的文件修改是可以直接进行的，例如你想修改欢迎界面，可直接修改 `motd-zh_CN` ，然后用 `./makeiso` 再次构建即可。

而如果你想做一些深层次的定制，比如添加、删除一些包或 systemd 服务等，你就需要了解项目内各个文件与目录结构的作用了。

- 为此，请先知晓：本项目（除去一些其他文件以外）在最终构建时相当于 mkarchiso 的一个 config，原本基于官方 archiso 的 releng。
  因此，你所需要的正是 [ArchWiki 的 archiso 条目](https://wiki.archlinux.org/title/Archiso)。
  - 注意，从 Git 仓库的角度来说，arCNiso 不包含 releng 本体，在某种意义上可视为对 releng 的一个补丁。
- 其次，你可以看看[特性列表](/design/feature/)与[设计说明](/design/idea/)，它能告诉你 arCNiso 的诸多设计细节。

**此外，你还应当了解以下信息：**

- 由于 arCNiso 不包含 releng 本体，直接编辑 airootfs、efiboot、syslinux 等是无效的。正确做法是编辑 arCNiso 用以生成 airootfs 所用到的脚本 `makeiso-afs.sh` 及相关文件（夹）。
  - `makeiso-afs.sh` 同时也用于生成 efiboot、syslinux 等；但是其实 arCNiso 采用 grub 作为 bootloader，故编辑 efiboot、syslinux 本来也是没有意义的，除非对 bootloader 也作更改。
- 你可以使用 `arCNiso-expac` 来查看按“实际占用空间”（包括依赖等）排序的软件包列表。
- 从 tty 可以手动启动图形环境，可运行 `arCNiso-xfce4` 。
- `/usr/local/bin` 存放了大量 arCNiso 的脚本，其中以 `arcn` 开头的主要面向使用者，`arCNiso-` 开头的主要面向开发者。
- 留心 `.gitignore` 中的每一行。
  - 由 `.gitignore` 忽略的文件（夹）不会被包含在 Git 仓库中，通常是临时性或者外部性的，在构建前准备好，或在构建中生成。
  - 合理的 `.gitignore` 可以保护 Git 仓库免受临时性文件的拖累。
- `profiledef.sh` 中的 `airootfs_image_tool_options` 设定了压缩算法参数，它会影响到构建时长、镜像体积和镜像启动时长等。
  - 推荐在测试构建时使用 gzip 1 级，这样能构大大加快构建速度。
  - 构建成品时则推荐使用 zstd 18 级，在压缩率尚可的同时比 xz 具有快得多的启动速度。
