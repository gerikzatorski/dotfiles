;;-------------------------------------------------------------------------------------------- PACKAGES
;; Enable installation of packages from MELPA
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; Adding autocomplete for Python
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Setting up the multiple-cursors package
(global-set-key (kbd "C-c m c") 'mc/edit-lines)

;; init beacon package
(beacon-mode 1)
(setq beacon-color "#666600")

;; add ace jump
(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;-------------------------------------------------------------------------------------------- VISUAL
;; Stores emacs themes here
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;(load-theme 'zenburn t)
;;(load-theme 'gruvbox t)
(load-theme 'monokai t)

;; set transparency
;;(set-frame-parameter (selected-frame) 'alpha '(85 85))
;;(add-to-list 'default-frame-alist '(alpha 85 85))

;;--------------------------------------------------------------------------------------------
;; store all backup and autosave files in the tmp dir
;; https://www.emacswiki.org/emacs/BackupDirectory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;;--------------------------------------------------------------------------------------------
;; Setup .launch and .urdf files to open in 
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.urdf$" . xml-mode))

;;--------------------------------------------------------------------------------------------
;; TODO
;; idomenu info told me to include this
(autoload 'idomenu "idomenu" nil t)
(global-set-key (kbd "M-i") 'ido-goto-symbol)

;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)

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
(transient-mark-mode 0)
(xclip-mode 1)

;;(define-key global-map (kbd "C-S-C") 'clipboard-kill-ring-save)
;;(define-key global-map (kbd "C-S-V") 'clipboard-yank)
