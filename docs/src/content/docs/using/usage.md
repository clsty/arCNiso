---
title: 使用指南
layout: /src/layouts/autonum.astro
sidebar:
  label: 使用
  order: 30
---

:::tip
开机弹出的欢迎界面中已经给出了最关键的“注意事项”，**读完这个就可以直接开始使用了。**

以下则是没那么重要的“技巧提示”及“问题与应对”。
:::


# 技巧提示（知道了会更好）


## 推荐

先学会 vim 式编辑器的基本使用方法（为此可运行 `eviltutor`），以便获得本镜像中 vifm/ranger/emacs/firefox 等软件所带来的效率提升。

> vim 本身是高效的、人体工学友好的编辑器，而它的键位设计在很多别的程序中也会以默认方案或可选插件等形式出现。


## 命令行 shell

> 简称 shell，也就是终端模拟器（tilix）里面的（或者说“连接着的”“承载着的”）那个存在。
> 官方 archiso 与本项目的默认 shell 都是 zsh。

如果你第一次使用命令行 shell，你至少应该了解：
- 按 `Ctrl`+`C` 终止（卡住的时候请试试这个）。
- 在命令没打完的时候，试试按 `Tab` 键或上下方向键来补全。

其他快捷键可参见 [21 个专业 Linux 用户喜爱的实用终端快捷键](https://linux.cn/article-16228-1.html)。


## 终端（tilix）

**缩放字体大小：** `Ctrl`+`=` 与 `Ctrl`+`-` 。

**翻页：** `Shift`+`PageUp` 向上翻页、 `Shift`+`PageDown` 向下翻页。

**复制粘贴：** 先用鼠标选中，再 `Ctrl`+`Shift`+`C` 复制；用 `Ctrl`+`Shift`+`V` 粘贴（仅终端；一般的复制粘贴仍然是 `Ctrl`+`C` 及 `Ctrl`+`V` ）。

**会话（即标签页）与终端（实际上是指分割视图的小终端窗格）：** `Ctrl`+`Shift`+`T` 新建会话、 `Ctrl`+`Alt`+`1` `Ctrl`+`Alt`+`2` 切换会话、 `Ctrl`+`Alt`+`A` 自动新建终端、 `Alt`+`1` `Alt`+`2` 切换终端、 `Ctrl`+`Shift`+`W` 关闭当前会话或终端。


## 一些终端程序

**安装软件：** 使用 paru 可以从 AUR 安装软件。在 arCNiso 中使用 paru 的一种方法是，输入 `parui` 进入搜索界面。

**alias：** 请使用 `grep ^alias ~/.zshrc` 查看对 zsh 生效的命令别名，它们有助于你提高输入命令的效率。

**vifm：** 在 arCNiso 中使用 `vifm` 时，可以依次按 `Z` `Z`（注意大小写）退出并切换工作目录。


## 输入法

按左 `Ctrl`+`空格` 以切换输入法，按 `Ctrl`+`;` 打开剪贴板管理器（按 `ESC` 退出）。


## 更多

- arCNiso 的更多功能，详见[特性列表](/design/feature)。


# 问题与应对（一般用不到）

- 不小心进入了 tty
  - 启动时，会自动登录 tty1 并启动 xfce4。若不小心切到了别的 tty，可以用 `Ctrl`+`Alt`+`F1` 再切回来。
- 在 VirtualBox 虚拟机中使用本镜像时，不够稳定，尤其是 Firefox。
  - 建议使用 VMSVGA 作为显卡控制器、启用 3D 加速并给足显存（128 MB）。
  - 在 Linux 下建议改用 QEMU/KVM 虚拟机。
- 桌面上的面板（任务栏）未加载出来。
  - 在 VirtualBox 虚拟机下，偶尔会遇到这种情况。此时可用 `arcnlogout` 退出（并自动重启）桌面环境。

其他问题可以来 [Issues](https://github.com/clsty/arCNiso/issues) 反馈，或在 [Discussions](https://github.com/clsty/arCNiso/discussions) 中提问。
