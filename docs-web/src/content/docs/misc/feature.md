---
title: 特性列表与设计说明
layout: /src/layouts/autonum.astro
---

在特性列表中，尝试列举本镜像相对于官方 archiso 所具有的特性（细节过多，可能会有所遗漏）。

在设计说明中，给出部分设计的背景原因与考量。

# 特性列表

## 启动与内核

- 安全启动：利用 shim 添加了安全启动支持（注：这只是说，在开启安全启动时可以正常启动 arCNiso，并非是使用 arCNiso 安装的系统一定支持安全启动。当然，若要安装一份支持安全启动的 Linux，则本身支持安全启动的 Live CD 也是便利的）。
- 内核参数：添加了 `usbcore.autosuspend=-1 btusb.enable_autosuspend=N bluetooth.disable_ertm=Y` 作为内核参数，以提升部份外设连接的稳定性。


## 图形环境

以 xfce4 为核心，进行了多方面的配置。

- 主题：主要主题为 sweet，图标主题为 papirus，以 kvantum 作为引擎。
- 壁纸：采用 [high-rise buildings during nighttime](https://unsplash.com/photos/lmvGn9rTGvY)，据称于 2018.1.15 的冬夜摄于北京中信大厦（中国尊）98 层。
  - 没有版权问题，而且是张不错的城市夜景图（仅主观评价）。
- 字体：配置 fontconfig。
- 终端：采用 Tilix。
- 命令行：采用 oh-my-zsh 以及 powerlevel10k。
- 用户：设置了 archer 作为具有 sudo 权限且自动登录的用户。


## 硬件与外设

- 全局键位：在 tty 与图形界面中，均交换了左 `Ctrl` 与大写锁定键，并提供了 `resetkeymap` 命令供复原。
- 蓝牙：配置了蓝牙所需的软件包、内核模块与服务。
- 屏幕键盘：安装了 onboard，并将其启动器放在 xfce 的右下角。
- 亮度：提供了 brightnessctl 和 ddcutil。
- 音频：安装了 pipewire 相关的软件包。
- 显卡驱动：为多种显卡及虚拟机环境添加了显卡驱动。
- 网络：
  - 添加了 NetworkManager 相关软件并启用相关服务（以 `wpa_supplicant` 作为无线后端）。
  - 将 xfce4 的 wavelan 插件的默认网卡从 lo 改为 wlp1s0。
  - 禁用 systemd-networkd 并移除了 iwd、dhcpcd、dhclient 以防冲突。
  - 提供命令行工具 git、curl。


## 网络应用

- Firefox 浏览器：
  - 进行了部分美化、实用化的配置。
    - 安装了 Vimium C 从而支持 vim 键位。
    - 安装配置了 Dark Reader 插件，从而支持通用的暗黑主题；并且为 Firefox 的一些官方域名解除限制，使得在这里 Dark Reader 也适用。
    - 禁用了 DRM 提示。
    - 禁用了下载最后的安全检查，以去掉进度满之后到下载完成之前的若干秒延迟。
    - 添加了一些能直接在地址栏调用的搜索引擎（如 Arch Wiki）及关键词。
  - 移除了 lynx；若运行 lynx，则在找不到 lynx 时询问是否要立即安装或使用 Firefox 替代。
- 通讯软件：
  - 由于这些软件在离线时无法使用，本项目不打算将它们内置，需要时可以手动安装：
  - nheko：（开源开放的）Matrix 通讯架构的客户端，需要配合 keepassXC 使用。
    - 安装命令： `sudo pacman -S nheko`
  - Gajim：支持 Jabber/XMPP 协议（一种开源开放的即时通讯协议）。
    - 安装命令： `sudo pacman -S gajim`
  - Quassel IRC：支持 IRC 协议（一种开源开放的即时通讯协议）。
    - 安装命令： `sudo pacman -S quassel-monolithic-qt`
  - QQ：本项目建立了 `~/.config/QQ/crash_files` 以防止 QQ 闪退。
    - 安装命令： `paru linux-qq`
  - 邮箱：为节省空间，未预装邮件客户端。建议通过 Firefox 在线访问邮箱的网页端。


## 命令行与自动化

- 为 zsh 安装了 oh-my-zsh 配置框架及 p10k 主题。
- AUR 构建：本项目在构建来自 AUR 的包时，使用脚本尽可能做到自动化。
- alias：内置的 zsh 被配置使用了一些 alias，详见其 zshrc。
- 内置脚本：在 `/usr/local/bin/` 内置了一些脚本，以供快速执行一些任务。


## 本地化

- 区域：配置了时区等。
- 语言：配置了中文。
- 输入法：配置了 fcitx5-rime。


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


## 分区与系统引导

- 提供 PartitionManager 作为 GUI 磁盘管理器。
- 提供 TestDisk 作为 TUI 的分区表恢复及引导修复软件。
- 提供 Timeshift 、btrfs-assistant 及 Snapper 作为快照的备份恢复软件。
- 提供 EFIBootEditor 作为 efibootmgr 的 GUI 前端。
- 提供 grub-customizer 作为（功能有限的）GRUB 自定义配置工具。
- 提供 Ventoy（同时具有 GUI 与 CLI）以进行一些特殊操作。


## 录制截取

- Xfce4-screenshooter：用于截图。


## 其它

- keepassXC：密码管理器，并为 nheko 提供安全服务。同时安装了对应的 Firefox 插件。
- vlc：音视频播放器。
- zathura：文档阅读器，支持 PDF、EPUB、XPS 等格式。
- gimagereader：基于 tesseract 的 OCR。
  - 若需要识别中文，应手动安装 `tesseract-data-chi_sim`。
- Ristretto：图像查看器。
- neofetch：展示系统信息。


## 用户引导

- motd：添加了中文版本的 motd，并在 arCNiso 启动时自动展示。
- 安装指南：提供 `Installation_guide` 命令的一个等价入口 `arcnguide` ，并改为用 Firefox 打开中文版的 Wiki 页面及本镜像提供的 hint。
- 根分区大小：通过内核参数 `cow_spacesize=1G` 配置为 1 GiB（而不是原版 archiso 的 256 MiB），并提供 `modifyrootspace` 供实时修改。


## 软件包与源

- 配置了国内的镜像源。
- 提供命令 `arcnadd-cn` 来快速启用 archlinuxcn 社区仓库源，并启用 rngd 来加速密钥环的添加。
  - 注：本项目与 archlinuxcn 社区无关。
- 在使用 AUR 助手 paru 时半自动安装 paru 和 base-devel。
- 禁用了 choose-mirror 与 reflector 服务（但仍可手动运行）。
- 为 pacman 添加防呆设计。


# 设计说明

以下说明部分设计背后的考虑与背景。

- 为 `pacman` 添加防呆设计，以检查 `pacman-init.service` 的执行情况。
  - 原因：已发现在添加 archlinuxcn 社区仓库源密钥时，pacman-init.service 中的 `Exec=pacman-key --populate` 总是会在“Locally signing trusted keys in keyring...”卡住，并持续近 7 分钟（注：目前已为 arCNiso 启用 rngd，在物理机中可缩短至 1 分钟），且此时若使用 `pacman -Sy <package>` 安装任意包，都会导致 `pacman-init.service` 失败，表现为使用 pacman 时会出现各种 PGP 密钥问题。添加此防呆设计之后，只有当 `pacman-init.service` 执行完毕，才允许运行 pacman。详见 <https://github.com/clsty/arCNiso/issues/16> 。
  - 当前，arCNiso 已经不再内置 archlinuxcn 社区仓库源密钥，但此防呆设计仍保留了下来。

- 弃用 Firfox 的动态主题。
  - 减少卡死几率。

- 对 squashfs 使用 zstd 而非 xz 的压缩算法参数。
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

- 弃用 xfce4 用于自动挂载的插件。
  - 自动挂载不是官方 archiso 的默认行为，从而使情况出乎用户预料之外。

- 采用 xfce4 作为图形环境，而不是某个 DE/WM。
  - 详见 <https://github.com/clsty/arCNiso/discussions/23>

- 采用 linux 主线内核，而不是 linux-zen。
  - 综合来看，使用 linux-zen 比 linux 主线内核新增的占用空间太大，比如 virtual-box-guest-utils 依赖 linux。
    如果强行用 linux-zen 那么就要改用 virtual-box-guest-dkms-vmsvga，而这就需要 dkms 和 linux-zen-headers 了。

- 用 `wpa_supplicant` 而不是 `iwd` 作为 NetworkManager 后端。
  - 关键原因：
    - iwd 据说不支持少数网络认证，而本镜像的特色功能之一就是提供 Firefox 浏览器以便连接到校园网等需要认证的网络。
  - 详细说明：
    - 官方 archiso 自带的 wifi 联网工具是 iwd（对应的命令行交互入口是 iwctl）。
    - 本镜像采用的则是 NetworkManager，这是一套集大成的网络连接解决方案（包括有线与无线网），默认采用 `wpa_supplicant` 作为无线后端，也可使用 iwd 作为后端；但两者冲突，只能二选一。
    - `wpa_supplicant` 较老，iwd 更新一些，但是 iwd 据说存在一些 802.1X 认证的问题，见 <https://github.com/NixOS/nixpkgs/issues/105560> 。

- 移除 vim 并将其指向 nvim（neovim）。
  - nvim 位于 vi 系软件中的最前沿，且已足够成熟。
  - 之所以不使用 Emacs evil 替代之，是因为目前尚无法使得 emacs 具有 vim 那样的启动速度。
  - 之所以也保留 Emacs，一方面是为了采用 evil-tutor-sc 这个插件提供的 Vi 系键位的学习路径，另一方面则是对 Emacs 进行一定程度上的宣传。

- 在 xfce4 启动时，运行一个 sufirefoxd，以支持从 root 帐户命令 archer 帐户的 Firefox 打开网页。
  - 之所以不使用 `nohup su archer -c "firefox foo.foo" &` ，是因为实验发现这种做法有重大缺陷：
    - 这样打开的 Firefox 是不支持输入法的。
    - 若已经有同一个 profile 的 Firefox 运行，则这样做会报错“Firefox 已经运行但无响应”。
