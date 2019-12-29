;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C
;; brew install llvm (to get clangd) (apt-get install clangd) for c-lsp
;; See lsp-mode below


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Golang
;; go get golang.org/x/tools/cmd/goimports
;; go get golang.org/x/tools/cmd/gofmt
;; go get github.com/rogpeppe/godef
;; go get -u github.com/nsf/gocode

;; Note: _can not_ use ~ :-/
(setenv "GOPATH" "/Users/robrohan/Projects/go")

(require 'speedbar)
(speedbar-add-supported-extension ".go")

(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)
(setq lsp-ui-doc-enable nil)
(setq lsp-ui-imenu nil)
(setq lsp-ui-peek-enable nil)

(use-package lsp-mode
  :ensure t
  ;; uncomment to enable gopls http debug server
  ; :custom (lsp-gopls-server-args '("-debug" "127.0.0.1:0"))
  :commands (lsp lsp-deferred)
  :config (progn
            ;; use flycheck, not flymake
            (setq lsp-prefer-flymake nil))
  :hook (
	  (go-mode c-mode typescript-mode web-mod) . lsp)
  )

(use-package lsp-ui
   :ensure t
   :commands lsp-ui-mode
   :init
   )

(use-package flycheck
  :ensure t)

(use-package company
  :ensure t
  :config (progn
            ;; don't add any dely before trying to complete thing being typed
            ;; the call/response to gopls is asynchronous so this should have little
            ;; to no affect on edit latency
            (setq company-idle-delay .3)
            ;; start completing after a single character instead of 3
            (setq company-minimum-prefix-length 2)
            ;; align fields in completions
            (setq company-tooltip-align-annotations t)
            )
)

(use-package company-lsp
  :ensure t
  :commands company-lsp)

(defun rohan-go-mode-hook ()
  (setq-default)
  (setq tab-width 2)
  (setq standard-indent 2)
  (local-set-key (kbd "C-c m") 'gofmt)
  )

(add-hook 'go-mode-hook 'rohan-go-mode-hook)

(use-package go-mode
  :ensure t
  :bind (
         ;; If you want to switch existing go-mode bindings to use lsp-mode/gopls instead
         ;; uncomment the following lines
         ("C-c C-j" . lsp-find-definition)
         ("C-c C-d" . lsp-describe-thing-at-point)
         )
  :hook ((go-mode . lsp-deferred)
         (before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports)))

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

;; (require 'speedbar)
;; (speedbar-add-supported-extension ".cs")

;; (add-hook 'csharp-mode-hook 'omnisharp-mode)
;; (setq omnisharp-curl-executable-path "/usr/bin/curl")
;; (setq omnisharp-server-executable-path
;;    "/Users/robrohan/Projects/OmniSharpServer/OmniSharp/bin/Debug/OmniSharp.exe")

;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-omnisharp))


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
 '(line-number-mode t)
 '(menu-bar-mode t)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (auto-dim-other-buffers lsp-ui flymake flymake-go company-go helm-company go-mode helm flycheck use-package company-lsp lsp-mode auto-complete-rst magit magit-lfs ack go-autocomplete ob-go git-rebase-mode git-commit-mode)))
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
