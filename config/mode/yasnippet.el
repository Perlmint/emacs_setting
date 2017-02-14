(package-require
  '(yasnippet)
  (lambda ()
    (yas/initialize)
    (yas/load-directory "~/.emacs.d/snippets")
    (yas-global-mode)
    )
  )
