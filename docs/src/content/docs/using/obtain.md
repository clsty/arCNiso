---
title: 如何获取镜像文件
layout: /src/layouts/autonum.astro
sidebar:
  label: 获取
  order: 10
---

# 直接下载镜像文件
目前提供两个地址，择一即可：
- [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest)
- [Celestial.y 的存储分享](https://alist.clsty.link/arCNiso/release)
  - 不需要登录，但是有密码：`clsty`

:::tip
- 国内用户与 GitHub Releases 的连接很可能不稳定，宜使用 Celestial.y 的存储分享。
- 正如通过 http 方式下载官方 archiso 镜像之后需要验证签名，（无论哪种方式）在下载完成之后，都建议手动验证版本对应的 [sha256sum](https://github.com/clsty/arCNiso/releases)。
:::

> - 备用方法：从 [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest/download/arCNiso.latest.torrent) 下载最新的 torrent 种子文件，再使用 qbittorrent（或其他任一 BT 客户端）打开它，以下载 iso 镜像文件。
>   - 理论上来说，这也是不错的方法，但目前的做种时间较短（换句话说，时间不巧的话可能完全无法下载）。
>   - 如果你没有 BT 客户端，安装一个即可（这很简单），例如你可以从[这里](https://www.qbittorrent.org/download)下载 qbittorrent。安卓上也有 BT 客户端，例如 LibreTorrent（可从 F-Droid 下载）。
>   - 题外话，若想长期使用 BT 客户端，则更推荐 [qbittorrent 增强版](https://github.com/c0re100/qBittorrent-Enhanced-Edition)。
>   - 不需要手动验证 sha256sum（BT 客户端会自动验证）。

# 通过构建得到镜像文件
参见[构建说明](/dev/build)。
