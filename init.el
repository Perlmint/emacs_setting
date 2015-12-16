; list the packages you want
(setq package-list '(
  color-theme color-theme-solarized
  undo-tree
  tidy
  magit
  company
  jedi python python-environment company-jedi
  rust-mode ac-racer
  go-mode company-go
  cmake-mode))

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

 ;; setup load-path
(add-to-list 'load-path "~/.emacs.d/lisp")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

 ;; require all .el files in ~/.emacs.d/lisp/mode
(mapc (lambda (name)
        (require (intern (file-name-sans-extension name))))
      (append
       (directory-files "~/.emacs.d/lisp/mode" nil "\\.el$")))

 ;; change blank-mode display character
(setq blank-display-mappings
    '((?\   [?\x20]     [?.])       ; space - use 'space' character.
                                    ; NanumGothicCoding represent
                                    ; 'middle dot' as Full-width
     (?\xA0 [?\xA4]     [?_])       ; hard space
     (?\n   [?\xB6 ?\n] [?$ ?\n])   ; end-of-line
     (?\t   [?\xBB ?\t] [?\\ ?\t])  ; tab
    ))

(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

 ;; tab width
(setq default-tab-width 4)

 ;; theme
(set-frame-parameter nil 'background-mode 'dark)
(load-theme 'solarized t)

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
(defun setup-python-mode ()
  (jedi:setup)
  (company-mode)
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'setup-python-mode)

(server-start)

;;
;;
;;

(defun how-many-region (begin end regexp &optional interactive)
  "Print number of non-trivial matches for REGEXP in region.
Non-interactive arguments are Begin End Regexp"
  (interactive "r\nsHow many matches for (regexp): \np")
  (let ((count 0) opoint)
    (save-excursion
      (setq end (or end (point-max)))
      (goto-char (or begin (point)))
      (while (and (< (setq opoint (point)) end)
                  (re-search-forward regexp end t))
        (if (= opoint (point))
            (forward-char 1)
          (setq count (1+ count))))
      (if interactive (message "%d occurrences" count))
      count)))

(defun infer-indentation-style ()
  (let ((space-count (how-many-region (point-min) (point-max) "^  "))
        (tab-count (how-many-region (point-min) (point-max) "^\t")))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

(defun my-cxx-mode ()
  (setq tab-width 2)
  (setq-default indent-tabs-mode nil)
  (infer-indentation-style nil)
  (irony-mode nil))

(add-hook 'c-mode-hook 'my-cxx-mode)
(add-hook 'c++-mode-hook 'my-cxx-mode)

(defun my-ac-irony-setup ()
  ;; be cautious, if yas is not enabled before (auto-complete-mode 1), overlays
  ;; *may* persist after an expansion.
  (auto-complete-mode 1)

  (add-to-list 'ac-sources 'ac-source-irony)
  (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async))

(add-hook 'irony-mode-hook 'my-ac-irony-setup)

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
(require 'magit-exttool)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "RUST_SRC_PATH"))

(defun go-mode-setup ()
  (setq compile-command "go build -v && go test -v ./...")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (go-eldoc-setup)
 (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "M-.") 'godef-jump)
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)
  (defun append-path (a &rest arg-list)
	(dolist (b arg-list)
	  (setq a (concat (file-name-as-directory a) b)))
	a)
  (setq path (file-name-directory buffer-file-name))
  ; goautoenv
  (while path
	(setq tmp_path (append-path path ".goenv" "bin" "activate"))
	(if (file-exists-p tmp_path)
		(progn
		  (make-local-variable 'goautoenv)
		  (setq goautoenv
				(with-temp-buffer
				  (insert-file-contents tmp_path)
				  (substring (buffer-string)
							 (+ 7 (string-match "^GOPATH=.+$" (buffer-string)))
							 (match-end 0))))
		  (add-function :before (symbol-function 'company-go--invoke-autocomplete) #'goautoenv-invoke-autocomplete)
		  (setq path nil))
	  (setq path (file-name-directory (directory-file-name path))))
	))
(add-hook 'go-mode-hook 'go-mode-setup)

(require 'auto-complete-config)
(require 'go-autocomplete)
(defun goautoenv-invoke-autocomplete ()
  (setenv "GOPATH" goautoenv)
  )

(setq racer-rust-src-path (getenv "RUST_SRC_PATH"))
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common) ;
(setq company-tooltip-align-annotations t)

(global-undo-tree-mode)
