(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(setq lisp-indent-function 'common-lisp-indent-function)
;;Add SBCL to slime
(setq inferior-lisp-program "/usr/bin/sbcl")
;;Add quicklisp to slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
(provide 'init-slime)
