---
title: 设计说明
layout: /src/layouts/autonum.astro
sidebar:
  label: 设计说明
  order: 02
---

以下给出部分设计的背景原因与考量。

# pacman 防呆
为 `pacman` 添加防呆设计，以检查 `pacman-init.service` 的执行情况。
- 原因：已发现在添加 archlinuxcn 社区仓库源密钥时，pacman-init.service 中的 `Exec=pacman-key --populate` 总是会在“Locally signing trusted keys in keyring...”卡住，并持续近 7 分钟（注：目前已为 arCNiso 启用 rngd，在物理机中可缩短至 1 分钟），且此时若使用 `pacman -Sy <package>` 安装任意包，都会导致 `pacman-init.service` 失败，表现为使用 pacman 时会出现各种 PGP 密钥问题。添加此防呆设计之后，只有当 `pacman-init.service` 执行完毕，才允许运行 pacman。详见 [#16](https://github.com/clsty/arCNiso/issues/16)。
- 当前，arCNiso 已经不再内置 archlinuxcn 社区仓库源密钥，但此防呆设计仍保留了下来。

# 弃用 Firefox 的动态主题
- 减少卡死几率。

# squashfs 使用 zstd 压缩算法
对 squashfs 使用 zstd 而非 xz 的压缩算法参数。
- 涉及到的文件： `/etc/mkinitcpio.conf.d/archiso.conf` 和 `profiledef.sh` 。
- 以较小的尺寸增幅为代价，zstd 相较于 xz 生成镜像，无论是编译速度还是启动速度、运行速度都快很多。
- 以相应的 commit 之前（以下称为 A）与之后（以下称为 B）的两个版本的对比为例（测试环境相同，均为 VirtualBox 虚拟机，从宿主机具有的超低压 CPU 分配了两个线程，分配 3GB 内存）：
- A：采用 releng 默认的 `xz -Xbcj x86 -Xdict-size 1M` 作为 squashfs 参数。
  - 体积：1572MB
  - 秒表计时的启动测试：
    - 启动：00:00
    - GRUB 出现：00:06
    - tty 自动登录：01:12
    - 黑屏开始：01:28
    - 黑屏结束：02:00
    - Konsole 弹出，zsh 提示符可用：02:36
- B：改用 `zstd -Xcompression-level 15` 作为 squashfs 参数。
  - 体积：1753MB
  - 秒表计时的启动测试：
    - 启动：00:00
    - GRUB 出现：00:07
    - tty 自动登录：00:47
    - 黑屏开始：00:53
    - 黑屏结束：01:02
    - Konsole 弹出，zsh 提示符可用：01:15

# 弃用 xfce4 自动挂载插件
- 自动挂载不是官方 archiso 的默认行为，从而使情况出乎用户预料之外。

# xfce4
采用 xfce4 作为图形环境，而不是某个 DE/WM。
- 详见 [#23](https://github.com/clsty/arCNiso/discussions/23)。

# linux 主线内核
采用 linux 主线内核，而不是 linux-zen。
- 综合来看，使用 linux-zen 比 linux 主线内核新增的占用空间太大，比如 virtual-box-guest-utils 依赖 linux。
- 如果强行用 linux-zen 那么就要改用 virtual-box-guest-dkms-vmsvga，而这就需要 dkms 和 linux-zen-headers 了。

# `wpa_supplicant`
用 `wpa_supplicant` 而不是 `iwd` 作为 NetworkManager 后端。
- 关键原因：
  - iwd 据说不支持少数网络认证，而本镜像的特色功能之一就是提供 Firefox 浏览器以便连接到校园网等需要认证的网络。
- 详细说明：
  - 官方 archiso 自带的 wifi 联网工具是 iwd（对应的命令行交互入口是 iwctl）。
  - 本镜像采用的则是 NetworkManager，这是一套集大成的网络连接解决方案（包括有线与无线网），默认采用 `wpa_supplicant` 作为无线后端，也可使用 iwd 作为后端；但两者冲突，只能二选一。
  - `wpa_supplicant` 较老，iwd 更新一些，但是 iwd 据说存在一些 802.1X 认证的问题，见 [nixpkgs#105560](https://github.com/NixOS/nixpkgs/issues/105560)。

# 移除 vim 并将其指向 nvim（neovim）
- nvim 位于 vi 系软件中的最前沿，且已足够成熟。
- 之所以不使用 Emacs evil 替代之，是因为目前尚无法使得 emacs 具有 vim 那样的启动速度。
- 之所以也保留 Emacs，一方面是为了采用 evil-tutor-sc 这个插件提供的 Vi 系键位的学习路径，另一方面则是对 Emacs 进行一定程度上的宣传。

# sufirefoxd
- 在 xfce4 启动时，运行一个 sufirefoxd，以支持从 root 用户命令 archer 用户的 Firefox 打开网页。
  - 之所以不使用 `nohup su archer -c "firefox foo.foo" &` ，是因为实验发现这种做法有重大缺陷：
    - 这样打开的 Firefox 是不支持输入法的。
    - 若已经有同一个 profile 的 Firefox 运行，则这样做会报错“Firefox 已经运行但无响应”。
