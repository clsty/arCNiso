# 类似项目
这里收集类似于 arCNiso 的第三方 archiso 项目，以供开发者与维护者参考。

免责声明：
- 本项目不对以下任何项目作担保，也未对它们的安全与合规合法性等进行任何审查。
- 读者须自行判断并承担使用它们（包括基于它们进行开发维护）所带来的责任与风险，并严格遵守当地所有法律法规。
- 收集是手动进行的，会尽可能做到但无法保证全面性、准确性与实效性（欢迎 PR）。

**分类标准**

在下面的分类中，越靠前的优先级越高。
- 例如同时支持简体中文和 XFCE4，则放在“简体中文”下。
- 换言之，出现在“XFCE4”分类下的并不支持简体中文（但是反之，出现在“简体中文”中的未必支持 XFCE4）。

在同一分类下，停更的优先级中等，非自由开源的优先级中下，停更且非自由开源的优先级最低。
此外的顺序安排则以字母或拼音排序为主。

若有多个变种，分类时应全部纳入考量（比如一个项目有 XFCE4 和 KDE 版，可被归入“XFCE4”分类中）。

**应特别标出的属性**

- `停更于 <year>`：最后一次更新距今超过一年，或作者明确说明已停更，或者 Git 仓库变为 archived。
- `非自由开源`：非自由开源项目（许可非自由开源，或源代码不可得）。



## 分类：Arch Linux 衍生发行版
Arch Linux 的衍生发行版往往都会提供图形化的、类似于或基于 archiso 的 Live CD。

更多衍生发行版可参考 [ArchWiki](https://wiki.archlinux.org/title/Arch-based_distributions)。

### CachyOS
- 链接：
  - <https://github.com/CachyOS/CachyOS-Live-ISO>
  - <https://cachyos.org>
- 通过对 `x86-64-v3` 和 `x86-64-v4` 的支持实现了性能优化，但对 CPU 有要求。

### EndeavourOS
- 链接：
  - <https://endeavouros.com>
  - <https://github.com/endeavouros-team/EndeavourOS-ISO>
- 经典的 Arch Linux 衍生发行版。

### Parabola GNU/Linux-libre
- 链接：
  - <https://www.parabola.nu>
  - <https://git.parabola.nu/parabolaiso.git>
  - <https://wiki.parabola.nu/Hacking:isos>
- 纯粹自由开源的 Arch Linux 衍生发行版。



## 分类：简体中文
这里的简体中文支持至少包括简体中文的输入法。

### arCNiso
- 链接：
  - <https://github.com/clsty/arCNiso>
- 就是本项目（特性不再赘述）。

### ArchLive（停更于 2018）
- 链接：
  - <https://github.com/Yeyongmeng29/ArchLive>
  - <https://sourceforge.net/projects/archlive>
- KDE|XFCE4

### 更适合中国宝宝体质的Archlinux安装镜像（非自由开源）
- 链接：
  - <https://www.bilibili.com/video/BV1Qz4y1T7U2>
  - <https://www.aliyundrive.com/s/uViwdEjSAiN>
  - <https://www.bilibili.com/read/cv25993181>
- KDE Plasma
- 虽然没有给出源码，但作者在文章中给出了制作过程。



## 分类：XFCE4

### Custom Archlinux Livecd
- 链接：
  - <https://github.com/archlinux-jerry/custom-archiso>
- XFCE4；此外还有不带 GUI 的几个变种，包括 arm 支持。
- （疑似）利用 GitHub Actions 自动构建。

### `Archiso_XFCE4`（停更于 2020）
- 链接：
  - <https://github.com/Dogcatfee/Archiso_XFCE4>
- XFCE4



## 分类：GUI

### Arch Linux Calamares Installer
- 链接：
  - <https://github.com/arch-linux-calamares-installer/alci-iso>
- 简称 ALCI。
- 采用 Linux 图形化安装器 [Calamares](https://github.com/calamares/calamares)。

### Graphical Arch Repair Tool
- 链接：
  - <https://github.com/matiasvlevi/archiso-gui>
- 简称 G.A.R.T。
- i3wm

### Arch Linux Live/Rescue Image for Microsoft Surface（停更于 2021）
- 链接：
  - <https://github.com/SamLukeYes/archiso-surface>
- GNOME
- 支持触摸屏，为微软 surface 系列设备特别适配。



## 分类：安全启动

### archiso-sb-shim（停更于 2022）
- 链接：
  - <https://github.com/solsticedhiver/archiso-sb-shim>
- 此项目也是 arCNiso 所采用的安全启动方案的最初来源。



## 分类：其他

