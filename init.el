;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes '(deeper-blue))
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gud-gdb-command-name "gdb -i=mi ../bin/test")
 '(inhibit-startup-screen t)
 '(org-agenda-files
   '("~/uni/cs680/notes.org" "/home/ajb/org/family.org" "/home/ajb/org/finances.org" "/home/ajb/org/health.org" "/home/ajb/org/orginizer.org" "/home/ajb/org/social.org" "/home/ajb/org/template.org"))
 '(package-selected-packages
   '(gdb-mi quelpa-use-package hydra quelpa highlight-parentheses conda use-package jupyter ein magit adaptive-wrap markdown-mode flycheck))
 '(safe-local-variable-values
   '((eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~./include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/craftingInterpreters/chapter1/C/include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/job/kdtree/include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/job/multimap/include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/job/spatial/include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/job/spatial-tree/include/")))
     (eval setq flycheck-gcc-include-path
	   (list
	    (expand-file-name "~/code/job/trees/include/"))))))
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

;; word wrap
;;(setq-default word-wrap t)
(global-visual-line-mode t)


;; add MELPA repositories
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; global syntax checking with flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 0   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.(setq backup-directory-alist `(("." . "~/.emacs.d/back")))

(setq vc-make-backup-files t)

;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

;; org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
;; (setq org-agenda-files '("~/org"))
(setq org-agenda-files (directory-files-recursively "~/" "\\.org$"))

;; start Emacs server
(server-start) 

;; highlight parenthesis
(require 'highlight-parentheses)
(add-hook 'prog-mode-hook 'highlight-parentheses-mode)


;; ibuffer stuff
(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("home"
	("emacs-config" (or (filename . ".emacs.d")))
	("org" (mode . org-mode))
	("source" (filename . "src"))
	("header" (filename . "include"))
	("Makefile" (or (mode . make-mode)
			(filename . "Makefile")))
	("gdb" (or (mode . gud-mode))))))

(add-hook 'ibuffer-mode-hook
	  '(lambda ()
	     (ibuffer-auto-mode 1)
	     (ibuffer-switch-to-saved-filter-groups "home")))

(setq ibuffer-expert t)
;;(setq ibuffer-show-empty-filter-groups nil)



	 

;; open alias
(defalias 'emc 'find-file)

;; clear shell
(local-set-key (kbd "C-<backspace>") (lambda () (interactive) (eshell/clear 1)))


;; Jupyter notebook stuff
(require 'use-package)
(use-package jupyter)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (shell .t)
   ;; Python and jupyter
   (python . t)
   (jupyter . t)))

(org-babel-jupyter-override-src-block "python")

(setq ob-async-no-async-languages-alist '("python" "jupyter-python"))

(use-package conda)



(defun my/juper-refresh-kernelspecs ()
  "Refresh Jupyter kernelspecs"
  (interactive)
  (jupyter-available-kernelspecs t))


;; desktop save mode
(desktop-save-mode 1)

(setq compile-command "make -k -C ../")

;;gdb-m
(require 'quelpa-use-package)


