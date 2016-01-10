(defun cs-mode ()
  (setq tab-width 2)
  (setq-default indent-tabs-mode nil)
  (infer-indentation-style))
(add-hook 'csharp-mode-hook 'cs-mode)
(add-hook 'omnisharp-mode-hook #'company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-omnisharp))
(setq omnisharp-server-executable-path
      "~/.emacs.d/others/bin/common/OmniSharp.exe")
