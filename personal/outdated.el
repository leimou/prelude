;; Go Mode
;; -----------------------------------------------------------------------------
;; (require 'go-mode-autoloads)
;; (require 'go-autocomplete)
;; (require 'auto-complete-config)


;; goimport and go oracle integration.
;; (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
;; (defun my-go-mode-hook ()
;; 	;; Use goimports instand of go-fmt
;; 	(setq gofmt-command "goimports")
;; 	;; Call gofmt before saving
;; 	(add-hook 'before-save-hook 'gofmt-before-save)
;; 	;; Customize compile command to run go build
;; 	(if (not (string-match "go" compile-command))
;; 			(set (make-local-variable 'compile-command)
;; 					 "go generate && go build -v"))
;; 	;; Godef jump key binding
;; 	(local-set-key (kbd "M-.") 'godef-jump)
;; 	(local-set-key (kbd "M-,") 'pop-tag-mark))

;; (add-hook 'go-mode-hook 'my-go-mode-hook)


;; Clang autocomplete
;; -----------------------------------------------------------------------------
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/personal/auto-complete/ac-dict")
;; (ac-config-default)
;; (define-key ac-completing-map (kbd "RET") 'nil)
;; (define-key ac-completing-map (kbd "TAB") 'ac-complete)
;; (set-default 'ac-sources
;;              '(ac-source-semantic
;;                ac-source-yasnippet
;;                ac-source-abbrev
;;                ac-source-words-in-buffer
;;                ac-source-words-in-all-buffer
;;                ac-source-imenu
;;                ac-source-files-in-current-dir
;;                ac-source-filename))


;; Toggle window dedication
;; http://stackoverflow.com/questions/43765/pin-emacs-buffers-to-windows-for-cscope
;; -----------------------------------------------------------------------------
;; (defun toggle-window-dedicated ()
;;   "Toggle whether the current active window is dedicated or not"
;;   (interactive)
;;   (message
;;    (if (let (window (get-buffer-window (current-buffer)))
;;          (set-window-dedicated-p window
;;                                  (not (window-dedicated-p window))))
;;        "Window '%s' is dedicated"
;;      "Window '%s' is normal")
;;    (current-buffer)))
;; (global-set-key (kbd "<f11>") 'toggle-window-dedicated)

;; (require 'llvm-mode)
;; (require 'tablegen-mode)
;; (require 'doxymacs)   ;; Using doxygen style comments within emacs.
;; (defun my-doxymacs-font-lock-hook ()
;;   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
;;       (doxymacs-font-lock)))
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
;; Doxygen default bindings:
;; C-c d ? will look up documentation for the symbol under the point.
;; C-c d r will rescan your Doxygen tags file.
;; C-c d f will insert a Doxygen comment for the next function.
;; C-c d i will insert a Doxygen comment for the current file.
;; C-c d ; will insert a Doxygen comment for a member variable on the current line (like M-;).
;; C-c d m will insert a blank multi-line Doxygen comment.
;; C-c d s will insert a blank single-line Doxygen comment.
;; C-c d @ will insert grouping comments around the current region.
