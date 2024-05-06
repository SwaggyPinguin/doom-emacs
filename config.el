;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;;------ User Configuration ------;;;

(setq doom-theme 'doom-one)

;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
;;       doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
;;       doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 20)
;;       doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

(setq doom-font (font-spec :family "Liga SFMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Liga SFMono Nerd Font" :size 14)
      doom-big-font (font-spec :family "Liga SFMono Nerd Font" :size 20)
      doom-serif-font (font-spec :family "Liga SFMono Nerd Font" :size 14))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; (custom-set-faces!
;;   '(font-lock-comment-face :slant italic)
;;   '(font-lock-keyword-face :slant italic))

(setq display-line-numbers-type t) ; nil to disable or relative

;; Icons in completion buffers
;; (add-hook 'marginalia-mode-hook #'all-the-icons-completion-marginalia-setup)
;; (all-the-icons-completion-mode)

;; This makes non-main buffers dimmer, so you can focus on main buffers
(solaire-global-mode +1)

;; Beacon shows where the cursor is, even when fast scrolling
;; (setq beacon-mode t)
(beacon-mode 1)

;; Don't create backup files
(setq make-backup-files nil)

;; `gruvbox-material' contrast and palette options
(setq doom-gruvbox-material-background  "medium"  ; or hard (defaults to soft)
     doom-gruvbox-material-palette     "mix") ;mix or original (defaults to material)

;; `gruvbox-material-light' contrast and palette options
(setq doom-gruvbox-material-light-background  "medium" ; or hard (defaults to soft)
      doom-gruvbox-material-light-palette     "mix") ; or original (defaults to material)

;; set `doom-theme'
;; (setq doom-theme 'doom-gruvbox-material) ; dark variant
;; (setq doom-theme 'doom-gruvbox-material-light) ; light variant

;; Set default org directory
(setq org-directory "~/org/")

;; Top-level headings should be bigger!
(custom-set-faces!
  '(org-level-1 :inherit outline-1 :height 1.3)
  '(org-level-2 :inherit outline-2 :height 1.25)
  '(org-level-3 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-4 :height 1.1)
  '(org-level-5 :inherit outline-5 :height 1.1)
  '(org-level-6 :inherit outline-6 :height 1.05)
  '(org-level-7 :inherit outline-7 :height 1.05)
  )

(after! org (org-eldoc-load))

(with-eval-after-load 'org (global-org-modern-mode))

(setq
  ;; Edit settings
  org-auto-align-tags nil
  org-tags-column 0
  org-fold-catch-invisible-edits 'show-and-error
  org-special-ctrl-a/e t
  org-insert-heading-respect-content t

  ;; Org styling, hide markup etc.
  org-hide-emphasis-markers t
  org-pretty-entities t
  org-ellipsis "…")

(setq-default line-spacing 0)

;; Automatic table of contents is nice
(if (require 'toc-org nil t)
    (progn
      (add-hook 'org-mode-hook 'toc-org-mode)
      (add-hook 'markdown-mode-hook 'toc-org-mode))
  (warn "toc-org not found"))

;; Tangle Org files when we save them
(defun tangle-on-save-org-mode-file()
  (when (string= (message "%s" major-mode) "org-mode")
    (org-babel-tangle)))

(add-hook 'after-save-hook 'tangle-on-save-org-mode-file)

;; Better for org source blocks
;; (setq electric-indent-mode nil)
;; (setq org-src-window-setup 'current-window)
;; (set-popup-rule! "^\\*Org Src"
;;   :side 'top'
;;   :size 0.9)

;; Prevent initializing the home directory as a project
(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git"
          projectile-project-root-files-bottom-up))
  (setq projectile-auto-discover nil)
  (setq projectile-track-known-projects-automatically nil)
  (setq projectile-ignored-projects '("~/"))
  (setq projectile-project-search-path '("~/Documents/Projects/bmc/bmc-staging"
                                       "~/Documents/Projects/bmc/bmc-old"
                                       "~/Documents/Projects/wifimedia4u")))

;; Quicker window management keybindings
(bind-key* "C-j" #'evil-window-down)
(bind-key* "C-k" #'evil-window-up)
(bind-key* "C-h" #'evil-window-left)
(bind-key* "C-l" #'evil-window-right)
(bind-key* "C-q" #'evil-window-delete)
(bind-key* "M-q" #'kill-current-buffer)
(bind-key* "M-w" #'+workspace/close-window-or-workspace)
(bind-key* "M-n" #'next-buffer)
(bind-key* "M-p" #'previous-buffer)
(bind-key* "M-z" #'+vterm/toggle)
(bind-key* "M-e" #'+eshell/toggle)
(bind-key* (kbd "M-<return>") #'+vterm/here)
(bind-key* (kbd "M-E") #'+eshell/here)

(bind-key* "<mouse-9>" #'next-buffer)
(bind-key* "<mouse-8>" #'previous-buffer)

;; Unique buffer names
(setq uniquify-buffer-name-style 'forward
      uniquify-min-dir-content 3)

;; Set buffer file size limit
(setq default-buffer-file-size-limit (* 1024 1024)) ; Set to 1 MB

;; (require 'focus)

;; (map! :leader
;;       :prefix ("F" . "Focus mode")
;;       :desc "Toggle focus mode"
;;       "t" 'focus-mode

;;       :desc "Pin focused section"
;;       "p" 'focus-pin

;;       :desc "Unpin focused section"
;;       "u" 'focus-unpin)

;; (add-to-list 'focus-mode-to-thing '(org-mode . org-element))
;; (add-to-list 'focus-mode-to-thing '(php-mode . paragraph))
;; (add-to-list 'focus-mode-to-thing '(lisp-mode . paragraph))

(use-package lsp-mode)

(use-package nix-mode
  :hook (nix-mode . lsp-deferred))

(use-package php-mode
  :hook (php-mode . lsp-deferred))

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode nix-mode php-mode))
(setq lsp-enable-file-watchers nil)

;; File Modes
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.twig$'" . twig-mode))

(add-hook 'before-save-hook 'php-cs-fixer-before-save)
(use-package! php-cs-fixer
  :config
  (setq php-cs-fixer-config-option (concat (getenv "HOME") "/.config/doom/tools/.php-cs.php")))

(require 'prettier-js)
(add-hook 'js2-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)

(use-package dap-mode
  :config
  (dap-ui-mode 1)
  (require 'dap-php)
  (dap-php-setup))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "zsh"))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  ;; disable copilot warning
  (copilot-mode . (lambda ()
                    (setq-local copilot--indent-warning-printed-p t)))
  :config
  (setq copilot-max-char 1000000)
  :bind (:map copilot-completion-map
              ("M-j" . 'copilot-accept-completion)
              ("M-j" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
              ;; ("<tab>" . 'copilot-accept-completion)
              ;; ("TAB" . 'copilot-accept-completion)
              ;; ("C-TAB" . 'copilot-accept-completion-by-word)
              ;; ("C-<tab>" . 'copilot-accept-completion-by-word)))

(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook 'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'php-mode-hook 'emmet-mode)
;; (add-hook 'twig-mode-hook 'emmet-mode)

;; Already set to "SPC t z" (Zen Mode)
;; (map! :leader
;;       (:prefix "t"
;;                :desc "Writeroom Mode" "W" #'writeroom-mode))

(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-M-<") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-M->") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-M-=") #'writeroom-adjust-width))

(global-set-key (kbd "C-'") 'avy-goto-char-2)

;; Disables custom.el
(setq custom-file null-device)

(use-package treemacs
  :defer t
  :config
  (setq treemacs-width 40))

(map! :after treemacs
      :map treemacs-mode-map
      :localleader
      :desc "Treemacs toggle wide with" "w" #'treemacs-extra-wide-toggle)

(after! magit
  (setq magit-show-long-lines-warning nil))

;; Reindent line after moving
(defun indent-region-advice (&rest ignored)
  (let ((deactivate deactivate-mark))
    (if (region-active-p)
        (indent-region (region-beginning) (region-end))
      (indent-region (line-beginning-position) (line-end-position)))
    (setq deactivate-mark deactivate)))

(advice-add 'move-text-up :after 'indent-region-advice)
(advice-add 'move-text-down :after 'indent-region-advice)
