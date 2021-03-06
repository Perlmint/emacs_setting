(package-require
  '(typescript-mode tide web-mode)
  (lambda ()
    (add-hook
      'typescript-mode-hook
      (lambda ()
        (tide-setup)
        (flycheck-mode +1)
        (set (make-local-variable flycheck-check-syntax-automatically) '(save mode-enabled))
        (set (make-local-variable 'indent-tabs-mode) nil)
        (eldoc-mode +1)
        (company-mode-on)))

    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-hook 'web-mode-hook
      (lambda ()
        (when (string-equal "tsx" (file-name-extension buffer-file-name))
          (tide-setup)
          (flycheck-mode +1)
          (set (make-local-variable flycheck-check-syntax-automatically) '(save mode-enabled))
          (set (make-local-variable 'indent-tabs-mode) nil)
          (eldoc-mode +1)
          (company-mode-on)
          )
        )
      )
    )
  )
