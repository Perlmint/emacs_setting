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
