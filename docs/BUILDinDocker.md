# 构建说明（docker 版）（WIP）
这里说明如何从一个 Arch Linux 的 Docker 容器内构建本项目文件。

**此途径暂不可用（WIP），仅供参考**
## 环境要求

- 一个可联网的、AMD64 架构的操作系统。
- 可使用 Docker（或 podman）。

## 分步说明

### 准备 Docker 容器
参见 [archlinux/archlinux-docker](https://github.com/archlinux/archlinux-docker)，以 Debian Linux 作为宿主机为例，运行：
```bash
# 拉取镜像
#（docker images/rmi 可以列出/删除镜像）
sudo docker pull ghcr.io/archlinux/archlinux:latest

# 从镜像创建容器
# 名为 arch（--name arch）、允许终端登录（-t）并后台运行（-d）、持续运行（--restart=unless-stopped）、允许 mount（--privileged）
#（加 -v <宿主目录路径>:<容器目录路径> 可以映射目录）
#（加 -p <宿主端口>:<容器端口> 可以映射端口）
sudo docker run --privileged -dt --restart=unless-stopped --name arch ghcr.io/archlinux/archlinux:latest

# 列出正在运行的容器
#（加 -a 列出所有容器，加 --no-trunc 关闭缩略显示）
#（docker container (re)start/stop/rm 等可以管理容器）
#（docker cp 可用于在宿主与容器之间复制文件）
#（docker inspect 可查看容器信息）
sudo docker ps

# 进入容器
sudo docker exec -it arch /bin/bash
```
### 配置基本环境
```bash
# 由于没有 vi/vim/nano 等编辑器，这里直接更换镜像源
echo 'Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist

# 更新并安装必要软件
pacman -Syu --noconfirm neovim
pacman -S --noconfirm --needed archiso git rsync pandoc base-devel fd asp cmake less sudo

# 创建普通用户并加入 wheel 组
useradd -mG wheel archer

# 为 wheel 组赋予 sudo 权限
#（也可手动编辑 sudoers 文件，将 `# %wheel ALL=(ALL:ALL) NOPASSWD: ALL' 去掉注释）
sed -i '/^# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/s/^# //' /etc/sudoers

# 以普通用户身份登录，并切换到家目录
su - archer 
```

## 后续
这样，docker 的基本环境就配置完毕了。

之后每次从宿主机进入此 docker 环境，可使用以下命令：
```bash
sudo docker exec -it -u archer -w /home/archer arch /bin/bash
```
余下步骤参见[构建说明](./BUILD.md)。
