---
title: 长期维护
layout: /src/layouts/autonum.astro
sidebar:
  label: 长期维护
  order: 04
---

:::note
本项目的维护工作目前由 clsty 执行，这里仅作为记录与参考，并不是指构建或使用本项目须参与维护。

当然，假如本项目最后一次发布镜像的时间距现在超过两个月，使用者就可能要参考本节内容来构建最新镜像了。
:::

维护工作包括若干方面。

# 追踪更新
追踪更新是其中最基本的（即使不是工作量最大的），这里对其进行简要说明。

## mkarchiso
首先要更新系统，确保使用了最新的 `archiso` 包。

然后，根据特定场景实行相应的步骤。

- 场景：源文件 `mkarchiso-original`（由 `/usr/bin/mkarchiso` 复制而来，Arch Linux 官方提供）可能有更新。
  1. 使用 `PATCH.sh`，将 mkarchiso 打补丁到位（若源文件的更新超过了补丁的容错范围，补丁可能会应用失败，这时需要手动操作）。
  2. 使用 `DIFF.sh`，根据官方 mkarchiso 与刚刚处理好的补丁版 mkarchiso 进行对比，来更新补丁。

- 场景：想要对补丁版 mkarchiso 进行修改。
  1. 利用 `DIFF.sh` 判断 `mkarchiso.patch` 是否精确反映了差异；若否，先按源文件有更新来处理。
  2. 按需修改补丁版 mkarchiso。
  3. 使用 `DIFF.sh`，根据官方 mkarchiso 与刚刚修改好的补丁版 mkarchiso 进行对比，来更新补丁。

- 场景：想要对 diff 的参数进行修改，例如 `diff -u` 变成 `diff -U5`。
  1. 利用 `DIFF.sh` 判断 `mkarchiso.patch` 是否精确反映了差异；若否，先按源文件有更新来处理。
  2. 按需修改 `DIFF.sh` 中的所有 diff 命令。
  3. 删除 `mkarchiso.patch`，再使用 `DIFF.sh` 创建新补丁。

## Firefox
主要是对 Firefox 插件的更新，以及对书签作适当调整。
```bash
./layer-home/preparefirefox.sh
```
按照指示操作即可。

## layer-rootfs
主要是将 `layer-rootfs` 目录所引用的几个仓库与上游进行同步：
- <https://github.com/clsty/papirus-icon-theme>
- <https://github.com/clsty/sweet-theme-backup>

## releng

### 必要性

本项目是基于 releng 的，而 releng 本身与 archiso 工具又是不断更新的。
这就会导致一个问题：如果本项目从旧 releng 拿来的基础部分不变，却与新 releng 偏离过大，则可能无法用最新的 archiso 及配套工具来成功构建本项目的 arCNiso 镜像（或者即使得到了镜像也无法正常运行）。

### 方法论

- 基本要求：避免启用会自动整理代码风格的功能（比如 Lazyvim 默认开启的某个插件），否则可能会给逐行比对（diff）带来巨大麻烦。
- 关注 GitLab 上 releng 的最新变化，如
  - [archiso 中 releng 的 commits](https://gitlab.archlinux.org/archlinux/archiso/-/commits/master/configs/releng?ref_type=heads)
  - [releng 的 commits](https://gitlab.archlinux.org/archlinux/releng/-/commits/master/?ref_type=HEADS)
- 使用 diff 类工具（除 diff 本身以外还有多种 TUI/GUI 前端可选）对比本项目目录与 archiso 所提供的 `/usr/share/archiso/configs/releng` 目录。


# 其他
- `./getiso`：适用于在另一台机器上构建镜像的场景。

- `./testiso`：用于利用 VirtualBox 对镜像进行测试运行。
  - 使用前可能需要手动配置 VirtualBox 虚拟机（参见[环境要求](/using/run/#%E7%8E%AF%E5%A2%83%E8%A6%81%E6%B1%82)），并使虚拟机名为 arCNiso。
  - 推荐将 `ignored/path` 设置为共享目录，自动挂载到虚拟机内，以便在宿主机与虚拟机之间传输文件（但是 symlink 类的无法直接这样传输，可以先用 tar 打包，或换用 ssh 的 scp 传文件）。

- `./publishiso` 等系列脚本：用于自动发布。
