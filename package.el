;; Org
(package! org-auto-tangle)
(package! org-modern)
(package! toc-org)

;; Icons
(package! all-the-icons)
(package! all-the-icons-completion)
(package! all-the-icons-dired)
(package! all-the-icons-nerd-fonts)

;; Visual
(package! solaire-mode)
(package! beacon)
(package! focus)
(package! rainbow-mode)

;; Programming
(package! emmet-mode)

;; PHP
(package! php-mode)
(package! php-cs-fixer)
(package! company-php)
(package! phpactor)

;; Debug
(package! dap-mode)

;; GitHub Copilot
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))