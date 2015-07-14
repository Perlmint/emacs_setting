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

 ;; change blank-mode display character
(setq blank-display-mappings
    '((?\   [?\x20]     [?.])       ; space - use 'space' character.
                                    ; NanumGothicCoding represent
                                    ; 'middle dot' as Full-width
     (?\xA0 [?\xA4]     [?_])       ; hard space
     (?\n   [?\xB6 ?\n] [?$ ?\n])   ; end-of-line
     (?\t   [?\xBB ?\t] [?\\ ?\t])  ; tab
    ))

 ;; Package repo
(require 'package)
(add-to-list 'package-archives
    '("melpa" . "http://melpa.org/packages/") t)
;    '("marmalade" .
;      "http://marmalade-repo.org/packages/") t)
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

 ;; tidy path
(if (eq system-type 'windows-nt)
  (setq tidy-shell-command
    (expand-file-name "~/.emacs.d/others/bin/win/tidy.exe"))
)

 ;; beautify-xml
(defun beautify-xml-region (begin end)
  (interactive "r")
  (save-excursion
      (nxml-mode)
      (goto-char begin)
      (while (search-forward-regexp "\>[[:blank:]]*\<" nil t) 
        (backward-char) (insert "\n"))
      (indent-region begin end)))

 ;; set default-font
(set-default-font "NanumGothicCoding-12")

 ;; drag-and-drop just append buffer
(setq ns-pop-up-frames nil)

 ;; python auto complete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

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
