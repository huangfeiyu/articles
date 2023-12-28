(tool-bar-mode -1)
(menu-bar-mode -1)
;; (cua-mode 1)
;; (global-set-key (kbd "C-x v") nil)
(global-set-key (kbd "C-x C-s") nil)
;; (global-set-key (kbd "C-n") nil)
(global-set-key (kbd "C-S-p") 'save-buffer)
;; (global-set-key (kbd "C-p") nil)
(global-set-key (kbd "C-s") nil)
(global-set-key (kbd "C-S-R") 'isearch-forward)
(define-key isearch-mode-map (kbd "C-S-R") 'isearch-repeat-forward)
(global-set-key [home] 'back-to-indentation)
(fido-vertical-mode t)
(defun new-blank-line()
  (interactive)
  "Create a new empty line in the next line."
  (move-end-of-line nil)
  (newline-and-indent))

(defun project-kill-other-buffers (&optional no-confirm)
  (interactive)
  (let* ((pr (project-current t))
         (bufs1 (project--buffers-to-kill pr))
         (bufs (remove (current-buffer) bufs1)))
    (cond (no-confirm
           (mapc #'kill-buffer bufs))
          ((null bufs)
           (message "No buffers to kill"))
          ((yes-or-no-p (format "Kill %d buffers in %s? "
                                (length bufs)
                                (project-root pr)))
           (mapc #'kill-buffer bufs)))))
(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Doesn't mess with special buffers."
  (interactive)
  (when (y-or-n-p "Are you sure you want to kill all buffers but the current one? ")
    (seq-each
     #'kill-buffer
     (delete (current-buffer) (seq-filter #'buffer-file-name (buffer-list))))))

(global-set-key (kbd "C-x p k") 'project-kill-other-buffers)
(global-set-key (kbd "s-k") 'kill-other-buffers)
(add-hook 'ediff-mode-hook (lambda () (disable-theme 'doom-molokai)))
(add-hook 'ediff-quit-session-group-hook (lambda () (enable-theme 'doom-molokai)))

(global-set-key (kbd "<C-return>") 'new-blank-line)
(global-set-key (kbd "<S-return>") 'eval-last-sexp)
;; (setq debug-on-message ".*Error in post-command-hook.*")
(require 'package)
(setq package-archives '(
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ;; ("gnu" . "http://elpa.emacs-china.org/gnu/")
                         ;; ("melpa" . "http://elpa.emacs-china.org/melpa/")
                         ))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case t)
 '(company-minimum-prefix-length 3)
 '(context-menu-mode t)
 '(create-lockfiles nil)
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("eca44f32ae038d7a50ce9c00693b8986f4ab625d5f2b4485e20f22c47f2634ae" "8c7e832be864674c220f9a9361c851917a93f921fedb7717b1b5ece47690c098" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "22ce392ec78cd5e512169f8960edf5cbbad70e01d3ed0284ea62ab813d4ff250" "b0e446b48d03c5053af28908168262c3e5335dcad3317215d9fdeb8bac5bacf9" "e19ac4ef0f028f503b1ccafa7c337021834ce0d1a2bca03fcebc1ef635776bea" "0466adb5554ea3055d0353d363832446cd8be7b799c39839f387abb631ea0995" default))
 '(dired-dwim-target t)
 '(dumb-jump-ignore-context t)
 '(ediff-diff-options "-w")
 '(ediff-diff-program "diff")
 '(ediff-show-ancestor t)
 '(ediff-split-window-function 'split-window-horizontally)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(eww-search-prefix "https://cn.bing.com/search?ensearch=1&q=")
 '(fill-column 200)
 '(global-display-line-numbers-mode t)
 '(global-tab-line-mode t)
 '(helm-completion-style 'helm)
 '(indent-tabs-mode nil)
 '(lsp-file-watch-threshold 40000)
 '(lsp-log-io nil)
 '(lsp-ui-sideline-show-code-actions nil)
 '(magit-diff-use-overlays nil)
 '(make-backup-files nil)
 '(nrepl-sync-request-timeout 60)
 '(org-hide-emphasis-markers t)
 '(org-startup-indented t)
 '(org-table-convert-region-max-lines 9999999)
 '(package-selected-packages
   '(lsp-tss lsp-tsserver lsp-css lsp-html helm-xref helm-lsp org-superstar yasnippet-snippets which-key web-mode use-package pdf-tools nov magit lua-mode lsp-ui js2-mode helm-ag expand-region doom-themes diminish dap-mode company))
 '(read-buffer-completion-ignore-case t)
 '(require-final-newline nil)
 '(scroll-preserve-screen-position nil)
 '(shr-inhibit-images t)
 '(warning-suppress-types '((use-package)))
 '(web-mode-code-indent-offset 2)
 '(web-mode-enable-auto-expanding t)
 '(web-mode-enable-auto-indentation nil)
 '(web-mode-enable-control-block-indentation nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; load notes
;; (let ((filename "~/.notes.org"))
;;   (when (file-exists-p filename)
;;     (setq initial-buffer-choice filename)))
;; lsp-java configuration start
(setenv "LSP_USE_PLISTS"  "true")
(setq use-package-always-ensure t)
;; (use-package projectile)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers
                ;; Enable eslint checker for web-mode
                (flycheck-add-mode 'javascript-eslint 'js2-mode)
                
                (setq-default flycheck-disabled-checkers
                              (append flycheck-disabled-checkers
                                      '(json-jsonlist)))
                (if (executable-find "eslint") ; we only want to enable eslint checking if we find eslint installed locally
                    (flycheck-add-mode 'javascript-eslint 'js2-mode)
                  (flycheck-select-checker 'javascript-eslint))))

(use-package yasnippet :config (yas-global-mode))
(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook (js-mode . lsp-deferred)
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :hook (web-mode . lsp-deferred)
  )
(use-package company)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package which-key :config (which-key-mode))
(use-package dap-mode :after lsp-mode :config (dap-auto-configure-mode))
(use-package lsp-treemacs)

;; customization
(with-eval-after-load 'lsp-mode
  ;; don't scan 3rd party javascript libraries
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored) ; json
  (push "/target/.*" lsp-file-watch-ignored) ; target
  (push "/node/.*" lsp-file-watch-ignored) ; node
  (push "/node_modules/.*" lsp-file-watch-ignored) ; node
  (push ".*/vendors/.*" lsp-file-watch-ignored) ; node
  (push ".*\\.min\\.js$" lsp-file-watch-ignored) ; node
  (push ".*/main/webpack/.*" lsp-file-watch-ignored) ; node webpack
  )
;; current VSCode defaults
(setq gc-cons-threshold 200000000)
(setq read-process-output-max (* 3072 2048)) ;; 3mb
(setq lsp-idle-delay 0.500)
;; (add-hook 'dap-stopped-hook (lambda (arg) (call-interactively #'dap-hydra)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "M-i") 'dap-step-in)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "M-o") 'dap-step-out)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "M-c") 'dap-continue)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "M-n") 'dap-next)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "M-q") 'dap-disconnect)))
(add-hook 'dap-mode-hook (lambda () (local-set-key (kbd "<f6>") 'dap-tooltip-at-point)))
(dap-register-debug-template
  "Java Attach"
  (list :name "Java Attach"
        :type "java"
        :request "attach"
        :hostName "localhost"
        :projectName "jdt.ls-java-project"
        :port 11550))
;; lsp-java configuration end
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))
(use-package org-superstar)
(use-package avy)
;; (setq tramp-default-method "ssh")
;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(add-hook 'after-init-hook 'global-company-mode)

(setq-default tab-width 2)
(global-set-key [remap dabbrev-expand] 'hippie-expand)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-c g") 'magit-file-dispatch)
(global-set-key (kbd "C-o") 'project-find-file)
(global-set-key (kbd "C-j") 'avy-goto-word-1)
(global-set-key (kbd "C-S-v") 'scroll-down-command)
(global-set-key (kbd "C-S-c") 'scroll-up-command)
(global-set-key (kbd "<f5>") 'revert-buffer)
;; (global-set-key (kbd "C-M-i") 'company-complete)

(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jspf\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml\\'" . web-mode))
(setq web-mode-engines-alist
      '(("jsp"    . "\\.jspf\\'"))
      )
(add-hook 'web-mode-hook (lambda () (web-mode-toggle-current-element-highlight)))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-e") 'web-mode-element-end )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-a") 'web-mode-element-beginning )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-c e s") 'web-mode-element-select )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-c e a") 'web-mode-element-content-select )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-u") 'web-mode-element-parent )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-d") 'web-mode-element-child )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-p") 'web-mode-element-previous )))
(add-hook 'web-mode-hook (lambda () (local-set-key (kbd "C-M-n") 'web-mode-element-next )))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node"
  :config
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil))


(show-paren-mode 1)
(electric-pair-mode 1)

(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
    (global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
    (global-set-key (kbd "S-C-<down>") 'shrink-window)
    (global-set-key (kbd "S-C-<up>") 'enlarge-window)

(desktop-save-mode 1)
(setq shr-inhibit-images t)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-todo-keywords
            '((sequence "TODO" "DOING" "|" "DONE" "DELEGATED")))
(setq org-log-done 'time)
(setq org-todo-keyword-faces
      '(("DOING" . "green")))
(setq-default cursor-type 'bar)

;; tabnine setting
;; (use-package company-tabnine :ensure t)
;; (add-to-list 'company-backends #'company-tabnine)
;; Trigger completion immediately.
;; (setq company-idle-delay 0)
;; end tabnine setting.

(use-package expand-region)
(use-package pdf-tools)
(use-package doom-themes)
(use-package lua-mode)
(use-package nov)
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "s-j j") 'dap-debug)
(global-set-key (kbd "s-j l") 'dap-debug-last)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-unset-key (kbd "C-x c"))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(add-hook 'java-mode-hook 'display-line-numbers-mode)
(add-hook 'java-mode-hook (lambda () (setq-local tab-width 4)))
(defun set-web-mode-indentation ()
  "Set indentation size to 2 for web-mode."
  (setq-local web-mode-markup-indent-offset 2
              web-mode-css-indent-offset 2
              web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook 'set-web-mode-indentation)
(add-hook 'web-mode-hook 'display-line-numbers-mode)
(add-hook 'lua-mode-hook 'display-line-numbers-mode)
(add-hook 'lua-mode-hook (lambda () (local-set-key (kbd "<M-down>") 'lsp-ui-find-next-reference)))
(add-hook 'lua-mode-hook (lambda () (local-set-key (kbd "<M-up>") 'lsp-ui-find-prev-reference)))
(add-hook 'lua-mode-hook (lambda () (local-set-key (kbd "C-M-=") 'lua-goto-matching-block)))
(add-hook 'org-mode-hook (lambda () (visual-line-mode 1)))
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(add-hook 'typescript-mode-hook #'lsp-deferred)
(add-hook 'typescript-mode-hook (lambda () (local-set-key (kbd "<M-down>") 'lsp-ui-find-next-reference)))
(add-hook 'typescript-mode-hook (lambda () (local-set-key (kbd "<M-up>") 'lsp-ui-find-prev-reference)))
(add-hook 'lua-mode-hook #'lsp-deferred)
(pdf-loader-install)

;; (use-package treesit-auto
;;   :config
;;   (global-treesit-auto-mode))
(use-package helm)
(use-package helm-lsp)
(use-package helm-ag)
(use-package helm-xref)
(define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol)
(global-set-key (kbd "C-S-n") 'helm-do-ag-project-root)
(global-set-key (kbd "C-S-i") 'helm-imenu)
(global-set-key (kbd "C-S-s") 'helm-occur)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(add-hook 'java-mode-hook (lambda () (local-set-key (kbd "C-S-o") 'helm-lsp-global-workspace-symbol)))
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (global-set-key (kbd "M-x") 'helm-M-x)
(defun helm-do-grep-ag-root (arg)
  "Preconfigured `helm' for grepping with AG in `project-root'.
With prefix arg prompt for type if available with your AG
version."
  (interactive "P")
  ;; (require 'helm-files)
  (helm-grep-ag-1
   (expand-file-name
    (project-root
     (project-current t))) arg))
(defalias 'yes-or-no-p 'y-or-n-p)
(put 'narrow-to-region 'disabled nil)
(put 'scroll-left 'disabled nil)
