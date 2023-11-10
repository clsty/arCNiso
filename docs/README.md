![某个版本 arCNiso 的截图](https://github.com/clsty/arCNiso/raw/main/screenshot.png)

**To non-Chinese users**

This is an **unofficial** project which builds customised archiso with GUI(xfce4) for Arch Linux users in China. 

**Currently the project has no plan for other regions**. 
However, **feel free to fork** this project and modify to make your own (of course, under GNU GPL 3.0 License).

**目录**
- [简介](#简介)
- [获取与运行](#获取与运行)
- [使用指南](#使用指南)
- [其他](#其他)

# 简介

[arCNiso™](https://github.com/clsty/arCNiso)（简称 arCN™）是一个自由开源的 archiso 镜像。

其保留了官方原版 archiso 镜像的所有功能，并面向<b>简体中文的中国用户</b>，就<b>安装系统、维护系统与临时使用</b>这三种用途进行了加强定制。

- arCNiso 不仅面向新手，也面向熟手，比如：
  - oh-my-zsh 与 p10k 总比裸 grml-zsh 好用；
  - 需要 timeshift 等常用工具时，自带总比从 AUR 安装更省事；
  - 需要 Secure Boot 支持时（官方 archiso 不支持 Secure Boot）；
  - 使用平板电脑时，若没有 USB 无线或有线键盘，可用蓝牙管理器连接蓝牙键盘，或使用屏幕键盘，而不是束手无策；
  - ……

> arCNiso 不是什么：
> 
> - 它 **不是** Arch Linux 的图形化安装器，如含有 Calamares 的 [alci-iso](https://github.com/arch-linux-calamares-installer/alci-iso)。
>   - 因为它 **并不** 额外提供任何形如“黑箱”（指将正常的安装流程包装隐藏起来）的系统安装途径（官方 archiso 所提供的 archinstall 除外）。
> - 它也 **不是** Arch Linux 的衍生发行版，如 EndeavourOS、CachyOS 等。
>   - 因为它 **并不** 提供这类发行版所独有的软件仓库。
> - 同原版 archiso 一样，它也 **不** 支持离线安装 Arch Linux。
> 
> 总之，arCNiso 本质上仍是 archiso，只是体积更大（例如 v1.2.1 的镜像文件大小为 1.56 GB，差不多比同时期的官方 archiso 的 0.81 GB 大一倍不到）且更好用。

arCNiso 历经较为充分的打磨，可放心使用，真心希望你能喜欢。

- 欢迎给[本项目](https://github.com/clsty/arCNiso)点 star 来表达你的支持或认可 `>v0` 。
- 有任何看法或建议，欢迎在 [issue](https://github.com/clsty/arCNiso/issues) 中反馈或吐槽，或直接提交 PR（为避免浪费你的时间，请先看 [PR 相关](https://github.com/clsty/arCNiso/blob/main/docs/howtoPR.md)）。

> - **作为新手怕难度太高不会用** 或 **作为熟手担心难度太低把新手惯成白痴** ？来看[有多难](https://github.com/clsty/arCNiso/blob/main/docs/howhard.md)。
> - 为什么会有这个项目？请看[关于](https://github.com/clsty/arCNiso/blob/main/docs/about.md)。
> - 更多特性与细节，以及某些设计的背景与考量，详见[功能与设计](https://github.com/clsty/arCNiso/blob/main/docs/feature.md)。

祝你使用愉快！


# 获取与运行

注：要运行此镜像的机器，最低内存 3GiB（此时使用 Firefox 仍有崩溃风险），推荐内存 4GiB 及以上。


## 如何获取镜像文件

- 从 [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest) 或 [Celestial.y 的存储分享（不需要登录，但是有密码：clsty）](https://alist.celestialy.top/arCNiso/release) 下载即可。
  - 国内用户与 GitHub Releases 的连接很可能不稳定，宜使用 Celestial.y 的存储分享。
  - 正如通过 http 方式下载官方 archiso 镜像之后需要验证签名，（无论哪种方式）在下载完成之后，都建议手动验证版本对应的 [sha256sum](https://github.com/clsty/arCNiso/releases)。

> - 备用方法：从 [GitHub Releases](https://github.com/clsty/arCNiso/releases/latest/download/arCNiso.latest.torrent) 下载最新的 torrent 种子文件，再使用 qbittorrent（或其他任一 BT 客户端）打开它，以下载 iso 镜像文件。
>   - 理论上来说，这也是不错的方法，但目前的做种时间较短（换句话说，时间不巧的话可能完全无法下载）。
>   - 如果你没有 BT 客户端，安装一个即可（这很简单），例如你可以从[这里](https://www.qbittorrent.org/download)下载 qbittorrent。安卓上也有 BT 客户端，例如 LibreTorrent（可从 F-Droid 下载）。
>   - 题外话，若想长期使用 BT 客户端，则更推荐 [qbittorrent 增强版](https://github.com/c0re100/qBittorrent-Enhanced-Edition)。
>   - 不需要手动验证 sha256sum（BT 客户端会自动验证）。
> - 过时的备用方法：从 [123pan](https://www.123pan.com/s/fU5iVv-tYaZ3.html) 下载。
>   - 在过去，由于 123pan 相对来说比较良心，免登录、无广告且不需要客户端也不限速，这曾是主要方法；但不久之后 123pan 进行了一系列操作，比如限制 AList 挂载（这导致自动发布不再可行）、增加广告量、加大免登录下载的限制等等，于是此法逐渐弃用。

- Q：但是，如果我说我不想直接下载，而是从源码自己编译一份，顺便做些修改（觉得不错的话还可以给你 [PR](https://github.com/clsty/arCNiso/blob/main/docs/howtoPR.md)），阁下又将如何应对？
- A：没问题，来看[构建](https://github.com/clsty/arCNiso/blob/main/docs/BUILD.md)。


## 怎样运行（即制作启动盘）

- Q：我已经获得了 iso 镜像文件，现在我要怎么运行它呢？像官方 archiso 那样吗？
- A：是的，和官方 archiso（以及其他各种 Live 或 PE 镜像）一样。
  - 推荐使用 Ventoy，参见 [Ventoy 使用说明](https://ventoy.net/cn/doc_start.html)，其中“拷贝镜像文件”中的“ISO 文件”对应于本项目所提供的 iso 镜像文件。
  - 也可以将镜像文件通过 dd 或 Rufus 等工具写入到 U 盘中，但这远不如 Ventoy 灵活。
- Q：其实——我的电脑系统全挂掉了（或出厂不含系统），也暂时无法借用他人电脑，这样也能制作 arCNiso 启动盘吗？
- A：（ `>v>` 没想到吧.png）就算这样也还是有办法的——你可以使用安卓设备（手机、平板等）来做这件事。
  - 安装 EtchDroid USB writer，它可从[项目主页的 Releases](https://github.com/Depau/EtchDroid/releases) 或 [F-Droid](https://f-droid.org/packages/eu.depau.etchdroid) 下载（这里也提供 [Celestial.y 的存储分享](https://alist.celestialy.top/android)，密码 clsty；但更新未必及时）。
  - 将 U 盘插到安卓设备上，使用刚才安装的 EtchDroid 将前面获取到的 arCNiso 镜像文件写入到 U 盘中。

> 当你的电脑（通过 ventoy 或其他途径）启动本镜像之后，会自动进入启动流程。
> 
> - 首先会进入 GRUB 界面，5 秒后自动选择第一项。
> - 执行 Linux 启动阶段，并由控制台展示（左侧给出每个单项的彩色状态指示）。
> - 进入 tty 界面，展示 motd（即 Arch Linux 图标）并自动登录到 archer 帐户（其具有 sudo 权限）。
> - 图形环境（xfce4）启动，弹出[欢迎界面](https://github.com/clsty/arCNiso/blob/main/airootfs/etc/motd-zh_CN)。


# 使用指南

开机弹出的欢迎界面中已经给出了最关键的“注意事项”，**读完这个就可以直接开始使用了。**

以下则是（没那么重要的）“技巧提示”及“问题与应对”。


## 技巧提示（知道了会更好）


### 推荐

先学会 vim 式编辑器的基本使用方法（为此可运行 eviltutor），以便获得本镜像中 vifm/ranger/emacs/firefox 等软件所带来的效率提升。

> vim 本身是高效的、人体工学友好的编辑器，而它的键位设计在很多别的程序中也会以默认方案或可选插件等形式出现。


### 命令行 shell

> 简称 shell，也就是终端模拟器（tilix）里面的（或者说“连接着的”“承载着的”）那个存在。

**常识：** `Ctrl+C` 终止（卡住的时候请试试这个）。

**输入：** `Ctrl+U` 删至行首、 `Ctrl+W` 删除一个单词、。

**补全：** 在命令没打完的时候，试试按 `Tab` 键或上下方向键。


### 终端（tilix）

**缩放字体大小：** `Ctrl+=` 与 `Ctrl+-` 。

**翻页：** `Shift+PageUp` 向上翻页、 `Shift+PageDown` 向下翻页。

**复制粘贴：** 先用鼠标选中，再 `Ctrl+Shift+C` 复制；用 `Ctrl+Shift+V` 粘贴（仅终端；一般的复制粘贴仍然是 `Ctrl+C` 及 `Ctrl+V` ）。

**会话（即标签页）与终端（实际上是指分割视图的小终端窗格）：** `Ctrl+Shift+T` 新建会话、 `Ctrl+Alt+1` `Ctrl+Alt+2` 切换会话、 `Ctrl+Alt+A` 自动新建终端、 `Alt+1` `Alt+2` 切换终端、 `Ctrl+Shift+W` 关闭当前会话或终端。


### 一些终端程序

**安装软件：** 使用 paru 可以从 AUR 安装软件。在 arCNiso 中使用 paru 的一种方法是，输入 `parui` 进入搜索界面。

**alias：** 请使用 `less ~/.zshrc` 查看其末尾处的 alias（按 q 退出），这有助于你提高输入命令的效率。

**vifm：** 在 arCNiso 中使用 vifm 时，可以按 ZZ 退出并切换工作目录。


### 输入法

按左 `Ctrl` 加空格键以切换输入法，按 `Ctrl` 加分号打开剪贴板管理器（按 ESC 退出）。


### 更多

- 有关 Arch Linux、Linux 等方面，**推荐新手阅读**[入门与进阶帮助](https://github.com/clsty/arCNiso/blob/main/docs/learn.md)。
- arCNiso 的更多功能，详见[特性列表](https://github.com/clsty/arCNiso/blob/main/docs/feature.md)。


## 问题与应对（一般用不到）

- 不小心进入了 tty
  - 启动时，会自动登录 tty1 并启动 xfce4。若不小心切到了别的 tty，可以用 `Ctrl+Alt+F1` 再切回来。
- 若 CPU 性能弱，则启动速度较慢。
  - 从 GRUB 到 tty 界面要很长一段时间，从 tty 界面到 xfce4 出现又有很长一段黑屏。在某低配电脑上总计时间甚至可达两分钟。原因初步推测为，镜像为了节省空间，经由 squashfs 高度压缩，解压时对 CPU 多核性能要求较高。
  - 建议耐心等待。
- 在 VirtualBox 虚拟机中使用本镜像时，不够稳定，尤其是 Firefox。
  - 建议使用 VMSVGA 作为显卡控制器、启用 3D 加速并给足显存（128 MB）。
  - 在 Linux 下建议改用 QEMU/KVM 虚拟机。
- 桌面上的面板（任务栏）未加载出来。
  - 在 VirtualBox 虚拟机下，偶尔会遇到这种情况。此时可用 `arcnlogout` 退出（并自动重启）桌面环境。


# 其他


## 商标声明

- arCNiso™ 与 arCN™ 是本项目的未注册商标，本项目对此保留所有权利。
- Arch Linux™ 是 [Arch Linux](https://archlinux.org) 的未注册商标。
  - 本项目 **不是** Arch Linux™ 官方发布的，与 Arch Linux™ 官方亦 **无** 任何关联。
- Linux® 是 [Linux Foundation](https://www.linuxfoundation.org) 的注册商标。

> 部分读者可能会觉得此处小题大做（“有必要做这样一份声明吗”），
> 为此请阅读[关于](https://github.com/clsty/arCNiso/blob/main/docs/about.md)。


## 许可

- 本项目以 GNU GPL 3.0 License 发布。
- 项目文件中所包含的其他软件项目的部分，均维持其原有 License。


## 致谢

在此感谢本项目所用到或参考到的各项目的作者、开发者与维护者。
以下列举部分项目：

- [archiso](https://github.com/archlinux/archiso)：本项目的直接基础，来自 Arch Linux 官方。
- [Sweet Themes](https://github.com/EliverLara/Sweet)：本项目图形环境中 xfce4 等的主题。
- [Papirus icon](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme)：本项目所使用的图标主题。
- [Tilix](https://github.com/gnunn1/tilix)：本项目所使用的终端模拟器。
- [Ventoy](https://www.ventoy.net)：本项目所含工具，以及推荐使用的运行方案。
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)：本项目采用的 zsh 配置框架。
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)：本项目采用的 zsh 主题。
- [霞鹜文楷](https://github.com/lxgw/WenKai)：本项目所采用的字体。
- [GNU Emacs](https://www.gnu.org/software/emacs)：本项目所采用的编辑器。
- [Emacs Evil](https://github.com/emacs-evil)：本项目所使用的 Emacs 插件。
- [evil-tutor-sc](https://github.com/clsty/evil-tutor-sc)：本项目所使用的 Emacs 插件（作者也是 clsty `>v0` ）。
- [otsaloma's markdown-css](https://github.com/otsaloma/markdown-css)：本项目的部分文档转为 html 所采用的 pandoc css 文件 `github.css` 。
- [high-rise buildings during nighttime](https://unsplash.com/photos/lmvGn9rTGvY)：本项目所使用的壁纸。
- [archiso-sb-shim](https://github.com/solsticedhiver/archiso-sb-shim)：本项目实现安全启动所采用的方案来源。

