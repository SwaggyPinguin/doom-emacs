;; Org
(package! org-auto-tangle)
(package! org-modern)
(package! toc-org)

;; Icons
;; (package! all-the-icons)
(package! all-the-icons-completion)
(package! all-the-icons-dired)
;; (package! all-the-icons-nerd-fonts)

;; Visual
(package! solaire-mode)
(package! beacon)
(package! rainbow-mode)
(package! focus)
(package! writeroom-mode) ;; This is Zen mode
;; (package! darkroom)

;; Programming
(package! emmet-mode)
(package! twig-mode)
(package! prettier-js)
(package! prettier)

;; Scss
;; (package! helm-css-scss)
(package! scss-mode)

;; PHP
(package! php-mode)
(package! php-cs-fixer)
(package! company-php)
(package! phpactor)

;; Nix
(package! nix-mode)

;; Debug
(package! dap-mode)

;; GitHub Copilot
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))

;; Movement
(package! move-text)

;; Other
(package! deft)
;; (package! counsel-etags)
;; (package! mmm-mode)

;; Themes
(package! mellow-theme)
(package! melancholy-theme)
;; (package! spacemacs-theme)
