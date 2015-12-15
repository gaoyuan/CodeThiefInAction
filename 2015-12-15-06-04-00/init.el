;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom-set-*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("f0d8af755039aa25cd0792ace9002ba885fd14ac8e8807388ab00ec84c9497d7" "c86f868347919095aa44d2a6129dd714cbcf8feaa88ba954f636295b14ceff8f" default)))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(transmission-host "192.168.1.79")
 '(transmission-rpc-auth
   (quote
    (:username "transmission" :password "install gentoo 123")))
 '(transmission-timer-p t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MELPA+ELPA package setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package requires / system loads
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'dired+)
(require 'web-mode)
(require 'coffee-mode)
(require 'python-mode)

(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Built-in configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Sane backup file settings
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Disable tabs
(setq-default indent-tabs-mode nil)

;; Font
(let ((my-font "Droid Sans Mono Slashed-11"))
  (add-to-list 'default-frame-alist (cons 'font my-font))
  (set-face-attribute 'default t :font my-font))

;; Enable word-wrap for org-mode.
(add-hook 'org-mode-hook (lambda ()
                           (setq word-wrap t)))

;; c-mode
(add-hook 'c-mode-hook (lambda ()
                         (setq indent-tabs-mode t)
                         (c-set-style "bsd")))

;; javascript-mode
(setq js-indent-level 2)

;; Suppress startup welcome message
(setq inhibit-startup-screen t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; web-mode
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))
(add-hook 'web-mode-hook (lambda ()
                           (setq web-mode-markup-indent-offset 2)
                           (setq web-mode-css-indent-offset 2)
                           (setq web-mode-code-indent-offset 2)))

;; coffeescript
(setq coffee-tab-width 2)

;; enh-ruby-mode
(autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; auctex
(add-hook 'TeX-mode-hook (lambda ()
                           (setq word-wrap t)))

;; python-mode 
(add-hook 'python-mode-hook (lambda ()
                              (setq-local column-number-mode t)))

;; cyberpunk theme
(add-hook 'after-init-hook
          (lambda () (load-theme 'cyberpunk t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom interactive functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer) 
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))


(defun toggle-word-wrap ()
  "Toggle word wrap"
  (interactive)
  (message (format
            "Word wrap %s."
            (if (setq word-wrap (not word-wrap))
                "enabled"
              "disabled"))))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))
