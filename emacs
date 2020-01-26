;; * Package

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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

;; Reload tags without prompting.
(setq tags-revert-without-query 1)

;; * Hooks

(defun my-c-mode-hook ()
  ;; Use tabs.
  (c-set-style "linux")
  ;; Show trailing whitespace is not set globally, because it
  ;; interferes with ielm and slime-repl.
  (setq show-trailing-whitespace 1)
  ;; The default binding is M-Tab, which my window manager
  ;; uses for screen switching.  So use Sime key bindings.
  (local-set-key (kbd "C-c C-i") 'complete-tag)
  ;; Use slime compile-file keybinding for recompile.
  ;; Set or edit the compile-command by typing
  ;; M-x compile and recompile via C-c C-k.
  (local-set-key (kbd "C-c C-k") 'recompile))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
(add-hook 'java-mode-hook 'my-c-mode-hook)

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

;; * Custom

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (slime outshine))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
