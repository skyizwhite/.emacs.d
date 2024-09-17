;; パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; 言語設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; 余計なファイル作成を無効にする
(setq make-backup-files nil)
(setq auto-save-default nil)

;; インデント設定
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

;; use-packageのインストールと初期化
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; テーマとUIの設定
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; ボールドを有効
        doom-themes-enable-italic t) ; イタリックを有効
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)   ;; neotree用のテーマ
  (setq doom-themes-treemacs-theme "doom-atom")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))      ;; org-mode用のカスタムテーマ

;; モードラインのカスタマイズ
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;; 括弧を虹色にする
(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;; Auto-completeの設定
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  (global-auto-complete-mode t))

;; Slimeの設定
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "ros -Q run")
  (setq slime-lisp-implementations
        '((sbcl ("sbcl") :coding-system utf-8-unix)
          (qlot ("qlot" "exec" "sbcl") :coding-system utf-8-unix)))
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode) . paredit-mode)
  :config
  (add-hook 'slime-repl-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode))

;; シェル環境の初期化（macOS）
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

;; vtermの設定
(use-package vterm
  :ensure t)

;; neotreeの設定
(use-package neotree
  :ensure t
  :bind ("C-x d" . neotree-toggle)
  :config
  (setq neo-window-width 30)
  (add-hook 'neotree-mode-hook
            (lambda () (display-line-numbers-mode -1))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(paredit ac-slime auto-complete vterm exec-path-from-shell all-the-icons doom-modeline neotree doom-themes rainbow-delimiters)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
