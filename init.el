(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (markdown-mode flycheck))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set bsd style C coding
(setq c-default-style "bsd"
      c-basic-offset 4)
;; diplay line numbers
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;; complete brakets 
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)

;; use bash in shell
(setq-default explicit-shell-file-name "/bin/bash")

;; word wrap
(setq-default word-wrap t)

;; For flycheck, add MELPA repositories
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; global syntax checking with flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; activate IDO
  (require 'ido)
    (ido-mode t)

;; markdown-mode
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
