(package-require
  '(magit)
  (lambda ()
    (add-hook
      'magit-status-mode-hook
      (lambda ()
        (setq coding-system-for-read 'utf-8)
        (setq coding-system-for-write 'utf-8))
      )

    (custom-set-variables
      '(magit-merge-arguments (quote ("--no-ff"))))
    )
  )
