---
title: 难与不难
---

难或不难，这是一个问题。

# arCNiso 希望为你保留有意义的“难度”

arCNiso 本质上仍然是 archiso。

以安装 Arch Linux 为例，它几乎没有降低“最终完成”的那个时刻的难度。

- 你仍需经历各个步骤（初步检查、联网更新、设置文件系统、pacstrap、chroot 等），且其中的一部分即使在 arCNiso 中也是必须用终端（模拟器）完成的。
- 你所遵照的指南与教程，大概率也会让你全程使用终端；反而是仅当你对原理比较理解时，你才能自如地利用上 arCNiso 所提供的各种 GUI 工具。


# arCNiso 希望为你降低无意义的“难度”


## 舒适

相比原版 archiso，使用 arCNiso 是舒适的，部分对比见下表：

| |archiso|arCNiso|
|-|-|-|
|基本界面|tty|xfce4|
|字体显示|终端点阵|图形环境|
|语言环境|仅英文|默认中文界面、中文输入法|
|终端|tty|Tilix 及 pty|
|shell|grml-zsh|oh-my-zsh、p10k|
|浏览器|lynx|Firefox 及其插件|
|WiFi|iwctl|nmtui|
|指针输入|无|鼠标、触摸屏、触控板|
|安全启动|无|支持|

## 引导

相比原版 archiso，使用 arCNiso 更容易上手。

核心部分是在图形环境启动时，显示中文欢迎界面进行简洁而又充分的引导。其中最重要的是：

- 命令 README 会展示自述文档。
- 命令 `arcnguide` 会打开中文版的官方安装指南，以及[对照式安装帮助](https://github.com/clsty/arCNiso/blob/main/docs/Installation_hint.md)；后者又将引导至[入门与进阶帮助](https://github.com/clsty/arCNiso/blob/main/docs/learn.md)。

这有助于新手快速找到探索方向，并进入合理的学习路线。

此外，还有一些细节上的设计：

- 命令 eviltutor 可供学习 Vim 式编辑器的基本操作；
- 命令 paru 与 parui 会自动先更新 pacman 数据库并安装 base-devel；
- 命令 modifyrootspace 可修改根分区容量大小；
- 命令 resetkeymap 将重置键位映射；
- ……


# 难乎哉？不难也

综上：

如果你只是想单纯地试用 arCNiso：

- 几乎没有什么难度。

如果你的目标是安装（或维护）Arch Linux：

- arCNiso 不会降低最终难度，但会通过一系列设计，帮你优化学习路线，从而降低上手难度。
- arCNiso 提升了使用的舒适性，从而降低了心理负担。
- 当你最终完成 Arch Linux 的安装（或熟练进行维护）时，你的收获实际上与使用官方 archiso 是一致的。

