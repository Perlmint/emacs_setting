(package-require
  '(undo-tree)
  (lambda ()
    ;; undo-tree
    (global-set-key (kbd "C-x C-/") 'undo-tree-visualize)

    (global-undo-tree-mode)
    )
  )
