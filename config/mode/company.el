(package-require
  '(company company-quickhelp)
  (lambda ()
    (global-set-key (kbd "TAB") #'company-indent-or-complete-common) ;
    (setq company-tooltip-align-annotations t)
    (company-quickhelp-mode 1)
    (global-company-mode)
    )
  )
