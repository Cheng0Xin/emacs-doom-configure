;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; My name configuaration
(setq user-full-name "Cheng Xin"
      user-mail-address "claudexin@outlook.com")

;; Doom theme
;; (setq doom-theme 'doom-Iosvkem)
;; (setq doom-theme 'doom-gruvbox-light)
;; (setq doom-theme 'tango)
(load-file "~/.doom.d/theme.el")

;; Org directory
(setq org-directory "~/Workspace/Org/")

;; Line number
(setq display-line-numbers-type `relative)
(setq confirm-kill-emacs nil)

;; Fonts and their size
(setq doom-font (font-spec :family "DejaVuSansMono Nerd Font Mono" :size 18)
      ; doom-big-font (font-spec :size 20)
      ; doom-variable-pitch-font (font-spec :family "FiraMono Nerd Font Mono" :size 24)
      doom-unicode-font (font-spec :family "Symbola"))
      ; doom-serif-font (font-spec :family "FiraMono Nerd Font Mono" :weight 'light))

;; Simple settings
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…"                ; Unicode ellispis are nicer than "...", and also save /precious/ space
      password-cache-expiry nil                   ; I can trust my computers ... can't I?
      ;; scroll-preserve-screen-position 'always     ; Don't have `point' jump around
      scroll-margin 20)                            ; It's nice to maintain a little margin

(display-time-mode 1)                             ; Enable time in the mode-line

; (unless (string-match-p "^Power N/A" (battery))   ; On laptops...
;   (display-battery-mode 1))                       ; it's nice to know how much power you have

(global-subword-mode 1)                           ; Iterate through CamelCase words

(setq initial-frame-alist `((top . 1) (left . 1) (width . 143) (height . 55)))

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t))


;; Org models
(setq org-startup-with-inline-images t)

(set-popup-rules!
  '(("^ \\*" :side right :size 0.5 :select t)
    ; ("\\*Racket REPL\\*" :side down :size 0.5 :select t)
    ("^\\*Python" :side right :size 0.5 :select t)))
;; Keymap
;; vim-join-line
(defun vim-join-line () "Doc join two line just like in vim."
  (forward-line)
  (join-line)
  (delete-horizontal-space)
  (insert " "))

(map! "C-c <up>" (cmd! (enlarge-window 10)))
(map! "C-c <down>" (cmd! (shrink-window 10)))
(map! "C-c C-j" (cmd! (vim-join-line)))
(map! "C-c C-q" (cmd! (+popup/toggle)))
(map! "C-x C-o" (cmd! (company-complete-common)))
(global-set-key (kbd "C-c =") 'er/expand-region)

;; Racket
(add-hook 'racket-mode-hook
          '(lambda() (set (make-local-variable 'racket-smart-open-bracket-mode)
                     nil)))

;; Template setting
(setq +file-templates-dir "~/.doom.d/templates"
   max-specpdl-size 10000)
(set-file-template! ".+\\.org$" :trigger "t.org" :mode 'org-mode)

;; Wrap line
(global-visual-line-mode t)


;; For latex
(defun TEX/remove-electric-indent-mode ()
  (electric-indent-local-mode -1))

(add-hook 'LaTeX-mode-hook 'TEX/remove-electric-indent-mode)
(add-hook 'tex-mode-hook 'TEX/remove-electric-indent-mode)
