;; python auto complete
(defun setup-python-mode ()
  (progn
    (defun append-path (a &rest arg-list)
      (dolist (b arg-list)
        (setq a (concat (file-name-as-directory a) b)))
      a)
    (defun recursive-find (path)
      (let ((tmp_path (append-path path ".pyenv" "bin" "activate")))
        (if (file-exists-p tmp_path)
            (let ((venv-location (append-path path ".pyenv")))
              (progn
                (set (make-local-variable 'python-environment-directory)
                     venv-location)
                (set (make-local-variable 'python-environment-default-root-name)
                     "")
                (if (file-exists-p
                     (append-path path ".pyenv" "bin" "jediepcserver"))
                    nil
                  (progn
                    (jedi:setup)
                    (jedi:install-server)))
                ))
          (recursive-find (file-name-directory (directory-file-name path))))
        )
      )
    (recursive-find (file-name-directory buffer-file-name))
    (jedi:setup)
    (set (make-local-variable 'company-backends)
         (cons 'company-jedi company-backends))))

(add-hook 'python-mode-hook 'setup-python-mode)
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil)
