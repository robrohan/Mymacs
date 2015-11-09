;(global-set-key (kbd "TAB") 'self-insert-command)
;(global-set-key (kbd "TAB") 'tab-to-tab-stop)
;(setq-default tab-width 4)
;(setq-default tab-stop-list (list 3 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108))
;;(load-theme 'zenburn t)
(package-initialize)

(load-theme 'wombat t)
(setq prelude-whitespace nil)

;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/todo/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/todo/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(menu-bar-mode -1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons "~/bin/geben-0.26" load-path))
(autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)
;; Debug a simple PHP script
;; Change the session key to any session key text you like
(defun my-php-debug ()
	"Run current PHP script for debugging with geben"
	(interactive)
	(call-interactively 'geben)
	(shell-command
		(concat "XDEBUG_CONFIG='idekey=robrohan' /Applications/MAMP/bin/php/php5.5.3/bin/php "
		(buffer-file-name " &"))
	)
)
(global-set-key [f5] 'my-php-debug)
(global-visual-line-mode t)
(setq-default word-wrap t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add left and right margins, when file is markdown
(defun center-window (window) ""
       (let* ((current-extension (file-name-extension (or (buffer-file-name) "foo.unknown")))
              (max-text-width 120)
              (margin (max 0 (/ (- (window-width window) max-text-width) 2))))
         (if (and (not (string= current-extension "md"))
                  (not (string= current-extension "markdown")))
             ;; Do nothing if this isn't an .md or .markdown file.
             ()
           (set-window-margins window margin margin))))

;; Adjust margins of all windows.
(defun center-windows () ""
       (walk-windows (lambda (window) (center-window window)) nil 1))

;; Listen to window changes.
(add-hook 'window-configuration-change-hook 'center-windows)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(setq company-tooltip-limit 20)                      ; bigger popup window
;(setq company-echo-delay 0)                          ; remove annoying blinking

;;(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
;;(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

;;(add-hook 'csharp-mode-hook 'omnisharp-mode)
;;(setq omnisharp-curl-executable-path "/usr/bin/curl")
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-omnisharp))
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-go))
(add-hook 'after-init-hook 'global-company-mode)

(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.cfml$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cfm$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cfc$" . csharp-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tern
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(add-hook 'js-mode-hook 'js2-minor-mode)
;(add-hook 'js2-mode-hook 'ac-js2-mode)

(add-hook 'js-mode-hook (lambda () (tern-mode 1)))
(eval-after-load 'tern
  '(progn
     (require 'tern-auto-complete)
     (tern-ac-setup)))
(add-hook 'js-mode-hook (lambda () (auto-complete-mode 1)))

(require 'flycheck)
(add-hook 'js-mode-hook
          (lambda () (flycheck-mode t)))

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))

(flycheck-define-checker jsxhint-checker
  "A JSX syntax and style checker based on JSXHint."

  :command ("jsxhint" source)
  :error-patterns
  ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
  :modes (web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              ;; enable flycheck
              (flycheck-select-checker 'jsxhint-checker)
              (flycheck-mode))))

;; (add-hook 'jsx-mode-hook (lambda () (tern-mode 1)))
;; (add-hook 'jsx-mode-hook (lambda () (auto-complete-mode 1)))

(add-hook 'web-mode-hook (lambda () (tern-mode 1)))
(add-hook 'web-mode-hook (lambda () (auto-complete-mode 1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'speedbar)
(speedbar-add-supported-extension ".cs")

(add-hook 'go-mode-hook
          (lambda ()
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 4)))

(add-hook 'before-save-hook 'gofmt-before-save)

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
 '(haskell-literate-default nil)
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indent turn-on-haskell-indentation turn-on-haskell-simple-indent)))
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/Dropbox/todo/org/index.org")))
 '(size-indication-mode t)
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

