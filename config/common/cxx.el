(defun my-cxx-mode ()
  (setq tab-width 2)
  (setq-default indent-tabs-mode nil)
  (infer-indentation-style)
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
