(package-initialize)

(setq custom-file "~/.emacs.d/rohan/custom.el")
(load custom-file 'no-error)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)                    ; Don't show splash
(fset 'yes-or-no-p 'y-or-n-p)                       ; y/n vs. yes/no
(global-linum-mode 1)                               ; line numbers
(setq visual-bell t)                                ; quiet!
(show-paren-mode t)                                 ; Match parent
(setq backup-directory-alist                        ;
      '(("." . "~/.emacs.d/backups")))              ; Move those stupid backup files
(add-hook 'before-save-hook                         ;
	  (lambda () (delete-trailing-whitespace))) ; Remove EOL whitespace


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; My Keys

(global-set-key (kbd "C-l")     'goto-line)         ; jump to line number
(global-set-key (kbd "C-c o")   'occur)             ; like ctrl+s but shows all matches
(global-set-key (kbd "C-c C-f") 'ack)               ; like grep for the current dir
       					            ; need to install OSs ack brew, apt-get, etc
(global-set-key (kbd "s-;") 'comment-region)
(global-set-key (kbd "C-c s-;") 'uncomment-region)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'helm-config)
(helm-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Assign some modes to file extensions

(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq company-tooltip-limit 15)                      ; bigger popup window
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
;; (setq company-minimum-prefix-length 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "PATH" (concat (getenv "PATH") ":~/Projects/go/bin/:/usr/local/go/bin:/usr/local/bin"))
(setq exec-path (append exec-path '(":~/Projects/go/bin/:/usr/local/go/bin:/usr/local/bin")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Theme stuff

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" default)))
 '(fci-rule-color "#383838")
 '(global-company-mode t)
 '(menu-bar-mode t)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(size-indication-mode t)
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil)
 '(line-number-mode t)
 '(column-number-mode t)
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
