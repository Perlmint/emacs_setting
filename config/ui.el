;;; Setup UI
(if window-system
  ;; hide tool bar
  (tool-bar-mode -1)
  )

;; drag-and-drop just append buffer
(setq ns-pop-up-frames nil)

;; disable startup message
(setq inhibit-startup-message t)

;; show line number
(global-linum-mode t)
;; show column number
(column-number-mode t)

;; Show paired paren
(show-paren-mode 1)
