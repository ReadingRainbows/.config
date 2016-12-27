(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                        ("org" . "http://orgmode.org/elpa/")
                        ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)

(load "elscreen")
(elscreen-start)
(add-to-list 'load-path "~/Documents/Emacs/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

  (add-hook 'neotree-mode-hook
                        (lambda ()
                                        (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                                        (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
                                        (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                                        (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(require 'powerline)
(powerline-center-evil-theme)

(require 'evil-magit)
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; load the packaged named xyz.
(load "evil-tabs") ;; best not to include the ending “.el” or “.elc”
(global-evil-tabs-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (suscolors)))
 '(custom-safe-themes
   (quote
    ("b9b1a8d2ec1d5c17700e1a09256f33c2520b26f49980ed9e217e444c381279a9" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-splash-screen t)
(require 'org)
(require 'evil)
(evil-mode 1)
