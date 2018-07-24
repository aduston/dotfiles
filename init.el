;; custom variables
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

(setq package-selected-packages
      (append package-selected-packages
	      '(dockerfile-mode
		;; ensime
                graphql-mode
		js2-mode
		json-mode
		markdown-mode
		markdown-toc
		pug-mode
                rjsx-mode
		yaml-mode)))

(package-install-selected-packages)

(windmove-default-keybindings)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(show-paren-mode 1)

(add-to-list 'auto-mode-alist '("\\.js$'" . js2-mode))
(add-to-list 'auto-mode-alist '("components\\/.*\\.js$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("containers\\/.*\\.js$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.gs$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc$" . shell-script-mode))

(set-face-foreground 'minibuffer-prompt "color-49")

(setq-default indent-tabs-mode nil)
(setq pug-tab-width 2)
(add-hook 'text-mode-hook (lambda () (setq tab-width 2)))

(defun shell-same-window-advice (orig-fn &optional buffer)
  "Advice to make `shell' reuse the current window.

Intended as :around advice."
  (let* ((buffer-regexp
          (regexp-quote
           (cond ((bufferp buffer)  (buffer-name buffer))
                 ((stringp buffer)  buffer)
                 (:else             "*shell*"))))
         (display-buffer-alist
          (cons `(,buffer-regexp display-buffer-same-window)
                display-buffer-alist)))
    (funcall orig-fn buffer)))

(advice-add 'shell :around #'shell-same-window-advice)
