;; Load Paths
;; -----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/personal")
(add-to-list 'load-path "~/.emacs.d/personal/auto-complete")
(add-to-list 'load-path "~/.emacs.d/personal/go-mode")
(add-to-list 'load-path "~/.emacs.d/personal/go-code/emacs")
(add-to-list 'load-path "~/.emacs.d/personal/popup")
(add-to-list 'load-path "~/.emacs.d/personal/fuzzy")

;; Open header file in c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; General Settings
;; -----------------------------------------------------------------------------
(setq make-backup-files nil)          ;; Stop create backup~ files
(setq auto-save-default nil)          ;; Stop create #autosave# files
(fset 'yes-or-no-p 'y-or-n-p)         ;; Using y/n instead of yes/no
(setq kill-whole-line t)              ;; Kill a whole line, including the ending '\n'.
(setq enable-recursive-minibuffers t) ;; Using the mini-buffer recursively.
(setq frame-title-format "%b@%f")     ;; Buffer name @ File location
(global-visual-line-mode 1)           ;; Have lines soft wrapped at word boundary.


(require 'protobuf-mode)
(require 'xcscope)    ;; Cscope
(require 'win-switch) ;; Win-switch

;; Go Mode
;; -----------------------------------------------------------------------------
(require 'go-mode-autoloads)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;; goimport and go oracle integration.
(load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
(defun my-go-mode-hook ()
	;; Use goimports instand of go-fmt
	(setq gofmt-command "goimports")
	;; Call gofmt before saving
	(add-hook 'before-save-hook 'gofmt-before-save)
	;; Customize compile command to run go build
	(if (not (string-match "go" compile-command))
			(set (make-local-variable 'compile-command)
					 "go generate && go build -v"))
	;; Godef jump key binding
	(local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; Yasnippet Settings
;; -----------------------------------------------------------------------------
;; Add yasnippet to prelude's required package list.
(prelude-require-package 'yasnippet)

;; Don't clean whitespace upon save.
;; (setq prelude-clean-whitespace-on-save nil)

(defvar personal-snippets-dir (expand-file-name "snippets" prelude-personal-dir)
  "This folder houses additional yasnippet bundles added by the users.")

;; load yasnippet
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs personal-snippets-dir)
(yas-global-mode 1)

;; term-mode does not play well with yasnippet
(add-hook 'term-mode-hook (lambda ()
                            (yas-minor-mode -1)))

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

;; Auto complete clang async
;; -----------------------------------------------------------------------------
;; (require 'auto-complete-clang-async)

;; (setq ac-clang-cflags
;;       (mapcar (lambda (item)(concat "-I" item))
;;       (split-string
;;        "/usr/lib/gcc/i686-linux-gnu/4.6/include
;; /usr/local/include
;; /usr/lib/gcc/i686-linux-gnu/4.6/include-fixed
;; /usr/include/i386-linux-gnu
;; /usr/include
;; ")))

;; (defun ac-cc-mode-setup ()
;;   (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
;;   (setq ac-sources '(ac-source-clang-async))
;;   (ac-clang-launch-completion-process)
;;   )

;; (defun my-ac-config ()
;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))

;; (my-ac-config)

;; Org mode: http://stackoverflow.com/a/10643120/504646
;; -----------------------------------------------------------------------------
(setq org-src-fontify-natively t)
;; -----------------------------------------------------------------------------

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

;; CC-mode customization
;; ================================================================
(require 'cc-mode)

;; Max 80 cols per line, indent by two spaces, no tabs.
;; Apparently, this does not affect tabs in Makefiles.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c++-indent-level 2)
 '(c-basic-offset 2)
 '(tab-width 2)
 '(fill-column 80)
 '(indent-tabs-mode t))

;; Alternative to setting the global style.  Only files with "llvm" in
;; their names will automatically set to the llvm.org coding style.
(c-add-style "llvm.org"
             '((fill-column . 80)
               (c++-indent-level . 2)
               (c-basic-offset . 2)
               (tab-width . 2)
               (indent-tabs-mode . t)
               (c-offsets-alist . ((innamespace 0)))))

(add-hook 'c-mode-hook
          (function
           (lambda nil
             (if (string-match "llvm" buffer-file-name)
                 (progn
                   (c-set-style "llvm.org")
                   )
               ))))

(add-hook 'c++-mode-hook
          (function
           (lambda nil
             (if (string-match "llvm" buffer-file-name)
                 (progn
                   (c-set-style "llvm.org")
                   )
               ))))

(defun my-c-initialization-hook ()
  ;; (define-key c-mode-base-map "\C-c\C-v" 'uncomment-region)
  (define-key c-mode-base-map "\C-m" 'c-context-line-break)
  (define-key c-mode-base-map "\C-c\C-g" 'goto-line)
  (define-key c-mode-base-map "\M-/" 'auto-complete)
  (define-key c-mode-base-map [f6] 'semantic-ia-fast-jump))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(defun c-key-customization ()
  (define-key c-mode-base-map "\M-q" 'rebox-comment))

;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)
;; (add-hook 'c-mode-common-hook 'c-key-customization)
;; (add-hook 'c-mode-common-hook 'doxymacs-mode)

;; Display Line Number by default in the following modes
(add-hook 'c-mode-common-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'fundamental-mode 'linum-mode)
(add-hook 'tablegen-mode-hook 'linum-mode)
(add-hook 'llvm-mode-hook 'linum-mode)
(add-hook 'org-mode-hook 'linum-mode)
(add-hook 'asm-mode-hook 'linum-mode)
(add-hook 'ld-script-mode-hook 'linum-mode)

;; Rebox comments
(autoload 'rebox-comment "rebox" nil t)
(autoload 'rebox-region "rebox" nil t)

;; Enable orgtbl minor mode in c-mode and text-mode
(add-hook 'c-mode-common-hook 'turn-on-orgtbl)

;; Win-switch
(win-switch-setup-keys-ijkl "\C-xo")

;; GUD
(defun gud-key-customizations ()
  (define-key gud-mode-map (kbd "<f5>") 'gdb-many-windows))
(add-hook 'gdb-mode-hook 'gud-key-customizations)

;; General Settings
;; ================================================================
(setq user-mail-address "lei.mou@hengjiatech.com")
(setq user-full-name "Lei Mou")

;; reload-dot-emacs
;; http://snipplr.com/view/18681/reloaddotemacs/
(defun reload-dot-emacs ()
  "Save the .emacs buffer if needed, then reload .emacs."
  (interactive)
  (let ((dot-emacs "~/.emacs"))
    (and (get-file-buffer dot-emacs)
         (save-buffer (get-file-buffer dot-emacs)))
    (load-file dot-emacs))
  (message "Re-initialized!"))
