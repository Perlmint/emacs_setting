(package-require
  '(blank-mode)
  (lambda ()
    (setq blank-chars (list 'tabs 'spaces 'trailing 'lines-tail 'empty))
    (blank-mode)
    (global-blank-mode)

    ;; change blank-mode display character
    (setq blank-display-mappings
      '((?\   [?\x20]     [?.])        ; space - use 'space' character.
         (?\xA0 [?\xA4]     [?_])       ; hard space
         (?\n   [?\xB6 ?\n] [?$ ?\n])   ; end-of-line
         (?\r   [?\xB6 ?\r] [?$ ?\r])
         (?\t   [?\xBB ?\t] [?\\ ?\t])  ; tab
         ))
    )
  )
