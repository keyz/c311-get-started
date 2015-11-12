;; part of https://github.com/keyanzhang/c311-get-started

;; by default, paredit will be diabled.
;; we highly recommend activating paredit for Scheme/Racket/Lisp modes,
;; but we understand that it could take a while to get used to it.

;; please read http://danmidwood.com/content/2014/11/21/animated-paredit.html first;
;; when you are ready, change the following `nil` to `t` to activate paredit.

(setq paredit-enabled nil) ;; @CHANGEME


;; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(setq pkg-ls
      '(adaptive-wrap
        company
        exec-path-from-shell
        helm
        paredit
        racket-mode
        rainbow-delimiters))

(add-to-list 'package-pinned-packages '(company . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(exec-path-from-shell . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(helm . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(paredit . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(racket-mode . "melpa") t)
(add-to-list 'package-pinned-packages '(rainbow-delimiters . "melpa-stable") t)

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(dolist (p pkg-ls)
  (unless (package-installed-p p)
    (package-install p)))

(let ((default-directory "~/.emacs.d/elpa"))
  (normal-top-level-add-subdirs-to-load-path))


;; get $PATH from shell
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; paredit
(defun enable-nospace-curly-paredit-mode ()
  "no automatic space."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

(if paredit-enabled
    (add-hook 'racket-mode-hook 'enable-nospace-curly-paredit-mode))


;; rainbow-delimiters-mode
(show-paren-mode 1)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)


;; racket-mode
(eval-after-load "racket-mode"
  '(define-key racket-mode-map (kbd "M-RET") 'racket-run))

(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

(mapc (lambda (pr) (put (car pr) 'racket-indent-function (cdr pr)))
      '((conde . 0)
        (fresh . 1)
        (run . 1)
        (run* . 1)
        (run . 2)))


;; company-mode
(add-hook 'after-init-hook 'global-company-mode)


;; linum-mode
(global-linum-mode 1)
(setq linum-format 'dynamic)


;; helm-mode
(helm-mode 1)


;; recentf-mode
(recentf-mode 1)
(setq recentf-max-menu-items 150)
(global-set-key "\C-x\ \C-r" 'helm-recentf)


;; some weird emacs behaviors
(setq inhibit-splash-screen t
      initial-scratch-message nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq bkup-dir "~/.emacs.d/bkup/") ;; no more temp files in the folder

(setq backup-directory-alist
      `((".*" . ,bkup-dir)))
(setq auto-save-file-name-transforms
      `((".*" ,bkup-dir t)))

(setq-default indent-tabs-mode nil)


;; visual-line-mode, adaptive-wrap-prefix-mode
(global-visual-line-mode 1)
(when (fboundp 'adaptive-wrap-prefix-mode)
  (defun my-activate-adaptive-wrap-prefix-mode ()
    (adaptive-wrap-prefix-mode (if visual-line-mode 1 -1)))
  (add-hook 'visual-line-mode-hook 'my-activate-adaptive-wrap-prefix-mode))

(add-hook 'minibuffer-setup-hook
          (lambda ()
            (visual-line-mode -1)))


;; no tool bar
(tool-bar-mode -1)


;; cursor-type
(setq-default cursor-type '(bar . 1))


;; mac default shortcuts
(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper x)] 'kill-region)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)


;; mac option key as meta
(defun mac-switch-meta nil
  "switch meta between Option and Command"
  (interactive)
  (if (eq mac-option-modifier nil)
      (progn
        (setq mac-option-modifier 'meta)
        (setq mac-command-modifier 'hyper))
    (progn
      (setq mac-option-modifier nil)
      (setq mac-command-modifier 'meta))))

(defun mac-set-option-as-meta nil
  "set Option key as meta"
  (interactive)
  (progn
    (setq mac-option-modifier 'meta)
    (setq mac-command-modifier 'hyper)))

(mac-set-option-as-meta)
