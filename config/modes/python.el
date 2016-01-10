;; python auto complete
(defun setup-python-mode ()
  (jedi:setup)
  (company-mode)
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'setup-python-mode)
