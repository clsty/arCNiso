# 构建说明
这里说明如何从本项目文件构建得到 arCNiso 的镜像文件。

## 环境要求
### 在 Arch Linux 系统中构建
- 一个可联网的、AMD64 架构的 Arch Linux 系统。
- 以普通用户身份登录，且具有 sudo 权限。
### 在 Docker 容器中构建
参见[构建说明（Docker 版）](./BUILDinDocker.md)。

## 分步说明

### 安装依赖（约 1 分钟，依赖网速）

```bash
sudo pacman -S --needed archiso git rsync pandoc base-devel fd asp cmake less sudo

# 安装 paru（若已添加 archlinuxcn 等第三方源，也可用 pacman 直接安装）
function aaa { while true;do if "$@";then break;else echo "!! Retrying \"$@\"";sleep 1;fi;done; }
git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin
cd /tmp/paru-bin;aaa makepkg -si --noconfirm;cd /tmp;rm -rf /tmp/paru-bin
```

### 获取本项目（约 1 分钟，依赖网速）

可以从 GitHub Releases 获取最新稳定版本的 tarball 并解压构建；

也可以直接克隆本仓库，为此在 bash 或 zsh 中运行：
```bash
# 路径可自拟
d=$HOME/arCNiso
git clone --filter=blob:none https://github.com/clsty/arCNiso $d&&cd $d
```

其中 `--filter=blob:none` 是为了仅下载所需的对象，而忽略多余的 blob，以便加快速度。


### 准备 .emacs.d（可选；约 5 分钟，依赖网速）

运行
```bash
./homebase/prepareemacs.sh
```
接下来按指示操作即可。
（可能需要重复运行几次，使得初始化全部完成，直到再次运行时 Emacs 不会弹窗报错或报警告。）

注：若你不打算在 arCNiso 中离线使用 Emacs，则这一步不是必须的。

> 本项目在 `.gitignore` 中忽略了 `.emacs.d` 中的 `eln-cache` 与 `elpa` 等目录与文件，但它们对于离线使用 Emacs 配置是必要的。
> 目的是，一方面降低文件结构的复杂度，另一方面避免大量的 elisp 代码导致本项目的主要成分被 GitHub 误判为 Emacs Lisp。


### 准备 anotherpac（约 5 分钟，依赖网速和 CPU 速度）

运行
```bash
./anotherpac/full-prepare.sh
```
接下来按指示操作即可。


### 准备 AUR 包（约 30 分钟，依赖网速和 CPU 速度）

arCNiso 使用了部分来自 AUR 的包（见 `packages.x86_64` 的开头部分），
因此需要提前构建它们。

可以利用（加 `-f` 以强制全部构建）
```bash
./aur/full-update.sh
```
自动构建这些包。
但请注意，此脚本可能仍存在一些问题，可能无法一次直接地完成所有工作，或者无法合理避免重复工作，还可能会出现构建时缺依赖报错的问题，对此只要据报错信息手动解决即可（大概需要你会一点 Bash）。
或者，清理一下 `./aur/cache` 目录，或者其下造成问题的子目录。


### 安全启动支持（可选，耗时未知）

为了支持安全启动，需要对 mkarchiso 进行修改。
而 mkarchiso 脚本来自 Arch Linux 官方，可能不断更新，从而导致旧的补丁（指 `mkarchiso.patch` ）无效，加上其他的情况变动，均可能需要手动调整修改脚本、排查并解决问题。因此，若需要安全启动支持，则视顺利程度，耗时下限低于 5 分钟，上限则无穷大。

这是一个相对复杂的可选项。若一切顺利自然是最好的，但使用者不必执著于 Secure Boot（尤其是多次失败时）。

1. 没有 Secure Boot 的系统依然可以正常使用。
2. Secure Boot 只是一个名字，它也可能实际隐含了微软对软硬件生态的战略目的（并且这可能才是主要目的）。
3. Secure Boot 只是诸多安全环节之一的诸多安全方案中的一种而已，对于达成真正的信息系统安全而言，既非充分也非必要。

**步骤：**
- 需要确保 `packages.x86_64` 含有的包名：mokutil shim-signed（来自 AUR）
- 安装依赖：
```bash
./patchedmkarchiso/deps.sh
```
- 生成密钥
```bash
./patchedmkarchiso/genkey.sh
```
- 打补丁
```bash
./patchedmkarchiso/PATCH.sh
```
  并确保按照提示将 `./patchedmkarchiso/mkarchiso` 打补丁到位。
- （可选）在确保上一步中对 `./patchedmkarchiso/mkarchiso` 文件的补丁确实已经完整地完成之后，运行
```bash
./patchedmkarchiso/DIFF.sh
```
  来更新 `mkarchiso.patch` 补丁文件。

