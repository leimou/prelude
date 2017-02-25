;; Load Paths
;; -----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/personal")
(add-to-list 'load-path "~/.emacs.d/personal/auto-complete")

;; Open header file in c++-mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))

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
(require 'prelude-helm-everywhere)
(require 'auto-complete)
(ac-config-default)

;; Yasnippet Settings
;; -----------------------------------------------------------------------------
;; Add yasnippet to prelude's required package list.
(prelude-require-package 'yasnippet)

;; Don't clean whitespace upon save.
(setq prelude-clean-whitespace-on-save nil)

(defvar personal-snippets-dir (expand-file-name "snippets" prelude-personal-dir)
  "This folder houses additional yasnippet bundles added by the users.")

;; load yasnippet
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs personal-snippets-dir)
(yas-global-mode 1)

;; term-mode does not play well with yasnippet
(add-hook 'term-mode-hook (lambda ()
                            (yas-minor-mode -1)))

;; Org mode: http://stackoverflow.com/a/10643120/504646
;; -----------------------------------------------------------------------------
(setq org-src-fontify-natively t)
;; -----------------------------------------------------------------------------

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

(global-linum-mode t)

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
