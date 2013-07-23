;; Load Paths
(add-to-list 'load-path "~/.emacs.d/personal")

;; General Settings
(setq make-backup-files nil)        ;; Stop create backup~ files
(setq auto-save-default nil)        ;; Stop create #autosave# files
(fset 'yes-or-no-p 'y-or-n-p)       ;; Using y/n instead of yes/no
(setq kill-whole-line t)               ;; Kill a whole line, including the ending '\n'.
(setq enable-recursive-minibuffers t)  ;; Using the mini-buffer recursively.
(setq frame-title-format "%b@%f")      ;; Buffer name @ File location
(global-visual-line-mode 1)            ;; Have lines soft wrapped at word boundary.

;; Display time
;; (display-time-mode t)
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)
;; (setq display-time-use-mail-icon t)
;; (setq display-time-interval 10)

;; Org mode
;; http://stackoverflow.com/a/10643120/504646
(setq org-src-fontify-natively t)

;; Toggle window dedication
;; http://stackoverflow.com/questions/43765/pin-emacs-buffers-to-windows-for-cscope
(defun toggle-window-dedicated ()
"Toggle whether the current active window is dedicated or not"
(interactive)
(message
 (if (let (window (get-buffer-window (current-buffer)))
       (set-window-dedicated-p window
        (not (window-dedicated-p window))))
    "Window '%s' is dedicated"
    "Window '%s' is normal")
 (current-buffer)))
(global-set-key (kbd "<f11>") 'toggle-window-dedicated)

(require 'llvm-mode)
(require 'tablegen-mode)
(require 'xcscope)    ;; Cscope
(require 'win-switch) ;; Win-switch
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
;; (setq c-basic-offset 2)
;; (c-set-offset 'substatement-open 0)


;; (require 'google-c-style)
;; Key bindings:
;; ----------------------------------------------------------------
;; C-c C-v: Uncomment region
;; Return(C-m): Ident new line
;; ----------------------------------------------------------------

;; Max 80 cols per line, indent by two spaces, no tabs.
;; Apparently, this does not affect tabs in Makefiles.
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c++-indent-level 2)
 '(c-basic-offset 2)
 '(fill-column 80)
 '(indent-tabs-mode nil))

;; Alternative to setting the global style.  Only files with "llvm" in
;; their names will automatically set to the llvm.org coding style.
(c-add-style "llvm.org"
             '((fill-column . 80)
           (c++-indent-level . 2)
           (c-basic-offset . 2)
           (indent-tabs-mode . nil)
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
;;  (define-key c-mode-base-map "\M-/" 'ac-complete-gccsense)
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

;; Enable spell checking when writing programs.
;; (add-hook 'c-mode-hook        'flyspell-prog-mode 1)
;; (add-hook 'c++-mode-hook      'flyspell-prog-mode 1)
;; (add-hook 'cperl-mode-hook    'flyspell-prog-mode 1)
;; (add-hook 'makefile-mode-hook 'flyspell-prog-mode 1)
;; (add-hook 'python-mode-hook   'flyspell-prog-mode 1)
;; (add-hook 'sh-mode-hook       'flyspell-prog-mode 1)

;; Rebox comments
(autoload 'rebox-comment "rebox" nil t)
(autoload 'rebox-region "rebox" nil t)

;; Enable auto complete mode by default
;; (add-hook 'c-mode-common-hook 'auto-complete-mode)

;; Enable orgtbl minor mode in c-mode and text-mode
(add-hook 'c-mode-common-hook 'turn-on-orgtbl)

;; ;; CEDET
;; (add-to-list 'load-path "~/.emacs.d/cedet-1.0pre7/common/")
;; (require 'cedet)

;; (semantic-load-enable-minimum-features)
;; (semantic-load-enable-code-helpers)
;; ;; (semantic-load-enable-gaudy-code-helpers)
;; ;; (semantic-load-enable-excessive-code-helpers)
;; (semantic-load-enable-semantic-debugging-helpers)

;; Win-switch
(win-switch-setup-keys-ijkl "\C-xo")

;; GUD
(defun gud-key-customizations ()
  (define-key gud-mode-map (kbd "<f5>") 'gdb-many-windows))
(add-hook 'gdb-mode-hook 'gud-key-customizations)

;; ;; ido-mode
;; (require 'ido)
;; (ido-mode t)

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

;; load-notes
(defun load-notes ()
  "Load necessary note files from different locations"
  (interactive)
  (let ((notes "~/Workspace/Notes/c-expert-programming.org"))
    (find-file notes))
  (message "Notes loaded!"))
