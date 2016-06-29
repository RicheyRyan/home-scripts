;;;; package --- My init.el

;;;; Commentary:

;;;; Code:
(when (>= emacs-major-version 24)
  ;;;; Require package repos
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

  ;; store all backup and autosave files in the tmp dir
  (defvar backup-directory-alist
    `((".*" . ,temporary-file-directory)))
  (defvar auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))
  (setq create-lockfiles nil)

  ;;;; Setup company mode
  (add-hook 'after-init-hook 'global-company-mode)
  (defvar company-dabbrev-downcase nil)
  
  ;;;; Enable line numbers
  (global-linum-mode t)

  ;;;; Set colour scheme
  (load-theme 'solarized-light t)

  ;;;; No tabs
  (setq-default indent-tabs-mode nil)

  ;;;; Add beautifier to path
  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/"))
  (setq exec-path (append exec-path '("/usr/local/bin/")))

  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/css-beautify"))
  (setq exec-path (append exec-path '("/usr/local/bin/css-beautify")))

  (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin/html-beautify"))
  (setq exec-path (append exec-path '("/usr/local/bin/html-beautify")))

  ;;;; Add Go utilities to path
  (setenv "GOPATH" (concat (getenv "GOPATH") ":/Users/richeyryan/go"))
  (setq exec-path (append exec-path '("/Users/richeyryan/go")))

  (setenv "GOROOT" (concat (getenv "GOROOT") ":/usr/local/opt/go/libexec/bin"))
  (setq exec-path (append exec-path '("/usr/local/opt/go/libexec/bin")))

  (defun go-mode-setup ()
    (go-eldoc-setup)
    (defvar gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save))
  (add-hook 'go-mode-hook 'go-mode-setup)

  ;;;; Make m-3 output # on OSX
  (when (eq system-type 'darwin)
    (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#"))))

  ;;;; Disable the damn alarms!
  (setq ring-bell-function 'ignore)

  ;;;; Overwrite active region
  (delete-selection-mode 1)

  ;;;; Setup web mode
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.swig?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ss?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.sass?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.scss?\\'" . web-mode))
  
  (add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-css-indent-offset 2)


  ;;;; Enable paredit mode
  (defun my-paredit-nonlisp ()
    "Turn on paredit mode for non-lisps."
    (interactive)
    (set (defvar 'paredit-space-for-delimiter-predicates)
         '((lambda (endp delimiter) nil)))
    (paredit-mode 1))
  
  ;;;; Setup tern
  ;; (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  ;; (eval-after-load 'tern
  ;;   '(progn
  ;;      (require 'tern-auto-complete)
  ;;      (tern-ac-setup)))
  
  ;;;; Setup smex
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; Old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(paradox-github-token t))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )

  ;;;; Wanderlust setup
  (autoload 'wl "wl" "Wanderlust" t)

  (defun indent-buffer ()
    (interactive)
    (save-excursion
      (indent-region (point-min) (point-max) nil)))
  
  ;;;; JS linting
  (defun indent-js-buffer ()
    "Indents an entire buffer using the default intenting scheme."
    (indent-buffer)
    (interactive)
    (point-to-register 'o)
    (delete-trailing-whitespace)
    (delete-trailing-lines)
    (untabify (point-min) (point-max))
    (jump-to-register 'o))                  

  (eval-after-load 'js2-mode
    '(add-hook 'js2-mode-hook
               (lambda ()
                 (add-hook 'before-save-hook 'indent-js-buffer t t))))

;;;; Autocomplete
  (ac-config-default))

;;;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;;;; Clojure mode
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'smartparens-strict-mode)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)

;;;; Disable tern files
;;;; (setq tern-command (append tern-command '("--no-port-file")))

;;; init.el ends here
