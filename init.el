(load "~/.emacs.d/dependency.el")

;; Package repo
(require 'package)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)
; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load "~/.emacs.d/load-directory.el")
(load "~/.emacs.d/config/common/theme.el")
(if (eq system-type 'windows-nt)
    (custom-set-variables
     '(with-editor-emacsclient-executable (expand-file-name "./emacsclient.exe" invocation-directory)))
  )
;; load non-package managed modes
(load-directory "~/.emacs.d/modes")
;; load config
(load-directory "~/.emacs.d/config")

(server-start)

;; load others
(require 'json-reformat)
(require 'android-mode)
(require 'magit-exttool)
(require 'markdown-preview-mode)
(require 'ng2-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote dark))
 '(magit-merge-arguments (quote ("--no-ff")))
 '(package-selected-packages
   (quote
    (magit yasnippet web-mode undo-tree twittering-mode tidy tide slack rust-mode python-mode omnisharp markdown-mode+ magit-popup irony git-commit editorconfig csv-mode company-racer company-quickhelp company-jedi company-go color-theme-solarized cmake-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
