要说明为什么有 arCNiso，就要从官方 archiso 说起。


# 猫猫、李华与官方 archiso

（以下纯属虚构）

那是一个月黑风高的夜晚……

李华在折腾 kde 的时候，顺便尝试了朋友分享的一个猫猫的 sddm 主题。
耐何水平不足，配置时一个用力过猛，竟把系统玩坏掉了。

望着再起不能的 Arch Linux，她只好从急救药箱里翻出 U 盘，

“archiso，启动！”

黑漆漆的屏幕上滚满着阴白的字符，心生一丝恐惧的李华仍然只能硬着头皮，在网上搜索着命令，一个个地敲下去。
一步，再一步，setfont，lsblk，mount，arch-chroot，dmesg，journalctl……

在眼睛被点阵字体折磨得通红、盈满泪花时，她终于把问题定位到了那个主题文件夹，
里面赫然躺着一个文件：README.md。
激动万分的李华当即用 nano 打开看看——屏幕上却出现了一堆白方块。
这，分明是官方 archiso 的 tty 所不能显示的中文！李华脑海中浮现出朋友嘲讽的脸：“谁让你不先看说明来着喵～”

“呜呜呜，大坏蛋！就知道欺负人家……”李华终于忍受不了这一切，她大哭起来，绝望地敲下 `rm -rf . /*` ，
“删了你这破猫猫主题！老娘再也不用官方 archiso 了！”

啪一声回车，电光石火之间，李华忽然意识到了好像有什么不对。

    /bin/ls: no such file or directory

……

“昨天回去试了我做的主题了喵～？感觉怎么样喵喵～？”

“别提了，花了几个小时在 archiso 里用 lynx 查资料，最后手抖了一下，又重装了一次 Arch。”

“谁让你不先看——诶诶有话好好说别打人喵——”
……

李华的朋友是喵星人，它的星际翻译器被李华打坏了，在维修之前暂时只能理解英文。

请用英语代李华向朋友写一封道歉信，不少于 300 词。（25 分）

（完）


# 官方 archiso

archiso 是 Arch Linux 提供的 Live CD。

> 大部分的 Linux 发行版都会提供一个或若干个 Live CD。
> 其中包含的 Live 环境，是一个临时性的系统，具有一些特殊的重要作用，但一般不适合作为日常系统来使用。
> 
> 一般地，Live CD 的主要功能有
> 
> -   安装对应的发行版（此处即 Arch Linux）。
> -   维护系统（对象可以是别的发行版，甚至是别的系统；但最好是对应的发行版）。
> -   临时性地使用，例如应急使用等。

作为 Live CD，archiso 是比较精巧的，这符合 Arch 的哲学，并且也提供了安装与维护系统的基本功能。

但是，它在某些方面，并不是很方便使用。包括但不限于：

-   仅提供 tty 界面，色彩简陋。
-   不方便复制粘贴。
-   不支持中文显示。
-   不支持安全启动。
-   不支持中文输入法。
-   仅能使用简陋的终端字体（默认字体还超小）。
-   在联网时，由于不具备图形界面，它很可能无法完成网页认证。
-   它默认配置的 reflector 经常会把对中国用户网络不友好的镜像源放在前面。
-   它不含 btrfs-assistant、timeshift、ventoy 等工具，不方便维护系统。
-   ……

> 以上这些问题的一部分，是存在解决或变通方法的。
> 
> 例如，觉得 tty 界面不够美观的，可以在别的设备上用 SSH 远程连接进行操作；
> 可以直接关掉 reflector 并自己手动换源；
> 联网可以用手机 USB 共享网络的方法进行，等等。
> 
> 但多出这么亿些步骤，确实不够方便，在紧急情况下也很让人烦躁。

于是，不仅很多新手觉得 archiso 难用从而被劝退（还因此留下了“Arch Linux 难安装”的江湖传说）；
就连一些熟手，在需要 archiso 的时候，也同样觉得不好用，只是用到的频率又少，就懒得自己定制一个了。


# arCNiso

以上，就是 arCNiso 出现的原因了。

它所具有的特性，已经在 [README](https://github.com/clsty/arCNiso)、[有多难](https://github.com/clsty/arCNiso/blob/main/docs/howhard.org)、[功能与设计](https://github.com/clsty/arCNiso/blob/main/docs/feature.org)等处说明，这里不再重复。

总之，相比 archiso，用 arCNiso 来安装、维护或临时使用 Arch Linux 时，
你的心情能够更加愉悦、效率能够超级加倍，也使得你在把 Arch Linux 安利出去时能够更有底气。


# 更名历史

此项目原名为 archisoCN，但是注意到 [ALG 的前车之鉴](https://distrowiki.miraheze.org/wiki/Arch_Linux_GUI)，以及 [Arch Linux 那模棱两可的 policy](https://wiki.archlinux.org/title/DeveloperWiki:TrademarkPolicy)，还是改名了，并加上 README 里面的那么一大堆声明——明明只是自由开源项目，商标法真是有够烦人的～

