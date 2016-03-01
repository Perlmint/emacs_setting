;; python auto complete
(defun setup-python-mode ()
  (progn
    (jedi:setup)
    (set (make-local-variable 'company-backends)
         (cons 'company-jedi company-backends))))

(add-hook 'python-mode-hook 'setup-python-mode)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil)
