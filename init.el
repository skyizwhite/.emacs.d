;; パッケージ管理
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(defun config ()
  "Open the user's init.el file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; 言語設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; 余計なファイル作成を無効にする
(setq make-backup-files nil)
(setq auto-save-default nil)

;; 余計な記号を非表示にする
(set-display-table-slot standard-display-table 0 ?\ )
(set-display-table-slot standard-display-table 'wrap ?\ )

;; インデント設定
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default standard-indent 2)

;; デフォルトディレクトリ
(setq default-directory "~/Code/")

;; グローバルのキー設定
(defun vterm-toggle ()
  (interactive)
  (if (eq major-mode 'vterm-mode)
      ;; 既に vterm バッファの場合はバッファを削除（非表示）
      (delete-window)
    ;; それ以外の場合は分割して既存の vterm を表示
    (progn
      (split-window-below)
      (other-window 1)
      ;; 新しいプロセスを起動せず、既存の vterm バッファを表示
      (let ((vterm-buffer (get-buffer "*vterm*")))
        (if vterm-buffer
            (switch-to-buffer vterm-buffer)
          (vterm))))))

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-t") 'vterm-toggle)

;; use-packageのインストールと初期化
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; テーマとUIの設定
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-atom")
  (doom-themes-org-config))

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
  (global-auto-complete-mode t)
  (setq ac-dwim t)
  (setq ac-auto-start nil)
  (ac-set-trigger-key "TAB")
  (define-key ac-completing-map (kbd "C-n") 'ac-next)
  (define-key ac-completing-map (kbd "C-p") 'ac-previous)
  (define-key ac-completing-map (kbd "C-<return>") 'ac-complete))

;; Slimeの設定
(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "ros -Q run")
  (setq slime-lisp-implementations
        '((roswell ("ros" "-Q" "run") :coding-system utf-8-unix)
          (qlot ("qlot" "exec" "ros" "-Q" "run") :coding-system utf-8-unix)))
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (eval-after-load "auto-complete"
    '(add-to-list 'ac-modes 'slime-repl-mode)))

(use-package paredit
  :ensure t
  :hook ((emacs-lisp-mode lisp-mode) . paredit-mode))

;; シェル環境の初期化（macOS）
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

;; vtermの設定
(use-package vterm
  :ensure t
  :config
  (define-key vterm-mode-map (kbd "C-t") 'vterm-toggle)
  (add-hook 'vterm-mode-hook
            (lambda () (display-line-numbers-mode -1))))

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
