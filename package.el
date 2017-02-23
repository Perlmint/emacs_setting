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
    (unless (package-installed-p package)
      (message "%s is not installed. try install" (symbol-name package))
      (package-install package)
      )
    )
  (funcall fn)
  nil
  )
