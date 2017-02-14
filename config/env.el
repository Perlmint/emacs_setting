(package-require
  '(exec-path-from-shell)
  ;; for osx - change PATH
  (lambda ()
    (when (memq window-system '(mac ns))
      (exec-path-from-shell-initialize))
    )
  )