> **附：几种情况的参考应对方法**
>
> - 源文件 `mkarchiso-original`（由 `/usr/bin/mkarchiso` 复制而来，Arch Linux 官方提供）或补丁 `mkarchiso.patch`（由本项目提供）有更新。
>   1. 使用 PATCH.sh，将 mkarchiso 打补丁到位（若源文件有更新，或者本项目提供的补丁还未同步源文件的最近更新，补丁可能会应用失败，这时需要手动操作）。
>   2. 使用 DIFF.sh，根据官方 mkarchiso 与刚刚处理好的补丁版 mkarchiso 进行对比，来更新补丁。
>
> - 想要对补丁版 mkarchiso 进行修改。
>   1. 利用 DIFF.sh 判断 mkarchiso.patch 是否精确反映了差异；若否，先按源文件有更新来处理。
>   2. 按需修改补丁版 mkarchiso。
>   3. 使用 DIFF.sh，根据官方 mkarchiso 与刚刚修改好的补丁版 mkarchiso 进行对比，来更新补丁。
>
> - 想要对 diff 的参数进行修改，例如 diff -u 变成 diff -U5 。
>   1. 利用 DIFF.sh 判断 mkarchiso.patch 是否精确反映了差异；若否，先按源文件有更新来处理。
>   2. 按需修改 DIFF.sh 中的所有 diff 命令。
>   3. 删除 mkarchiso.patch，再使用 DIFF.sh 创建新补丁。


### 正式构建（约 5 分钟，依赖网速和 CPU 速度）

运行（若 `OUT` 目录存在，则会被删除）：
```bash
./makeiso
```

输出的镜像文件位于 `./OUT` 下（为了方便使用虚拟机进行测试，每次输出时会固定更名为 `arCNiso.iso` ）。

**注：之后（除非打算更新 AUR 包）每次修改了项目文件想重新构建时，都可以直接运行 `./makeiso` 。**


# 如何定制

简单的文件修改是可以直接进行的，例如你想修改欢迎界面，可直接修改 `motd-zh_CN` ，然后用 `./makeiso` 再次构建即可。

而如果你想做一些深层次的定制，比如添加、删除一些包或 systemd 服务等，你就需要了解项目内各个文件与目录结构的作用了。

- 为此，请先知晓：本项目（除去一些其他文件以外）的主体部分正是 mkarchiso 的一个 config，原本基于官方 archiso 的 releng。
  因此，你所需要的正是 [ArchWiki 的 archiso 条目](https://wiki.archlinux.org/title/Archiso)。
- 其次，你可以看看 [feature.md](./feature.md) ，它能告诉你 arCNiso 的诸多设计细节。

**此外，你还应当了解以下信息：**

- 由于 arCNiso 不包含 releng 本体（某种意义上，arCNiso 相当于对 releng 的一个补丁），直接编辑 airootfs、efiboot、syslinux 等是无效的。正确做法是编辑 arCNiso 用以生成 airootfs 所用到的脚本及相关文件（夹）。
  - 详见 `makeiso-afs.sh`。
  - 实际上此脚本同时也用于生成 efiboot、syslinux 等；但是其实 arCNiso 采用 grub 作为 bootloader，故编辑 efiboot、syslinux 本来也是没有意义的，除非对 bootloader 也作更改。
- 你可以使用 arCNiso-expac 来查看按“实际占用空间”（包括依赖等）排序的软件包列表。
- 从 tty 可以手动启动图形环境，可运行 `arCNiso-xfce4` 。
- `/usr/local/bin` 存放了大量 arCNiso 的脚本，其中以 arcn 开头的主要面向使用者，arCNiso- 开头的主要面向开发者。
- 注意 `.gitignore` 。合理的 `.gitignore` 可以保护 Git 仓库免受临时性文件的拖累。
- `profiledef.sh` 中的 `airootfs_image_tool_options` 设定了压缩算法参数，它会影响到构建时长、镜像体积和镜像启动时长等。
  - 推荐在测试构建时使用 gzip 1 级，这样能构大大加快构建速度。
  - 构建成品时则推荐使用 zstd 18 级，在压缩率尚可的同时比 xz 具有快得多的启动速度。


# 追踪 releng

注：这一条仅作为作者的记录，只要本项目仍在维护（指最后一次发布的镜像的时间距现在两个月以内），就说明对 releng 的追踪仍在继续，读者不必担心。


## 必要性

本项目是基于 releng 的，而 releng 本身与 archiso 工具又是不断更新的。
这就会导致一个问题：如果本项目从旧 releng 拿来的基础部分不变，却与新 releng 偏离过大，则可能无法用最新的 archiso 及配套工具来成功构建本项目的 arCNiso 镜像（或者即使得到了镜像也无法正常运行）。


## 方法论

- 基本要求：避免启用会自动整理代码风格的功能（比如 Lazyvim 默认开启的某个插件），否则可能会给逐行比对（diff）带来巨大麻烦。
- 关注 GitLab 上 releng 的最新变化，如
  - <https://gitlab.archlinux.org/archlinux/archiso/-/commits/master/configs/releng?ref_type=heads>
  - <https://gitlab.archlinux.org/archlinux/releng/-/commits/master/?ref_type=HEADS>
- 使用 diff 类工具（除 diff 本身以外还有多种 TUI/GUI 前端可选）对比本项目目录与 archiso 所提供的 `/usr/share/archiso/configs/releng` 目录。


# 附：其他脚本

## 测试脚本

`./testiso` 用于利用 VirtualBox 对镜像进行测试运行。
使用前可能需要手动配置 VirtualBox 虚拟机（参见[环境要求](./README.md#环境要求)），并使虚拟机名为 arCNiso。

## 自动发布

本项目包含了 `./publishiso*` 系列脚本，它们由 clsty 开发，并用于自动发布。

如果只是为了构建此项目，你并不需要这些脚本。

如果你也想用这些脚本，来自动发布你基于本项目修改的分支、或者一个完全不同的项目，你需要自行做适当的修改调整。
