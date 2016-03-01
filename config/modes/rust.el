(setq racer-rust-src-path (getenv "RUST_SRC_PATH"))
(add-hook 'rust-mode-hook
          (lambda ()
            (racer-mode)
            (set (make-local-variable 'company-backends)
                 (cons 'company-racer company-backends))))
(add-hook 'racer-mode-hook #'eldoc-mode)
