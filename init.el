(load (concat user-emacs-directory "load-directory.el"))
(load (concat user-emacs-directory "package.el"))
;; load config
(load-directory (concat user-emacs-directory "./config"))

(server-start)
