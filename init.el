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
    (setq with-editor-emacsclient-executable (expand-file-name "./emacsclient.exe" invocation-directory))
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
