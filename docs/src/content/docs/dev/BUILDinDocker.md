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
- 已经加入了 docker 组的普通用户。
- 已经安装 Docker。
  - 或者 podman，但以下仅以 docker 为例。
- 启用了 Docker 相关服务，比如 `systemctl enable docker --now`。
- 磁盘空间：视具体情况而定，某次实测约占用宿主机共计不到 8GiB 的空间。

# 步骤说明

克隆本仓库，为此在 bash 或 zsh 中运行：
```bash
# arCNiso 项目目录，路径可据实际情况设置
# 若于 docker 容器内构建，请确保它与之前 docker run 的 -v 参数映射到的容器目录路径一致，默认不需要改动
ARCN_DIR=$HOME/arCNiso
git clone --filter=blob:none https://github.com/clsty/arCNiso $ARCN_DIR && cd $ARCN_DIR
```
其中 `--filter=blob:none` 是为了仅下载所需的对象，而忽略多余的 blob，以便加快速度。

如果注重稳定性，建议切换到最新的 tag：
```bash
git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
```

再运行项目目录下的 `./dockerup.sh` 。它会自动完成：
- 据 `./Dockerfile` 构建名为 `clsty/arcniso` 的镜像，
  - 注：在 `Dockerfile` 中可以看到，此构建基于 Arch Linux 官方的 [archlinux/archlinux-docker](https://gitlab.archlinux.org/archlinux/archlinux-docker) 的 base 版本镜像，其提供了多个镜像地址，可根据网络情况自行修改为较快的地址。
- 运行一个名为 `arCNiso` 的容器，并将项目目录映射到容器内部的 `/home/archer/arCNiso` （这也是镜像默认的工作目录）。

:::caution[提示]
重复使用 `docker run` 可能会因容器重名而报错，此时可先将重名容器停止并删除。
参见文档末尾附录。

此外，命令 `docker images/rmi` 可以列出/删除镜像。
:::

然后，请运行 `./dockerin.sh` 来进入容器内部，余下步骤**请接着在这个容器内部**完成，参见[构建说明](/dev/build)（一直到“获取本项目”的部分都要跳过）。

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

在宿主与容器之间复制文件，其中容器路径以 `<容器名或id>:`开头（例如 `arCNiso:/home/archer/`）
```bash
docker cp <源路径> <目标路径>
```
