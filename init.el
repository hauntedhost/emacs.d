(add-to-list 'load-path "~/.emacs.d/packages")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'package)

(setq package-archives
  '(("gnu"          . "http://elpa.gnu.org/packages/")
    ("marmalade"    . "http://marmalade-repo.org/packages/")
    ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
    ("org"          . "http://orgmode.org/elpa/")))

(package-initialize)

(defvar my-packages '(better-defaults
                      cider
                      clojure-mode
                      elixir-mode
                      evil
                      projectile))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (unless (assoc p package-archive-contents)
      (package-refresh-contents))
      (package-install p)))

;(defun require-package (package)
;  (setq-default highlight-tabs t)
;    "Install given package."
;      (unless (package-installed-p package)
;        (unless (assoc package package-archive-contents)
;          (package-refresh-contents))
;            (package-install package)))

; themes themes themes
;(load-theme 'monokai t)
;(load-theme 'solarized-dark t)
;(load-theme 'junio t)
;(load-theme 'smyx t) ; ****
;(load-theme 'lush t) ; ****
(load-theme 'spolsky t);

; osx color things
(require 'color-theme-approximate)
(color-theme-approximate-on)
(custom-set-faces
  (if (not window-system)
    '(default ((t (:background "nil"))))))

; evil mode ftw
(evil-mode)

; powerline
; (require 'powerline)
(require 'powerline-evil)
(powerline-evil-vim-color-theme)
; (powerline-evil-vim-theme) ; minimal
; (powerline-evil-center-color-theme)

(display-time-mode t)

; turn off menu bar
(menu-bar-mode -1)

;disable backup
(setq backup-inhibited t)

;disable auto save
(setq auto-save-default nil)

; whitespace shenanigans
(global-whitespace-mode t)

(setq whitespace-display-mappings '(
  (space-mark   32     [183]          [46])
  (tab-mark     9      [8212 32]      [8212 32])
))

(setq whitespace-line-column 85)

(custom-set-faces
 '(whitespace-space ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-empty ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-hspace ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-indentation ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-line ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-newline ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-space-after-tab ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-space-before-tab ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-tab ((t (:foreground "#2e2e2e" :background nil))))
 '(whitespace-trailing ((t (:foreground "#2e2e2e" :background nil))))
)

; no tabs
(setq-default indent-tabs-mode nil)

; show matching parens
(show-paren-mode t)

; line number shenanigans
(global-linum-mode t)
; (setq linum-format "%d ")
; (setq linum-format "%4d \u2502 ")

(defface linenum-gutter '((t (:background "#343331"
                              :foreground "#343331"
                              :inherit mode-line)))
  "linenum-gutter face."
  :group 'modeline)

(unless window-system
  (add-hook 'linum-before-numbering-hook
    (lambda ()
      (setq-local linum-format-fmt
        (let ((w (length (number-to-string
                 (count-lines (point-min) (point-max))))))
          (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'linenum-gutter)))

(unless window-system
  (setq linum-format 'linum-format-func))

(set-face-attribute 'fringe nil :background "nil")
(set-face-attribute 'linum nil :background "nil")
