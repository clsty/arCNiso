FROM quay.io/archlinux/archlinux:latest
LABEL maintainer="Celestial.y <clsty@celestialy.top>" \
      description="Environment for building arCNiso."
RUN function aaa { while true;do if "$@";then break;else echo "[aaa] Retrying \"$@\"";sleep 1;fi;done; } && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Server = https://mirrors.cernet.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist && \
    aaa pacman-key --init && \
    aaa pacman -Sy --noconfirm archlinux-keyring && \
    aaa pacman -Su --noconfirm && \
    aaa pacman -S --noconfirm --needed archiso git rsync pandoc base-devel fd cmake less sudo && \
    useradd -m archer && \
    echo "archer ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/archer
USER archer:archer
RUN function aaa { while true;do if "$@";then break;else echo "[aaa] Retrying \"$@\"";sleep 1;fi;done; } && \
    mkdir /home/archer/arCNiso && \
    aaa git clone --depth=1 https://aur.archlinux.org/paru-bin.git /tmp/paru-bin && \
    cd /tmp/paru-bin && \
    aaa makepkg -si --noconfirm && \
    cd /tmp && \
    rm -rf /tmp/paru-bin
WORKDIR /home/archer/arCNiso
