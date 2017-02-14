;;; Package repo
(require 'package)
;;; Code:
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/")
  t)

;;; activate all the packages (in particular autoloads)
(package-initialize)
(package-refresh-contents)

(defun package-require (packages fn)
  (dolist (package packages)
    (let ((package-name (symbol-name package)))
      (unless (package-installed-p package-name)
        (package-install package)
        )
      )
    )
  (funcall fn)
  nil
  )
