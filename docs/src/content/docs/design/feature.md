---
title: 特性列表
layout: /src/layouts/autonum.astro
sidebar:
  label: 特性列表
  order: 01
---

以下尝试列举本镜像相对于官方 archiso 所具有的特性（细节过多，可能会有所遗漏）。

# 启动与内核

## 安全启动
利用 shim 添加了安全启动支持。

:::note
这只是说，在开启安全启动时可以正常启动 arCNiso，并非是使用 arCNiso 安装的系统一定支持安全启动。当然，若要安装一份支持安全启动的 Linux，则本身支持安全启动的 Live CD 也是便利的。
:::
## 内核参数
添加了 `usbcore.autosuspend=-1 btusb.enable_autosuspend=N bluetooth.disable_ertm=Y` 作为内核参数，以提升部分外设连接的稳定性。
## 分区与系统引导
- 提供 TestDisk 作为 TUI 的分区表恢复及引导修复软件（原版 archiso 也有）。
- 提供 Timeshift 、btrfs-assistant 及 Snapper 作为快照的备份恢复软件。
- 提供 EFIBootEditor 作为 efibootmgr 的 GUI 前端。
- 提供 Ventoy（同时具有 GUI 与 CLI）以进行一些特殊操作。
## 用户引导
- motd：添加了中文版本的 motd，并在 arCNiso 启动时自动展示。
- 安装指南：提供 `Installation_guide` 命令的一个等价入口 `arcnguide` ，并改为用 Firefox 打开中文版的 Wiki 页面及本镜像提供的 hint。
- 根分区大小：通过内核参数 `cow_spacesize=1G` 配置为 1 GiB（而不是原版 archiso 的 256 MiB），并提供 `modifyrootspace` 供实时修改。


# 图形环境

以 xfce4 为核心，进行了多方面的配置。

## 主题
主要主题为 sweet，图标主题为 papirus，以 kvantum 作为引擎。
## 壁纸
采用 [high-rise buildings during nighttime](https://unsplash.com/photos/lmvGn9rTGvY)，据称于 2018.1.15 的冬夜摄于北京中信大厦（中国尊）98 层。

没有版权问题，而且是张不错的城市夜景图。
## 字体
配置 fontconfig。
## 终端
采用 Tilix。
## 命令行
采用 oh-my-zsh 以及 powerlevel10k。
## 用户
设置了 archer 作为具有 sudo 权限且自动登录的用户。


# 硬件与外设

## 全局键位
在 Bootloader 界面可以选择交换左 `Ctrl` 与大写锁定键。
## 蓝牙
配置了蓝牙所需的软件包、内核模块与服务。
## 屏幕键盘
安装了 onboard，并将其启动器放在 xfce 的右下角。
## 亮度
提供了 brightnessctl。
## 音频
安装了 pipewire 相关的软件包。
## 显卡驱动
为多种显卡及虚拟机环境添加了显卡驱动。
## 网络
- 添加了 NetworkManager 相关软件并启用相关服务（以 `wpa_supplicant` 作为无线后端）。
- 将 xfce4 的 wavelan 插件的默认网卡从 lo 改为 wlp1s0。
- 禁用 systemd-networkd 并移除了 iwd、dhcpcd、dhclient 以防冲突。
- 提供命令行工具 git、curl。


# 网络应用

## Firefox 浏览器
安装了 Firefox 浏览器并移除了 lynx；若运行 lynx，则在找不到 lynx 时询问是否要立即安装或使用 Firefox 替代。

## 通讯软件
由于这些软件在离线时无法使用，本项目不打算将它们内置（所以并不属于本项目的特性），将安装命令放在这里仅供参考。
- nheko：（开源开放的）Matrix 通讯架构的客户端，需要配合 keepassXC 使用。
  - 安装命令： `sudo pacman -S nheko`
- Gajim：支持 Jabber/XMPP 协议（一种开源开放的即时通讯协议）。
  - 安装命令： `sudo pacman -S gajim`
- Quassel IRC：支持 IRC 协议（一种开源开放的即时通讯协议）。
  - 安装命令： `sudo pacman -S quassel-monolithic-qt`
- QQ：本项目建立了 `~/.config/QQ/crash_files` 以防止 QQ 闪退。
  - 安装命令： `paru linux-qq`
- 邮箱：未预装邮件客户端，建议通过 Firefox 在线访问邮箱的网页端。


# 本地应用
## 本地化

- 区域：配置了时区等。
- 语言：配置了中文。
- 输入法：配置了 fcitx5-rime。

## 命令行与自动化
- 为 zsh 安装了 oh-my-zsh 配置框架及 p10k 主题。
- AUR 构建：本项目在构建来自 AUR 的包时，使用脚本尽可能做到自动化。
- alias：内置的 zsh 被配置使用了一些 alias，详见其 zshrc。
- 内置脚本：在 `/usr/local/bin/` 内置了一些脚本，以供快速执行一些任务。

## 编辑器与文件管理

- 提供了 GUI 的 emacs 与 TUI 的 emacsnw（本质上是 `emacs -nw` ）
  - 配置了 evil。
- 提供了 TUI 的 nvim 及简单配置与美化。
- 移除了 vim；在找不到 vi、vim 时，使用 nvim 自动替代之。
- 提供 GUI 文件管理器 Thunar。
- 提供 vi 键位风格的 TUI 文件管理器 vifm 与 ranger，以增强文件操作效率。
- 提供 TUI 的 ncdu 以快速查看存储占用分布。
- 提供命令行工具 ack、tree、fd。
- 提供 peazip 及 p7zip 以支持解压缩。

## 其它

- Xfce4-screenshooter：用于截图。
- Ristretto：图像查看器。
- fastfetch：展示系统信息。

# 软件包与源

- 配置了国内的镜像源。
- 提供命令 `arcnadd-cn` 来快速启用 archlinuxcn 社区仓库源，并启用 rngd 来加速密钥环的添加。
  - 注：本项目与 archlinuxcn 社区无关。
- 在使用 AUR 助手 paru 时半自动安装 paru 和 base-devel。
- 禁用了 choose-mirror 与 reflector 服务（但仍可手动运行）。
- 为 pacman 添加防呆设计。
