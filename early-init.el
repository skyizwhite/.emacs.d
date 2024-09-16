;; UI設定
(setq initial-frame-alist '((width . 135) (height . 50)))
(setq default-frame-alist '((width . 135) (height . 50)))
(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq frame-inhibit-implied-resize t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(set-face-attribute 'default nil
                    :family "Monaco"
                    :height 120)
