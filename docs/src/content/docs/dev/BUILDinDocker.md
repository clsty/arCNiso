---
title: 构建说明（docker 版）
layout: /src/layouts/autonum.astro
sidebar:
  label: 于 Docker 中构建
  order: 02
---

这里说明如何从一个 Arch Linux 的 Docker 容器内构建本项目文件。

# 环境要求

- 一个可联网的、AMD64 架构的操作系统。
- 可使用 root 用户或具有 sudo 权限的普通用户。
- 已经安装 Docker。
  - 或者 podman，但以下仅以 docker 为例。
- 启用了 Docker 相关服务，比如 `systemctl enable docker --now`。
- 磁盘空间：视具体情况而定，某次实测约占用宿主机共计不到 8GiB 的空间。

# 分步说明

## 准备 Docker 容器

:::note[声明]
以下操作在设计上并不特定于某发行版，但仅于 Debian Linux 宿主机上测试过，
:::

下面，我们从 Arch Linux 官方的 [archlinux/archlinux-docker](https://gitlab.archlinux.org/archlinux/archlinux-docker)（自动）拉取 Arch Linux 的 base 版本镜像，并由它创建容器。

:::caution[注意]
上述项目提供了多个镜像地址，这里以 `quay.io` 为例；**请据网络情况自行选择较快的地址。**
:::

命令如下：
```bash
# ARCN_HOST_DIR 的值可以是一个空目录或尚不存在的目录，也可以是宿主机上已有的 arCNiso 项目目录
ARCN_HOST_DIR=$HOME/arCNiso
mkdir -p $ARCN_DIR
sudo docker run \
  -v "$ARCN_DIR":/home/archer/arCNiso \
  --privileged -dt \
  --restart=unless-stopped \
  --name arch \
  quay.io/archlinux/archlinux:latest
```

:::note[参数说明]
- 名为 arch（`--name arch`），
- 允许终端登录（`-t`）并后台运行（`-d`），
- 持续运行除非手动停止（`--restart=unless-stopped`），
- 提权以允许挂载（`--privileged`），
- 加 `-p <宿主端口>:<容器端口>` 映射端口，
- 加 `-v <宿主目录路径>:<容器目录路径>` 将宿主机目录映射到容器内。
  - 若确实不需要映射目录，请删去 `-v` 这一行，但后续想再次映射目录会比较麻烦。
:::

:::caution[提示]
重复使用 `docker run` 可能会因容器重名而报错，此时须先将重名容器停止并删除。
参见文档末尾附录。

此外，命令 `docker images/rmi` 可以列出/删除镜像。
:::

## 配置基本环境

首先进入容器中的 bash：
```bash
sudo docker exec -it arch /bin/bash
```

由于没有 vi/vim/nano 等编辑器，下面直接用命令替换镜像源。

这里以教育网（CERNET）提供的联合镜像站 MirrorZ 为例；
也可以从 [Arch Linux 国内镜像源列表](https://archlinux.org/mirrorlist/?country=CN&protocol=https&ip_version=4&use_mirror_status=on)里自己找一个镜像源。
```bash
# 配置时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 为 pacman 换源
echo 'Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist

# 更新并安装必要软件
pacman-key --init
pacman -Syu --noconfirm neovim
pacman -S --noconfirm --needed archiso git rsync pandoc base-devel fd cmake less sudo

# 创建普通用户并加入 wheel 组
useradd -mG wheel archer

# 若前面映射到了容器的家目录内部，useradd 会跳过创建它的步骤，这里需要手动初始化家目录
cp /etc/skel/.bash{_logout,_profile,rc} /home/archer/
chown -R archer:archer /home/archer

# 为 wheel 组赋予 sudo 权限
#（也可手动编辑 sudoers 文件，将 `# %wheel ALL=(ALL:ALL) NOPASSWD: ALL' 去掉注释）
sed -i '/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers

# 以普通用户身份登录，并切换到家目录
su - archer 
```

# 后续
这样，docker 的基本环境就配置完毕了。

之后每次从宿主机进入此 docker 环境，可使用以下命令：
```bash
sudo docker exec -it -u archer -w /home/archer arch /bin/bash
# 或者
sudo docker exec -it -u archer -w /home/archer/arCNiso arch /bin/bash
```
余下步骤参见[构建说明](/dev/build)（直接在 docker 环境 中执行相应操作即可）。

而在得到生成的镜像文件之后，可以使用 `docker cp` 等方法将其取出容器
（如果之前 `docker run` 时配置了目录映射，也可直接利用被映射的目录）。
例如：
```bash
docker cp arch:/home/archer/arCNiso/OUT $HOME/OUT
```

# 附：一些常用的 docker 命令
获取信息
```bash
# 列出正在运行的容器
#（加 -a 列出所有容器，加 --no-trunc 关闭缩略显示）
docker ps

# 实时显示正在运行的容器的资源占用情况
docker stats

# 查看 docker 各种类型的磁盘占用
docker system df -v

# 查看容器信息
docker inspect <容器名或id>
```

管理容器
```bash
# 启动
docker container start <容器名或id>
# 重启
docker container restart <容器名或id>
# 停止
docker container stop <容器名或id>
# 移除
docker container rm <容器名或id>
```

在宿主与容器之间复制文件，其中容器路径以 `<容器名或id>:`开头（例如 `arch:/home/archer/`）
```bash
docker cp <源路径> <目标路径>
```
