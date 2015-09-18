;;; init-web.el html, css and javascript stuff

(use-package web-mode
  :ensure t
  :mode "\\.html\\'"
  :init
  (progn
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2)
    (add-hook 'web-mode-hook 'electric-pair-mode)
    (use-package emmet-mode
      :ensure t
      :init
      (add-hook 'web-mode-hook 'emmet-mode t)
      :config
      (diminish 'emmet-mode))))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :config
  (progn
    (use-package js2-refactor
      :ensure t)
    (use-package tern
      :ensure t
      :init
      (add-hook 'js2-mode-hook 'tern-mode))
    (use-package company-tern
      :ensure t
      :init
      (progn
        (add-hook 'js2-mode-hook 'company-mode)
        (add-to-list 'company-backends 'company-tern)
        ))
    (add-hook 'js2-mode-hook 'electric-pair-mode)))

(use-package jsx-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
    (autoload 'jsx-mode "jsx-mode" "JSX mode" t)
    (add-hook 'js2-mode-hook 'electric-pair-mode)))

(provide 'init-web)
