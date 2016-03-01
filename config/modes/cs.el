(defun cs-mode ()
  (setq tab-width 2)
  (setq-default indent-tabs-mode nil)
  (infer-indentation-style)
  (set (make-local-variable 'company-backends)
       (const 'company-omnisharp company-backends)))
(add-hook 'csharp-mode-hook 'cs-mode)
(setq omnisharp-server-executable-path
      "~/.emacs.d/others/bin/common/OmniSharp.exe")
