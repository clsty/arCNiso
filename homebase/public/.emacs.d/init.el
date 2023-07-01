;; -*- lexical-binding: t; -*-
;; vim:fileencoding=utf-8:ft=config:fdm=marker foldlevel=0
;; Local Variables:
;; eval: (folding-mode)
;; End:

;;{{{ 把 emacs 的 custom 放到 custom.el 中

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;}}}

;;{{{ 插件仓库

(require 'package) ; 加载 package.el
(setq package-check-signature nil) ; 是否检查签名
;; 添加仓库位置
;; 注：由于emacs的bug，url末尾必须为 `/'。
;; gnu 一般是必备的，其它的 elpa 中的包会依赖 gnu 中的包
;; nongnu 建议启用，类似于 melpa 但是 Emacs 官方维护的
;; melpa 滚动升级，收录了的包的数量最大
;; stable-melpa 依据源码的 Tag （Git）升级，数量比 melpa 少，因为很多包作者根本不打 Tag
;; org 仅仅为了 org-plus-contrib 这一个包，org 重度用户使用
;; gnu-devel 收录 gnu 中的包的开发中版本，一般不必启用（与 gnu 的关系类似于 melpa 与 stable-melpa 的关系）
;; nongnu-devel 收录 nongnu 中的包的开发中版本，一般不必启用
(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("nongnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa-stable" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/stable-melpa/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ;("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))
;; 刷新插件列表
;(unless package-archive-contents (package-refresh-contents))
;; 自动安装 use-package. 在Emacs 29中已内置故可省略
(unless (package-installed-p 'use-package) (package-install 'use-package))
;; 自动安装所有使用 use-package 声明的插件
(require 'use-package-ensure)
(setq use-package-always-ensure t)
;; QUELPA
;(use-package quelpa
;  :ensure t
;  :commands quelpa
;  :custom
;  (quelpa-git-clone-depth 1)
;  (quelpa-self-upgrade-p nil)
;  (quelpa-update-melpa-p nil)
;  (quelpa-checkout-melpa-p nil))
;
;;;}}}

;;;{{{ 性能优化
;; 在配置文件开头，提升gc(garbage collection)域值（默认是 800 kB），以降低gc频率来提升启动速度（在配置末尾再降回来）
(setq gc-cons-threshold (* 50 1000 1000))
;;}}}

;;{{{ 编码

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;}}}

;;{{{ Evil

(setq evil-undo-system 'undo-redo) ;须先设置，再加载evil
(setq evil-search-module 'evil-search)
(setq evil-want-keybinding nil)
(setq evil-want-keybindings nil)
(use-package evil)
(use-package evil-collection)
; 不加require会报warning，要求先设置evil-want-keybinding为nil，即使已经这么设了
(require 'evil)
(require 'evil-collection)
(evil-mode 1)
(evil-collection-init)
;(define-key evil-insert-state-map (kbd "C-n") nil)
;(define-key evil-insert-state-map (kbd "C-p") nil)
(use-package evil-tutor)
(use-package evil-tutor-sc)
;;}}}

;;{{{ 外观 
(use-package nord-theme)
(load-theme 'nord t)
;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'menu nil
                    :inverse-video nil
                    :background "black"
                    :foreground "white"
                    :bold t)
(setq-default truncate-lines nil)
(add-hook 'org-mode-hook
	  (lambda()
	    (setq truncate-lines nil)))
;(add-to-list 'default-frame-alist '(font . "LXGW WenKai Mono-20"))
(set-face-attribute 'default t :font "LXGW WenKai Mono-20")
(define-key evil-normal-state-map (kbd "C-=") #'text-scale-adjust)
(define-key evil-normal-state-map (kbd "C--") #'text-scale-adjust)

;;}}}

;;{{{ 复制粘贴、鼠标、菜单

(context-menu-mode 1)
(use-package xclip)
(xclip-mode 1)
(setq x-select-enable-clipboard t)
(use-package evil-terminal-cursor-changer)
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  (xterm-mouse-mode 1)
  )

;;}}}

;;{{{ 操作行为

(setq-default tab-width 2) ;; 一个 tab 的字符宽
(setq-default indent-tabs-mode nil) ;; 是否使用真实的 tab（否则替换成空格）

;;}}}

;;{{{ 折叠

(use-package folding)

(if (require 'folding nil 'noerror)
        (folding-mode-add-find-file-hook)
      (message "Library `folding' not found"))
(folding-add-to-marks-list 'emacs-lisp-mode   ";;{{{" ";;}}}") (add-hook 'emacs-lisp-mode-hook #'folding-mode)
(folding-add-to-marks-list 'shell-script-mode "# {{{" "# }}}") (add-hook 'shell-script-mode-hook #'folding-mode)

(define-key evil-normal-state-map "za" #'folding-toggle-show-hide)

;;}}}

;;{{{ 辅助信息

(use-package which-key
  :custom (which-key-idle-delay 0.5) ; 延迟时间, 以秒为单位
  :config (which-key-mode)) ; 启用 which-key 模式

(use-package keycast
  :config (keycast-header-line-mode 1)) ; 在标题显示

(use-package helpful
  :bind
  ;; 将原本帮助系统的键位分配给 helpful
  (([remap describe-function] . #'helpful-callable)
   ([remap describe-variable] . #'helpful-variable)
   ([remap describe-key] . #'helpful-key)
   ([remap describe-command] . #'helpful-command)
   ([remap describe-symbol] . #'helpful-symbol)
   ; 新增两种帮助
   ("C-h C-d" . #'helpful-at-point)
   ("C-h F" . #'helpful-function)))

(use-package marginalia ; 更多信息
  :config (marginalia-mode))

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :hook (after-init . ivy-mode))
;;}}}

;;{{{ 自动备份
(setq backup-by-copying t ; 自动备份
      backup-directory-alist '(("." . "~/.saves")) ; 自动备份在目录"~/.saves"下
      delete-old-versions t ; 自动删除旧的备份文件
      kept-new-versions 6 ; 保留最近的6个备份文件
      kept-old-versions 2 ; 保留最早的2个备份文件
      version-control t) ; 多次备份
;;}}}

;;{{{ 这段代码放在最后, 加载 Emacs 的 custom
(if (file-exists-p custom-file) (load-file custom-file))
;; 降低gc域值，使 gc 更快地暂停
(setq gc-cons-threshold (* 2 1000 1000))
;;}}}
