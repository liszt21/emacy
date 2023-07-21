;; 禁用一些GUI特性
(setq use-dialog-box nil)               ; 鼠标操作不使用对话框
;;(setq inhibit-default-init t)           ; 不加载 `default' 库
;;(setq inhibit-startup-screen t)         ; 不加载启动画面
;;(setq inhibit-startup-message t)        ; 不加载启动消息
;;(setq inhibit-startup-buffer-menu t)    ; 不显示缓冲区列表

;; 设置自动折行宽度为80个字符，默认值为70
(setq-default fill-column 80)

;; 设置大文件阈值为100MB，默认10MB
(setq large-file-warning-threshold 100000000)

;; 以16进制显示字节数
(setq display-raw-bytes-as-hex t)
;; 有输入时禁止 `fontification' 相关的函数钩子，能让滚动更顺滑
(setq redisplay-skip-fontification-on-input t)

;; 禁止响铃
(setq ring-bell-function 'ignore)

;; 在光标处而非鼠标所在位置粘贴
(setq mouse-yank-at-point t)

;; 拷贝粘贴设置
(setq select-enable-primary nil)        ; 选择文字时不拷贝
(setq select-enable-clipboard t)        ; 拷贝时使用剪贴板

;; 鼠标滚动设置
(setq scroll-step 2)
(setq scroll-margin 2)
(setq hscroll-step 2)
(setq hscroll-margin 2)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq scroll-preserve-screen-position 'always)

;; 对于高的行禁止自动垂直滚动
(setq auto-window-vscroll nil)

;; 设置新分屏打开的位置的阈值
(setq split-width-threshold (assoc-default 'width default-frame-alist))
(setq split-height-threshold nil)

;; TAB键设置，在Emacs里不使用TAB键，所有的TAB默认为4个空格
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; yes或no提示设置，通过下面这个函数设置当缓冲区名字匹配到预设的字符串时自动回答yes
(setq original-y-or-n-p 'y-or-n-p)
(defalias 'original-y-or-n-p (symbol-function 'y-or-n-p))
(defun default-yes-sometimes (prompt)
  "automatically say y when buffer name match following string"
  (if (or
    (string-match "has a running process" prompt)
    (string-match "does not exist; create" prompt)
    (string-match "modified; kill anyway" prompt)
    (string-match "Delete buffer using" prompt)
    (string-match "Kill buffer of" prompt)
    (string-match "still connected.  Kill it?" prompt)
    (string-match "Shutdown the client's kernel" prompt)
    (string-match "kill them and exit anyway" prompt)
    (string-match "Revert buffer from file" prompt)
    (string-match "Kill Dired buffer of" prompt)
    (string-match "delete buffer using" prompt)
(string-match "Kill all pass entry" prompt)
(string-match "for all cursors" prompt)
    (string-match "Do you want edit the entry" prompt))
   t
    (original-y-or-n-p prompt)))
(defalias 'yes-or-no-p 'default-yes-sometimes)
(defalias 'y-or-n-p 'default-yes-sometimes)

;; 设置剪贴板历史长度300，默认为60
(setq kill-ring-max 200)

;; 在剪贴板里不存储重复内容
(setq kill-do-not-save-duplicates t)

;; 设置位置记录长度为6，默认为16
;; 可以使用 `counsel-mark-ring' or `consult-mark' (C-x j) 来访问光标位置记录
;; 使用 C-x C-SPC 执行 `pop-global-mark' 直接跳转到上一个全局位置处
;; 使用 C-u C-SPC 跳转到本地位置处
(setq mark-ring-max 6)
(setq global-mark-ring-max 6)

;; 设置 emacs-lisp 的限制
(setq max-lisp-eval-depth 10000)        ; 默认值为 800
(setq max-specpdl-size 10000)           ; 默认值为 1600

;; 启用 `list-timers', `list-threads' 这两个命令
(put 'list-timers 'disabled nil)
(put 'list-threads 'disabled nil)

;; 在命令行里支持鼠标
(xterm-mouse-mode 1)

;; 退出Emacs时进行确认
;;(setq confirm-kill-emacs 'y-or-n-p)

;; 在模式栏上显示当前光标的列号
(column-number-mode t)

;; 配置所有的编码为UTF-8，参考：
;; https://thraxys.wordpress.com/2016/01/13/utf-8-in-emacs-everywhere-forever/
;; (setq locale-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-default-coding-systems 'utf-8)
;; (set-language-environment 'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-file-name-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)
;; (when (display-graphic-p) (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))


(defun fonts-installed (&rest font-list) (reverse (cl-intersection font-list (font-family-list) :test #'equal)))

(use-package fontaine
  :ensure t
  :when (display-graphic-p)
  :config
  (setq fontaine-latest-state-file (locate-user-emacs-file "etc/fontaine-latest-state.eld"))
  (setq fontaine-presets
    '((regular
       :default-height 140
       :default-weight regular
       :fixed-pitch-height 1.0
       :variable-pitch-height 1.0)
      (large
       :default-height 180
       :default-weight normal
       :fixed-pitch-height 1.0
       :variable-pitch-height 1.05)
      (t
       :default-family "Fira Code"
       :fixed-pitch-family "Fira Code"
       :variable-pitch-family "Fira Code"
       :italic-family "Fira Code"
       :variable-pitch-weight normal
       :bold-weight normal
       :italic-slant italic
       :line-spacing 0.1)))
  ;; (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))
  (fontaine-set-preset 'regular)

  ;; set emoji font
  (set-fontset-font t (if (version< emacs-version "28.1") '(#x1f300 . #x1fad0) 'emoji)
    (car (fonts-installed
          "Noto Emoji"
          "Symbola"
          "Apple Color Emoji"
          "Noto Color Emoji"
          "Segoe UI Emoji")))
  ;; set Chinese font
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :family
                (car (fonts-installed
                       "LXGW Wenkai"
                       "霞鹜文楷"
                       "Sarasa Gothic SC"
                       "更纱黑体 SC")))))

  ;; set Chinese font scale
  (setq face-font-rescale-alist `(
                                  ("Symbola"             . 1.3)
                                  ("Microsoft YaHei"     . 1.2)
                                  ("WenQuanYi Zen Hei"   . 1.2)
                                  ("Sarasa Mono SC Nerd" . 1.2)
                                  ("PingFang SC"         . 1.16)
                                  ("Lantinghei SC"       . 1.16)
                                  ("Kaiti SC"            . 1.16)
                                  ("Yuanti SC"           . 1.16)
                                  ("Apple Color Emoji"   . 0.91))))
;; TODO
(use-package fontify-face)

(use-package doom-modeline
  :ensure t
  :hook (elpaca-after-init . doom-modeline-mode)
  :custom
  (doom-modeline-irc nil)
  (doom-modeline-mu4e nil)
  (doom-modeline-gnus nil)
  (doom-modeline-github nil)
  (doom-modeline-buffer-file-name-style 'truncate-upto-root) ; : auto
  (doom-modeline-persp-name nil)
  (doom-modeline-unicode-fallback t)
  (doom-modeline-enable-word-count nil))

;; [[https://github.com/tarsius/minions][minions]] 插件能让模式栏变得清爽，将次要模式隐藏起来。
(use-package minions
  :ensure t
  :hook (elpaca-after-init . minions-mode))

(use-package keycast
  :ensure t
  :hook (elpaca-after-init . keycast-mode)
  ;; :custom-face
  ;; (keycast-key ((t (:background "#0030b4" :weight bold))))
  ;; (keycast-command ((t (:foreground "#0030b4" :weight bold))))
  :config
  ;; set for doom-modeline support
  ;; With the latest change 72d9add, mode-line-keycast needs to be modified to keycast-mode-line.
  (define-minor-mode keycast-mode
    "Show current command and its key binding in the mode line (fix for use with doom-mode-line)."
    :global t
    (if keycast-mode)
    (progn))
  (add-hook 'pre-command-hook 'keycast--update t)
  (add-to-list 'global-mode-string '("" keycast-mode-line "  "))
  (remove-hook 'pre-command-hook 'keycast--update)
  (setq global-mode-string (delete '("" keycast-mode-line "  ") global-mode-string))

  (dolist (input '(self-insert-command org-self-insert-command))
    (add-to-list 'keycast-substitute-alist `(,input "." "Typing…")))

  (dolist (event '(mouse-event-p mouse-movement-p mwheel-scroll))
    (add-to-list 'keycast-substitute-alist `(,event nil)))

  (setq keycast-log-format "%-20K%C\n")
  (setq keycast-log-frame-alist '((minibuffer . nil)))
  (setq keycast-log-newest-first t))

(use-package anzu
    :config
    (global-anzu-mode +1))

(use-package evil-anzu :after evil)

(use-package rainbow-mode)

(use-package dashboard
  :hook
  (elpaca-after-init . (lambda () (dashboard-open)))
  :config
  ;; FIXME
  ;;(dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-projects-backend 'projectile))

(require 'init-theme)

(provide 'init-ui)
