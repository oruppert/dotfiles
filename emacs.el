;; * Package

(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(menu-bar-mode -1)

;; * Look and Feel

;; Note!  Everything that could be set in ~/.Xdefaults,
;; is set in ~/.Xdefaults.

;; Show parens.
(show-paren-mode 1)

;; Show time.
(display-time-mode 1)

;; No fringe.
(fringe-mode -1)

;; Block ads.
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message "oruppert")

;; Military time.
(setq display-time-24hr-format 1)

;; In germany, the first day of week is monday(1).
(setq calendar-week-start-day 1)

;; Stop cluttering my filesystem.
(setq make-backup-files nil)

;; Focus follows mouse.
(setq mouse-autoselect-window t)

;; Disable random pasting.
(setq mouse-yank-at-point t)

;; Kill (comint) buffers without asking for permission.
(setq kill-buffer-query-functions nil)

; no longer needed (using ggtags now)
;; Reload tags without prompting.
(setq tags-revert-without-query 1)
;; Always use identifier at point.
;(setq xref-prompt-for-identifier nil)

;; From emacswiki.org: group directories first
;; Change on the fly via C-u s
(setq dired-listing-switches "-lav --group-directories-first")

;; * Hooks

(add-hook 'nxml-mode-hook
  (lambda ()
    (setq show-trailing-whitespace 1)))

(add-hook 'org-mode-hook
  (lambda ()
    (setq show-trailing-whitespace 1)))



(defun my-c-mode-hook ()
  ;; Use tabs.
  (c-set-style "linux")
  ;; Show trailing whitespace is not set globally, because it
  ;; interferes with ielm and slime-repl.
  (setq show-trailing-whitespace 1)
  ;; The default binding is M-Tab, which my window manager
  ;; uses for screen switching.  So use Sime key bindings.
  (local-set-key (kbd "C-c C-i") 'complete-symbol)
  ;; Use slime compile-file keybinding for recompile.
  ;; Set or edit the compile-command by typing
  ;; M-x compile and recompile via C-c C-k.
  (local-set-key (kbd "C-c C-k") 'recompile)
  ;; enable ggtags
;;  (ggtags-mode 1)
;;  (define-key ggtags-navigation-map 
;;    (kbd "C-c C-k") 'recompile)
)


(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(add-hook 'java-mode-hook 'my-c-mode-hook)

(defun my-lisp-mode-hook ()
  (setq show-trailing-whitespace 1))

(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)

(defun my-javascript-mode-hook ()
  (setq js-indent-level 8)
  (setq show-trailing-whitespace 1))

(add-hook 'js-mode-hook 'my-javascript-mode-hook)

;; * Slime

;; Currently I am using sbcl most of the time.
;; But you can specify the inferior-lisp-program
;; interactively by typing M-1 M-x slime.  Emacs
;; will prompt you for the program name.
(setq inferior-lisp-program "sbcl")

;; Slime with all the bells and whistles.
(setq slime-contribs '(slime-fancy))

;; Add brackets to the syntax table (for clsql.)
(modify-syntax-entry ?\[ "(]" lisp-mode-syntax-table)
(modify-syntax-entry ?\] ")[" lisp-mode-syntax-table)

;; Use C-z for slime-selector.
;; Bonus: By setting this globally, we stop
;; emacs from suspending.
(global-set-key (kbd "C-z") 'slime-selector)

;; Use slime to switch between java files.
(require 'slime)
(def-slime-selector-method ?j
  "most recently visited java-mode buffer."
  (slime-recently-visited-buffer 'java-mode))


;; * Wiki

;;(load "~/src/wiki/wiki.el")


;; * Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-chromium-arguments (quote ("-incognito")))
 '(package-selected-packages
   (quote
    (go-mode outshine skewer-mode slime gnu-elpa-keyring-update))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; outline

(defun outline-left ()
  (interactive)
  (if (outline-on-heading-p)
      (outline-hide-subtree)
    (outline-previous-heading)))

(defun outline-right ()
  (interactive)
  (if (outline-on-heading-p)
      (outline-show-subtree)
      (outline-next-heading)))

(defun set-outline-regex (regexp)
  (interactive
   (list
    (read-string "outline-regexp: ")))
  (setq outline-regexp regexp))



;;;; grepping

(setq grep-use-null-device nil)
(setq grep-command "git --no-pager grep -n -e ")






(define-key outline-minor-mode-map (kbd "M-<up>") 'outline-previous-heading)
(define-key outline-minor-mode-map (kbd "M-<down>") 'outline-next-heading)
(define-key outline-minor-mode-map (kbd "M-<left>") 'outline-left)
(define-key outline-minor-mode-map (kbd "M-<right>") 'outline-right)

;;(let ((map outline-minor-mode-map)) 
;;  (define-key map (kbd "M-<left>") 'outline-hide-more)
;;  (define-key map (kbd "M-<right>") 'outline-show-more)
;;  (define-key map (kbd "M-<up>") 'outline-previous-visible-heading)
;;  (define-key map (kbd "M-<down>") 'outline-next-visible-heading))
