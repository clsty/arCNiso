---
title: 获取与运行
layout: /src/layouts/autonum.astro
sidebar:
  label: 获取与运行
  order: 20
---
# 环境要求
- CPU：`amd64` 架构（即 `x86_64` 架构；未来可能支持其他架构）。
- 显存：最低 128 MB。
- 内存：最低 3 GiB（此时使用 Firefox 仍有崩溃风险），推荐 4 GiB 及以上。

# 如何获取镜像文件

从 [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest) 或 [Celestial.y 的存储分享](https://alist.celestialy.top/arCNiso/release)（不需要登录，但是有密码：`clsty`）下载即可。
- 国内用户与 GitHub Releases 的连接很可能不稳定，宜使用 Celestial.y 的存储分享。
- 正如通过 http 方式下载官方 archiso 镜像之后需要验证签名，（无论哪种方式）在下载完成之后，都建议手动验证版本对应的 [sha256sum](https://github.com/clsty/arCNiso/releases)。

> - 备用方法：从 [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest/download/arCNiso.latest.torrent) 下载最新的 torrent 种子文件，再使用 qbittorrent（或其他任一 BT 客户端）打开它，以下载 iso 镜像文件。
>   - 理论上来说，这也是不错的方法，但目前的做种时间较短（换句话说，时间不巧的话可能完全无法下载）。
>   - 如果你没有 BT 客户端，安装一个即可（这很简单），例如你可以从[这里](https://www.qbittorrent.org/download)下载 qbittorrent。安卓上也有 BT 客户端，例如 LibreTorrent（可从 F-Droid 下载）。
>   - 题外话，若想长期使用 BT 客户端，则更推荐 [qbittorrent 增强版](https://github.com/c0re100/qBittorrent-Enhanced-Edition)。
>   - 不需要手动验证 sha256sum（BT 客户端会自动验证）。

- Q：但是，如果我说我不想直接下载，而是从源码自己编译一份，顺便做些修改（觉得不错的话还可以给你 [PR](https://github.com/clsty/arCNiso/blob/main/docs/howtoPR.md)），阁下又将如何应对？
- A：没问题，来看[构建](https://github.com/clsty/arCNiso/blob/main/docs/BUILD.md)。


# 怎样运行（即制作启动盘）

- Q：我已经获得了 iso 镜像文件，现在我要怎么运行它呢？像官方 archiso 那样吗？
- A：是的，和官方 archiso（以及其他各种 Live 或 PE 镜像）一样。
  - 推荐使用 Ventoy，参见 [Ventoy 使用说明](https://ventoy.net/cn/doc_start.html)，其中“拷贝镜像文件”中的“ISO 文件”对应于本项目所提供的 iso 镜像文件。
  - 也可以将镜像文件通过 dd 或 Rufus 等工具写入到 U 盘中，但这远不如 Ventoy 灵活。
- Q：其实——我的电脑系统全挂掉了（或出厂不含系统），也暂时无法借用他人电脑，这样也能制作 arCNiso 启动盘吗？
- A：（ `>v>` 没想到吧.png）就算这样也还是有办法的——你可以使用安卓设备（手机、平板等）来做这件事。
  - 安装 EtchDroid USB writer，它可从[项目主页的 Releases](https://github.com/Depau/EtchDroid/releases) 或 [F-Droid](https://f-droid.org/packages/eu.depau.etchdroid) 下载（这里也提供 [Celestial.y 的存储分享](https://alist.celestialy.top/android)，密码 `clsty`；但更新未必及时）。
  - 将 U 盘插到安卓设备上，使用刚才安装的 EtchDroid 将前面获取到的 arCNiso 镜像文件写入到 U 盘中。

> 当你的电脑（通过 ventoy 或其他途径）启动本镜像之后，会自动进入启动流程。
> 
> - 首先会进入 GRUB 界面，5 秒后自动选择第一项。
> - 执行 Linux 启动阶段，并由控制台展示（左侧给出每个单项的彩色状态指示）。
> - 进入 tty 界面，展示 motd（即 Arch Linux 图标）并自动登录到 archer 帐户（其具有 sudo 权限）。
> - 图形环境（xfce4）启动，弹出欢迎界面（`/etc/motd-zh_CN`)。
