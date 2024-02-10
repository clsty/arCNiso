---
title: 安装途径
layout: /src/layouts/autonum.astro
---

这里收集一些 Arch Linux 的安装途径，仅供参考，而不作推荐（除了自己编写 bash 脚本与参阅 ArchWiki 的 Installation Guide 以外）。

# ArchWiki: Installation Guide
即按照 [ArchWiki 的安装指南](https://wiki.archlinux.org/title/Installation_guide)手动操作。
主要依赖 Bash。
> 注：实际上 archiso 默认的 shell 不是 bash 而是 zsh，在本文语境下可将 Bash 看成 Bash 与 Zsh 的统称。

Arch Linux 官方和很多 Arch Linux 用户（包括 clsty）在安装途径的推荐上的满足的一个共同点是，都至少推荐首次安装 Arch Linux 时应当使用这种途径一次。

这里尝试给出理由，仅供参考：
- 按照 ArchWiki 的 Installation Guide 手动操作来安装 Arch Linux，最重要的意义是初步了解 Arch Linux 的结构与原理，这是日后正确使用与维护 Arch Linux 的基础。

> 不过也应当看到，Installation Guide 作为操作实践指导而非学习教程，在了解 Arch Linux 结构原理上的作用，既非充分，甚至严格来说也非必要（因为还有其他途径）。
> - 具体地说，即使一个人学会了如何安装 Arch Linux，也未必就真的理解这些步骤的作用。比如，使用过但并不理解 mount、pacstrap、arch-chroot 的人，很可能不会在无法进入系统时使用 archiso 挂载原系统再进 chroot 修复。
> - 新手在阅读 Installation Guide 时也推荐参阅 arCNiso 所提供的 [Installation Hint](https://github.com/clsty/arCNiso/blob/main/docs/Installation_hint.md)，以加深对安装过程的理解。

# bash 脚本
## 自己编写
通过参阅 Installation Guide 来自己编写 bash 脚本来安装 Arch Linux，这在本质上和直接参阅 Installation Guide 来安装 Arch Linux 的方法是完全一致的——只存在形式上的区别，即将本来直接放在互动式 Bash 中的命令，放到了脚本里再由 Bash 执行。

当然，这对 Bash 语言的掌握有一定要求。
## 公开脚本
从零开始手写 bash 脚本虽然是不错的学习实践，在某种层面上也属于重复造轮子，因为已经有很多这样的脚本公开在互联网上了。

公开的脚本大多不具备通用性，只能作为参考；但也有一些是为通用性设计的。例如：
- <https://github.com/picodotdev/alis>

# archinstall
即在 archiso 中使用 archinstall 脚本。

> 目前 archinstall 已支持中文，但需要 CJK 字体支持，推荐在本项目（[arCNiso](https://github.com/clsty/arCNiso)）所提供的镜像中使用。

很多 Arch Linux 用户不会推荐新手使用 archinstall，这主要有两个原因：
- 尽管 archinstall 来自 Arch Linux 官方，并且 archiso 中也自带此工具，但它的语言是 Python，与官方指南使用的 Bash 可看作是不同的途径，效果也不完全一致。
- 首次安装即使用 archinstall 可能使你错失使用 ArchWiki 的 Installation Guide 的重大意义（参见本文对 Installation Guide 安装途径的描述）。

# Calamares
[Calamares](https://calamares.io) 是 Linux 图形化安装器，不局限于 Arch Linux。
提供此工具来安装 Arch Linux 的项目有很多，比如 [ALCI](https://github.com/arch-linux-calamares-installer/alci-iso)。

很多 Arch Linux 用户不会推荐新手使用 Calamares，这主要有两个原因：
- Calamares 是图形化安装器，与官方指南使用的 Bash 可看作是不同的途径，效果也不完全一致。
- 首次安装即使用 Calamares 可能使你错失使用 ArchWiki 的 Installation Guide 的重大意义（参见本文对 Installation Guide 安装途径的描述）。

# 备份恢复类
所谓安装系统，什么是安装呢？如果将“安装”定义为“使得硬盘上出现一个可用的操作系统”，那么“将备份好的副本恢复到硬盘上”也当然属于“安装系统”。

所以，一些全盘备份恢复类的工具也可用作“安装” Arch Linux 的一种途径（前提是你有一份值得信任的备份副本）。
例如 `dd`、ghost 等。
