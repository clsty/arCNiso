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


# 维护：追踪更新
维护工作包括若干方面。
追踪更新是其中最基本的（即使不是工作量最大的），这里对其进行简要说明。

**注：本项目的维护工作目前由 clsty 执行，这里仅作为记录与参考，并不是指构建或使用本项目须参与维护。**
> 当然，假如本项目最后一次发布镜像的时间距现在超过两个月，使用者就可能有必要参考本节内容了。

## mkarchiso
- 源文件 `mkarchiso-original`（由 `/usr/bin/mkarchiso` 复制而来，Arch Linux 官方提供）有更新。
  1. 使用 PATCH.sh，将 mkarchiso 打补丁到位（若源文件的更新超过了补丁的容错范围，补丁可能会应用失败，这时需要手动操作）。
  2. 使用 DIFF.sh，根据官方 mkarchiso 与刚刚处理好的补丁版 mkarchiso 进行对比，来更新补丁。

- 想要对补丁版 mkarchiso 进行修改。
  1. 利用 DIFF.sh 判断 mkarchiso.patch 是否精确反映了差异；若否，先按源文件有更新来处理。
  2. 按需修改补丁版 mkarchiso。
  3. 使用 DIFF.sh，根据官方 mkarchiso 与刚刚修改好的补丁版 mkarchiso 进行对比，来更新补丁。

- 想要对 diff 的参数进行修改，例如 diff -u 变成 diff -U5 。
  1. 利用 DIFF.sh 判断 mkarchiso.patch 是否精确反映了差异；若否，先按源文件有更新来处理。
  2. 按需修改 DIFF.sh 中的所有 diff 命令。
  3. 删除 mkarchiso.patch，再使用 DIFF.sh 创建新补丁。

## Firefox
主要是对 Firefox 插件的更新，以及对书签作适当调整。
```bash
./homebase/preparefirefox.sh
```
按照指示操作即可。

## anotherpac
主要是将 anotherpac 所引用的几个仓库与上游进行同步：
- <https://github.com/clsty/papirus-icon-theme>
- <https://github.com/clsty/sweet-theme-backup>

## releng

### 必要性

本项目是基于 releng 的，而 releng 本身与 archiso 工具又是不断更新的。
这就会导致一个问题：如果本项目从旧 releng 拿来的基础部分不变，却与新 releng 偏离过大，则可能无法用最新的 archiso 及配套工具来成功构建本项目的 arCNiso 镜像（或者即使得到了镜像也无法正常运行）。

### 方法论

- 基本要求：避免启用会自动整理代码风格的功能（比如 Lazyvim 默认开启的某个插件），否则可能会给逐行比对（diff）带来巨大麻烦。
- 关注 GitLab 上 releng 的最新变化，如
  - <https://gitlab.archlinux.org/archlinux/archiso/-/commits/master/configs/releng?ref_type=heads>
  - <https://gitlab.archlinux.org/archlinux/releng/-/commits/master/?ref_type=HEADS>
- 使用 diff 类工具（除 diff 本身以外还有多种 TUI/GUI 前端可选）对比本项目目录与 archiso 所提供的 `/usr/share/archiso/configs/releng` 目录。


# 其他
- `./getiso`：适用于在另一台机器上构建镜像的场景。

- `./testiso`：用于利用 VirtualBox 对镜像进行测试运行。
  - 使用前可能需要手动配置 VirtualBox 虚拟机（参见[环境要求](./README.md#环境要求)），并使虚拟机名为 arCNiso。
  - 推荐设置将 `ignored/path` 设置为共享目录，自动挂载到虚拟机内，以便在宿主机与虚拟机之间传输文件（但是 symlink 类的无法直接这样传输，可以先用 tar 打包，或换用 ssh 的 scp 传文件）。

- `./publishiso` 等系列脚本：用于自动发布。
