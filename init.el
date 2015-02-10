 ;; disable startup message
(setq inhibit-startup-message t)

 ;; show line number
(global-linum-mode t)

 ;; hide tool bar
(if window-system
    (tool-bar-mode -1)
)

 ;; Show paired paren
(show-paren-mode 1)

 ;; package repo
(require 'package)
;(add-to-list 'package-archives
;    '("marmalade" .
;      "http://marmalade-repo.org/packages/"))
(package-initialize)


 ;; setup load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

 ;; require all .el files in ~/.emacs.d/lisp/mode
(mapc (lambda (name)
        (require (intern (file-name-sans-extension name))))
      (directory-files "~/.emacs.d/lisp/mode" nil "\\.el$"))

 ;; git
(require 'git)
(require 'git-blame)
(require 'git-gutter)

(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

 ;; tab width
(setq default-tab-width 4)

 ;; theme
(load-theme 'solarized-dark t)

 ;; blank-mode
(require 'blank-mode)
(setq blank-chars (list 'tabs 'spaces 'trailing 'lines-tail 'empty))
(global-blank-mode 1)

(server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setup short cuts
;

 ;; disable embeded ime change
(global-set-key (kbd "S-SPC") nil)

 ;; kill rectangle
(global-set-key (kbd "C-x r k") 'kill-rectangle)

 ;; insert into rectangle
(global-set-key (kbd "C-x r i") 'string-insert-rectangle)

(require 'json-reformat)
(require 'android-mode)
