;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Golang
(require 'speedbar)
(speedbar-add-supported-extension ".go")

(add-hook 'go-mode-hook
          (lambda ()
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 4)))

(eval-after-load 'company
   '(add-to-list 'company-backends 'company-go))

(add-hook 'before-save-hook 'gofmt-before-save)


(require 'company-go)
(add-hook 'after-init-hook 'global-company-mode)

;; (require 'go-mode-autoloads)
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
                            (set (make-local-variable 'company-backends) '(company-go))
                            (company-mode)))
;; (add-hook 'go-mode-hook (lambda ()
;;                            (local-set-key (kbd \"M-.\") 'godef-jump)))
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Javascript

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
;; Org Mode Locations

;; Set to the location of your Org files on your local system
(setq org-directory "~/Dropbox/todo/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Dropbox/todo/org/flagged.org")

;; To execute languages in org mode
(org-babel-do-load-languages
      'org-babel-load-languages
      '((js . t)
        (shell . t)
	(sed . t)
	(awk . t)
        (C . t)
	(java . t)
	(lisp . t)
	(haskell . t)
	(sqlite . t)
	(sql . t)
	(go . t)
	(gnuplot . t)
	))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Focus writing mode (distraction-less writing)
;; Also 'center-window' mode

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
;; C#

(require 'speedbar)
(speedbar-add-supported-extension ".cs")

(add-hook 'csharp-mode-hook 'omnisharp-mode)
(setq omnisharp-curl-executable-path "/usr/bin/curl")
(setq omnisharp-server-executable-path
   "/Users/robrohan/Projects/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-omnisharp))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP Debugging

;; (setq load-path (cons "~/bin/geben-0.26" load-path))
;; (autoload 'geben "geben" "DBGp protocol frontend, a script debugger" t)
;; ;; Debug a simple PHP script
;; ;; Change the session key to any session key text you like
;; (defun my-php-debug ()
;;	"Run current PHP script for debugging with geben"
;;	(interactive)
;;	(call-interactively 'geben)
;;	(shell-command
;;		(concat "XDEBUG_CONFIG='idekey=robrohan' /Applications/MAMP/bin/php/php5.5.3/bin/php "
;;		(buffer-file-name " &"))
;;	)
;;)
;;(global-set-key [f5] 'my-php-debug)

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
 '(package-selected-packages
   (quote
    (go-autocomplete ob-go git-rebase-mode git-commit-mode)))
 '(size-indication-mode t)
 '(speedbar-show-unknown-files t)
 '(sr-speedbar-right-side nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
