(package-require
  '(color-theme color-theme-solarized)
  (lambda ()
    (set-frame-parameter nil 'background-mode 'dark)
    (custom-set-variables
      '(frame-background-mode (quote dark)))
    (load-theme 'solarized t)

    (defun font-existsp (font)
      (if (null (x-list-fonts font))
        nil font))
    (defun font-candidate (&rest fonts)
      (when fonts
        (font-existsp (car fonts))
        (apply 'font-candidate (cdr fonts))
        )
      )

    ;; set default-font
    ;; https://github.com/googlei18n/noto-ckj
    (set-default-font
      (font-candidate
        "Noto Sans Mono CJK KR-10"
        "Noto Sans Mono CJK KR Regular-10"))
    )
  )
