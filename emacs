;; Emacs config file
;;--------------------------------------------------------------------------------------------
;; Enable installation of packages from MELPA
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;;--------------------------------------------------------------------------------------------
;; Stores emacs themes here
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'gruvbox t)

;;--------------------------------------------------------------------------------------------
;; store all backup and autosave files in the tmp dir
;; https://www.emacswiki.org/emacs/BackupDirectory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;--------------------------------------------------------------------------------------------
;; Adding autocomplete for Python
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;--------------------------------------------------------------------------------------------
;; Setting up the multiple-cursors package
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;;--------------------------------------------------------------------------------------------
;; init beacon package
(beacon-mode 1)
(setq beacon-color "#666600")

;;--------------------------------------------------------------------------------------------
;; Author: Patrick Gundlach 
;; nice mark - shows mark as a highlighted 'cursor' so user 'always' 
;; sees where the mark is. Especially nice for killing a region.

(defvar pg-mark-overlay nil
  "Overlay to show the position where the mark is") 
(make-variable-buffer-local 'pg-mark-overlay)

(put 'pg-mark-mark 'face 'secondary-selection)

(defvar pg-mark-old-position nil
  "The position the mark was at. To be able to compare with the
current position")

(defun pg-show-mark () 
  "Display an overlay where the mark is at. Should be hooked into 
activate-mark-hook" 
  (unless pg-mark-overlay 
    (setq pg-mark-overlay (make-overlay 0 0))
    (overlay-put pg-mark-overlay 'category 'pg-mark-mark))
  (let ((here (mark t)))
    (when here
      (move-overlay pg-mark-overlay here (1+ here)))))

(defadvice  exchange-point-and-mark (after pg-mark-exchange-point-and-mark)
  "Show visual marker"
  (pg-show-mark))

(ad-activate 'exchange-point-and-mark)
(add-hook 'activate-mark-hook 'pg-show-mark)

;;--------------------------------------------------------------------------------------------
;; add ace jump
(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;--------------------------------------------------------------------------------------------
;; TODO
;; idomenu info told me to include this
(autoload 'idomenu "idomenu" nil t)
(global-set-key (kbd "M-i") 'ido-goto-symbol)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9d91458c4ad7c74cf946bd97ad085c0f6a40c370ac0a1cbeb2e3879f15b40553" "d320493111089afba1563bc3962d8ea1117dd2b3abb189aeebdc8c51b5517ddb" default)))
 '(package-selected-packages
   (quote
    (markdown-preview-mode markdown-mode web-mode web-beautify multiple-cursors zenburn-theme exec-path-from-shell virtualenv jedi gruvbox-theme beacon ace-jump-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;--------------------------------------------------------------------------------------------
;; Get jedi to work on macs
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;--------------------------------------------------------------------------------------------
;; change html indentation to 4
(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))
	  
;;--------------------------------------------------------------------------------------------
;; Custom major modes for certain files
;; .handlebars files open in html
(add-to-list 'auto-mode-alist '("\\.handlebars\\'" . html-mode))

;; open this .emacs file based on it's first line
(add-to-list 'magic-mode-alist '(";; Emacs config file" . lisp-mode) )
