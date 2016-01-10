;; blank-mode
(require 'blank-mode)
(setq blank-chars (list 'tabs 'spaces 'trailing 'lines-tail 'empty))
(global-blank-mode 1)

;; change blank-mode display character
(setq blank-display-mappings
      '((?\   [?\x20]     [?.])        ; space - use 'space' character.
        (?\xA0 [?\xA4]     [?_])       ; hard space
        (?\n   [?\xB6 ?\n] [?$ ?\n])   ; end-of-line
        (?\t   [?\xBB ?\t] [?\\ ?\t])  ; tab
        ))
