;;(require 'org-init)
;;(load ~/.emacs/config/org-mode/org-init.el)
(add-to-list 'load-path "~/.emacs.d/custom/")
(require 'paredit)
(require 'init-paredit)
(require 'init-slime)
;;tell where the program ctags is
(setq path-to-ctags "/usr/bin/ctags")
;; tell where to store desktop save
(defvar emacs-configuration-directory
      "~/.emacs.d/"
          "The directory where the emacs configuration files are stored.")
;;tell how to name the file containing the elscreen save
(defvar elscreen-tab-configuration-store-filename
      (concat emacs-configuration-directory ".elscreen")
          "The file where the elscreen tab configuration is stored.")
;;Custom function to kill all except the current window.
(defun kill-other-buffers ()
        "Kill all other buffers."
        (interactive)
        (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
;;Create a function to generate ctags
(defun create-tags (dir-name)
      "Create tags file."
      (interactive "DDirectory: ")
      (shell-command
      (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
      )
;;Save the current buffer layout
(defun session-save ()
      "Store the elscreen tab configuration."
      (interactive)
      (if (desktop-save emacs-configuration-directory)
          (with-temp-file elscreen-tab-configuration-store-filename
            (insert (prin1-to-string (elscreen-get-screen-to-name-alist))))))

;; Load session including tabs
(defun session-load ()
      "Restore the elscreen tab configuration."
      (interactive)
      (if (desktop-read)
        (let ((screens (reverse
                       (read
                        (with-temp-buffer
                        (insert-file-contents elscreen-tab-configuration-store-filename)
                        (buffer-string))))))
        (while screens
        (setq screen (car (car screens)))
        (setq buffers (split-string (cdr (car screens)) ":"))
        (if (eq screen 0)
          (switch-to-buffer (car buffers))
          (elscreen-find-and-goto-by-buffer (car buffers) t t))
        (while (cdr buffers)
          (switch-to-buffer-other-window (car (cdr buffers)))
          (setq buffers (cdr buffers)))
        (setq screens (cdr screens))))))
;;save the current working window and path
(desktop-save-mode 1)
;;Set C syntax check to stroustrup with 4 as a basic offset
(setq c-default-style "stroustrup"
      c-basic-offset 4)
(setq comment-style 'extraline)
;;relative-line-numbers
;;(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
;;(add-hook 'prog-mode-hook 'line-number-mode t)
;;(add-hook 'prog-mode-hook 'column-number-mode t)



;;Evil doesnt come with ctrl+u as default so we get it now.
(setq evil-want-C-u-scroll t)


(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                        ("org" . "http://orgmode.org/elpa/")
                        ("gnu" . "http://elpa.gnu.org/packages/")))
(require 'package)
(package-initialize)

(load-theme 'suscolors t)
;;elscreen to support evil tabs
(load "elscreen")
(elscreen-start)
;;Add neotree to browse to file
(add-to-list 'load-path "~/Documents/Emacs/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

  (add-hook 'neotree-mode-hook
                        (lambda ()
                                        (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
                                        (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
                                        (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
                                        (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
;;set powerline for evil
(require 'powerline)
(powerline-center-evil-theme)

;;gdb graphical mode
(setq gdb-many-windows t)
(require 'org)
;;Use evil-magit
(require 'evil-magit)
;; Tell emacs where is your personal elisp lib dir
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; load the packaged named xyz.
;;load evil-tabs (dependency on elscreen) to have vim tabs.
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
;;Remove splash screen at startup
(setq inhibit-splash-screen t)

;;avy set-up timer
(setq avy-timeout-seconds 0.2)

(require 'helm-config)
(helm-mode 1)

(require 'evil)
;;Set the new pop up frame as evil-motion mode (we can use hjkl)
(setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
(setq evil-emacs-state-modes nil)
;;Prevent cursor from going back when leaving insert mode
(setq evil-move-cursor-back nil)
(evil-mode 1)
(semantic-mode 1)
