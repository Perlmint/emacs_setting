(package-require
  '(blank-mode)
  (lambda ()
    (custom-set-variables
      '(blank-chars '(tabs spaces trailing lines-tail newline empty))
      '(blank-style '(mark))
      '(blank-display-mappings
        '(
          (?\   [?\x20]     [?.])        ; space - use 'space'
          (?\xA0 [?\xA4]     [?_])       ; hard space
          (?\n   [?\xB6 ?\n] [?$ ?\n])   ; end-of-
          (?\r   [?\xB6 ?\r] [?$ ?\r])
          (?\t   [?\xBB ?\t] [?\\ ?\t])  ;
          ))
      '(blank-global-modes t))
    (blank-mode)
    (global-blank-mode t)
    (global-blank-toggle-options "x")
    (global-blank-toggle-options "z")
    )
  )
