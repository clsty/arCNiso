;;; -*- lexical-binding: t -*-
;;; This file is generated from init.0.org, do not edit manually.

(unless (file-exists-p (concat user-emacs-directory "init.0.el"))
  (progn
    (require 'org)
    (find-file (concat user-emacs-directory "init.0.org"))
    (org-babel-tangle)
    (restart-emacs)
    ))

(setq custom-file (concat user-emacs-directory "custom.el"))

; 在 init.0.el 之前加载
(let ((init--1 (concat user-emacs-directory "init.-1.el"))
      (init--2 (concat user-emacs-directory "init.-2.el"))
      (init--3 (concat user-emacs-directory "init.-3.el")))
  (when (file-exists-p init--3) (load-file init--3))
  (when (file-exists-p init--2) (load-file init--2))
  (when (file-exists-p init--1) (load-file init--1)))

; 在 init.0.el 之后加载
(add-hook
 'after-init-hook
 (lambda ()
   (let ((init-1 (concat user-emacs-directory "init.1.el"))
         (init-2 (concat user-emacs-directory "init.2.el"))
         (init-3 (concat user-emacs-directory "init.3.el"))
         (private-file (concat user-emacs-directory "private.el")))
     (when (file-exists-p init-1) (load-file init-1))
     (when (file-exists-p init-2) (load-file init-2))
     (when (file-exists-p init-3) (load-file init-3))
     (when (file-exists-p private-file) (load-file private-file))
     (when (and custom-file (file-exists-p custom-file)) (load-file custom-file))
  ;        (server-start)
     )))

; 加载 init.0.el
(load-file (concat user-emacs-directory "init.0.el"))

(defun tangle-for-init ()
  "Tangle all blocks."
  ;; Avoid running hooks when tangling.
  (let ((prog-mode-hook nil))
    (org-babel-tangle)
    ))

; 仅当本文件是 Emacs 配置目录下的 init.0.org 时，才添加到 after-save-hook
(add-hook
 'org-mode-hook
 (lambda ()
   (when
       (equal
        (buffer-file-name)
        (expand-file-name
         (concat
          user-emacs-directory
          "init.0.org")))
     (add-hook
      'after-save-hook
      'tangle-for-init
      nil t))))
