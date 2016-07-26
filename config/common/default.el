;; disable startup message
(setq inhibit-startup-message t)

;; show line number
(global-linum-mode t)
;; show column number
(column-number-mode t)

;; Show paired paren
(show-paren-mode 1)

;; tab width
(setq default-tab-width 4)

;; indent with space
(setq indent-tabs-mode nil)

;; for osx
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
