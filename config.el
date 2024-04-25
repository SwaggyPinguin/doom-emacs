;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 14)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 20)
      doom-serif-font (font-spec :family "JetBrainsMono Nerd Font" :size 14))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

;; (custom-set-faces!
;;   '(font-lock-comment-face :slant italic)
;;   '(font-lock-keyword-face :slant italic))

;; maximize window on startup
;; (setq initial-frame-alist '((top . 1) (left . 1) (width . 114) (height . 32)))
;; (add-to-list 'initial-frame-alist '(maximized))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Set Path to search for Projects
;; (setq projectile-project-search-path '(("~/Documents/Projects" . 2) ("~/.config" . 1)))
(setq projectile-project-search-path '("~/Documents/Projects/bmc/bmc-staging" "~/Documents/Projects/wifimedia4u"))

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git"
          projectile-project-root-files-bottom-up)))


;; Unique buffer names
(setq uniquify-buffer-name-style 'forward
      uniquify-min-dir-content 3)

;; File Modes
(add-to-list 'auto-mode-alist '("\\.html\\.twig\\'" . web-mode))
;; (setq web-mode-engines-alist
;;       '(("twig" . "\\.twig\\'")))

;; Use Twig comment syntax in web-mode for .twig files
;; (defun my-web-mode-hook ()
;;   "Hooks for Web mode."
;;   (setq web-mode-comment-formats
;;         '(("twig" . " {# %s #}")))
;;   )
;; (add-hook 'web-mode-hook  'my-web-mode-hook)

;; php-cs-fixer config
(add-hook 'before-save-hook 'php-cs-fixer-before-save)
(use-package! php-cs-fixer
  :config
  (setq php-cs-fixer-config-option (concat (getenv "HOME") "/.config/doom/tools/.php-cs.php")))

;; (use-package dap-mode
;;   ;; Uncomment the config below if you want all UI panes to be hidden by default!
;;   ;; :custom
;;   ;; (lsp-enable-dap-auto-configure nil)
;;   ;; :config
;;   ;; (dap-ui-mode 1)
;;   ;; :custom
;;   ;; (dap-auto-configure-features '(locals controls tooltip))

;;   :config
;;   ;; Set up Node debugging
;;   ;; (require 'dap-node)
;;   ;; (dap-node-setup) ;; Automatically installs Node debug adapter if needed
;;   ;; Setup PHP debugging
;;   ;; (dap-ui-mode 1)
;;   (require 'dap-php)
;;   (dap-php-setup)

;;   ;; Bind `C-c l d` to `dap-hydra` for easy access
;;   (general-define-key
;;     :keymaps 'lsp-mode-map
;;     :prefix lsp-keymap-prefix
;;     "d" '(dap-hydra t :wk "debugger")))

(add-hook 'php-mode-hook 'lsp)

(use-package php-mode
  :mode "\\.php\\'"
  :config
  (require 'dap-php)
  (dap-php-setup))

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-php)
  (yas-global-mode))

;; (dap-register-debug-template
;;   "PHP Listen for Xdebug BMC"
;;   (list :type "php"
;;         :request "launch"
;;         :name "Listen for Xdebug"
;;         :port 9003
;;         :pathMappings (list "/var/www/bmc" "${workspaceFolder")
;;         :log (concat doom-cache-dir "xdebug.log")))

;; (dap-register-debug-template
;;   "PHP Listen for Xdebug PP"
;;   (list :type "php"
;;         :request "launch"
;;         :name "Listen for Xdebug"
;;         :port 9003
;;         :pathMappings (list "/var/www/wifimedia4u" "${workspaceFolder}")
;;         :log (concat doom-cache-dir "xdebug.log")))

(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "bash"))

;; disable copilot warning
(use-package copilot
  :hook
  (prog-mode . copilot-mode)
  (copilot-mode . (lambda ()
                    (setq-local copilot--indent-warning-printed-p t))))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("M-j" . 'copilot-accept-completion)
              ("M-j" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))
              ;; ("<tab>" . 'copilot-accept-completion)
              ;; ("TAB" . 'copilot-accept-completion)
              ;; ("C-TAB" . 'copilot-accept-completion-by-word)
              ;; ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; Emmet
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'php-mode-hook 'emmet-mode)

;; Avy Jump
(global-set-key (kbd "C-'") 'avy-goto-char-2)
;; window movement
(global-set-key (kbd "C-j") 'evil-window-down)
(global-set-key (kbd "C-k") 'evil-window-up)
(global-set-key (kbd "C-h") 'evil-window-left)
(global-set-key (kbd "C-l") 'evil-window-right)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
