(add-hook 'magit-status-mode-hook
          (lambda ()
            (setq coding-system-for-read 'utf-8)
            (setq coding-system-for-write 'utf-8)))
