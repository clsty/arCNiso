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
sudo pacman -S --needed archiso git rsync pandoc base-devel fd cmake less sudo

# 安装 paru（若已添加 archlinuxcn 等第三方源，也可用 pacman 直接安装）
function aaa { while true;do if "$@";then break;else echo "[aaa] Retrying \"$@\"";sleep 1;fi;done; }
git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin
cd /tmp/paru-bin;aaa makepkg -si --noconfirm;cd /tmp;rm -rf /tmp/paru-bin
```

### 获取本项目（约 1 分钟，依赖网速）

克隆本仓库，为此在 bash 或 zsh 中运行：
```bash
# 路径可自拟
d=$HOME/arCNiso
git clone --filter=blob:none https://github.com/clsty/arCNiso $d&&cd $d
```
其中 `--filter=blob:none` 是为了仅下载所需的对象，而忽略多余的 blob，以便加快速度。

如果注重稳定性，建议切换到最新的 tag：
```bash
git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
```

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

> 注：本项目会持续追踪 mkarchiso 的更新，在已经追踪到最新的 mkarchiso 的前提下，`PATCH.sh` 应当能顺利执行且无须手动操作；即使追踪不够及时，patch 工具也有一定的容错性，手动操作的工作量不至于太多。
> 
> 而 `DIFF.sh` 则是用于追踪最新的 mkarchiso 并更新补丁。也就是说，`DIFF.sh` 不属于构建工具，而是维护工具，因此不在此处涉及。
>
> 当然，维护工作是构建工作得以顺利进行的前提之一，读者若有兴趣也可参阅[定制与维护](./update.md)。

### 正式构建（约 5 分钟，依赖网速和 CPU 速度）

运行（若 `OUT` 目录存在，则会被删除）：
```bash
./makeiso
```

输出的镜像文件位于 `./OUT` 下（为了方便使用虚拟机进行测试，每次输出时会固定更名为 `arCNiso.iso` ）。

## 再次构建
如果短时间内多次构建，不必重复进行正式构建之前的准备工作，可以直接运行 `./makeiso`。

但是，比如一个月之后再次构建呢？
此时对整个项目再次进行准备工作就比较有必要了——不过，当然不是完全从零开始。

以下进行分步说明，但并不是所有步骤都必要，请根据实际情况适当安排。

以下默认工作目录为 `arCNiso` 的项目文件夹。
### 更新系统
以 paru 为例：
```bash
function aaa { while true;do if "$@";then break;else echo "[aaa] Retrying \"$@\"";sleep 1;fi;done; }
aaa paru -Sy&&aaa paru -Su --noconfirm
```
注意，部分软件包在更新之后可能需要重启系统才能正常工作。
### 更新 arCNiso 项目仓库
```bash
git pull
```
### 更新 .emacs.d
```bash
./homebase/prepareemacs.sh -f
```
接下来按指示操作即可。
### 更新 anotherpac
```bash
./anotherpac/full-prepare.sh
```
### 更新 AUR 包
```bash
./aur/full-update.sh -f
```
### 更新 mkarchiso
```bash
./patchedmkarchiso/PATCH.sh
```
### 正式构建
```bash
./makeiso
```

## 延伸阅读
- [定制与维护](./update.md)
