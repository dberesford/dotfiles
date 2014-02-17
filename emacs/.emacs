(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-color-theme-solarized")

;(require 'package)
;(add-to-list 'package-archives 
;    '("marmalade" .
;      "http://marmalade-repo.org/packages/"))
;(package-initialize)

;; Notes
;; recursive grep: grep -nH -r --exclude-dir ".svn" -e pin c:\code\sql
;;
(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.txt" . markdown-mode) auto-mode-alist))

;(global-set-key "\C-w" 'clipboard-kill-region)
;(global-set-key "\M-w" 'clipboard-kill-ring-save)
;(global-set-key "\C-y" 'clipboard-yank)
(global-set-key "\C-Z" nil)
(global-unset-key (kbd "C-z"))
(global-set-key "\C-x\C-z" nil)
(global-set-key (kbd "C-x C-z") nil)
(put 'suspend-frame 'disabled t)

; (transient-mark-mode 1)  ; Now on by default: makes the region act quite like the text "highlight" in many apps.
   ; (setq shift-select-mode t) ; Now on by default: allows shifted cursor-keys to control the region.
   (setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
   (setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
   (setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
   ;; these will probably be already set to these values, leave them that way if so!
   ; (setf interprogram-cut-function 'x-select-text)
   ; (setf interprogram-paste-function 'x-cut-buffer-or-selection-value)
   ; You need an emacs with bug #902 fixed for this to work properly. It has now been fixed in CVS HEAD.
   ; it makes "highlight/middlebutton" style (X11 primary selection based) copy-paste work as expected
   ; if you're used to other modern apps (that is to say, the mere act of highlighting doesn't
   ; overwrite the clipboard or alter the kill ring, but you can paste in merely highlighted
   ; text with the mouse if you want to)
   (setq select-active-regions t) ;  active region sets primary X11 selection
   (global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.
   ;; with this, doing an M-y will also affect the X11 clipboard, making emacs act as a sort of clipboard history, at
   ;; least of text you've pasted into it in the first place.
   ; (setq yank-pop-change-selection t)  ; makes rotating the kill ring change the X11 clipboard.

(setq-default indent-tabs-mode nil)
(setq javascript-indent-level 2)
(setq javascript-basic-offset 2)
(setq c-basic-offset 2)
(setq-default tab-width 2)
(setq tab-width 2)
(setq indent-line-function 'insert-tab)

(autoload 'markdown-mode "markdown-mode.el"
   "Major mode for editing Markdown files" t)
(setq auto-mode-alist
   (cons '("\\.txt" . markdown-mode) auto-mode-alist))

;; load the tabbar
;; (require 'tabbar)
;;(tabbar-mode)
;;(global-set-key (kbd "C-`") 'tabbar-backward) 
;;(global-set-key (kbd "C-<tab>") 'tabbar-forward)
;;(setq tabbar-buffer-groups-function
;;(lambda (buffer)
;;(list "All buffers")))

;; turn off tool bar
(tool-bar-mode -1)

;; load files last being edited
;;(desktop-save-mode 1)

;; pretty up the tabbar
;;(set-face-attribute
;;   'tabbar-default-face nil
;;   :background "gray60")
;;  (set-face-attribute
;;   'tabbar-unselected-face nil
;;   :background "gray85"
;;   :foreground "gray30"
;;   :box nil)
;;  (set-face-attribute
;;   'tabbar-selected-face nil
;;   :background "#f2f2f6"
;;   :foreground "black"
;;   :box nil)
;;  (set-face-attribute
;;   'tabbar-button-face nil
;;   :box '(:line-width 1 :color "gray72" :style released-button))
;;  (set-face-attribute
;;   'tabbar-separator-face nil
;;   :height 0.7)

;;recentf
(require 'recentf)
(setq recentf-auto-cleanup 'never) ;; disable before we start recentf!
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)
(global-set-key [(meta f12)] 'recentf-open-files)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
    (autoload 'ibuffer "ibuffer" "List buffers." t)

;;hide buffers that start with an asterix
;;(require 'ibuf-ext)
;;(add-to-list 'ibuffer-never-show-predicates "^\\*")

;; associate template files with python
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . python-mode))

;; show-paren-mode by default
(show-paren-mode t)

;; search buffers for a string
(defun search-buffers (str)
  (interactive "sregex:")
  (let
      ((pt)
       (buf))
    (foreachbuffer
         (goto-char 0)
         (let
             (
              (dosearch (lambda  () (if (re-search-forward str nil t)
                                        (progn (setq pt (point))
                                               (setq buf i)
                                      (case (read-char "(c)ontinue (q)uit (n)ext buffer:")
                                        (?n nil)
                                        (?q (error "done."))
                                        (t (funcall dosearch)))))))
              )
           (funcall dosearch))))
    (if pt
        (progn 
          (switch-to-buffer buf)
          (goto-char pt))
        ))
(put 'downcase-region 'disabled nil)

;;disable beep
(setq visible-bell nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-startup-truncated nil)
 '(show-paren-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))

(defun save-macro (name)                  
    "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (find-file "~/.emacs")
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (save-buffer)
     (switch-to-buffer nil))               ; return to the initial buffer



(fset 'njs-console-log
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([99 111 110 115 111 108 101 46 108 111 103 40 34 34 41 59 left left left] 0 "%d")) arg)))
(global-set-key "\C-cl" 'njs-console-log)

(fset 'njs-console-log-var
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([67108896 C-right 134217847 1 down return up 32 32 99 111 110 115 111 108 101 46 108 111 103 40 34 25 58 33554464 34 33554464 43 33554464 117 116 105 108 46 105 110 115 112 101 99 116 40 25 41 41 59 backspace] 0 "%d")) arg)))
(global-set-key "\C-cv" 'njs-console-log-var)

(fset 'njs-traceargs
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([18 114 127 102 117 110 99 116 105 111 110 right 5 return 99 111 110 115 111 108 101 46 116 114 97 99 101 40 41 return 99 111 110 115 111 108 101 46 100 105 114 40 97 114 103 117 109 101 110 116 115 41 down] 0 "%d")) arg)))
(global-set-key "\C-ct" 'njs-traceargs)

(fset 'njs-utildebug
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([67108896 C-right 134217847 5 return 32 32 117 116 105 108 46 100 101 98 117 103 102 backspace 40 39 25 58 32 39 32 43 32 25 41 59] 0 "%d")) arg)))

(global-set-key "\C-cd" 'njs-utildebug)

(fset 'console-error
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([99 111 110 115 111 108 101 46 101 114 114 111 114 40 41 59 backspace left] 0 "%d")) arg)))

(global-set-key "\C-ce" 'console-error)

;; assembla tickets
(defun asm ()
  (interactive)
  (shell-command "asm " nil nil)
)
(global-set-key (kbd "\C-ca") 'asm)

;; Orgmode: the following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
;;(global-set-key "\C-cl" 'org-store-link)
;;(global-set-key "\C-ca" 'org-agenda)
;;(global-set-key "\C-cb" 'org-iswitchb)

;; prevent accidental exiting  
(global-set-key "\C-x\C-c" nil)

(menu-bar-mode -99)

;; color theme
(add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-goodies-el/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-hober)))

(require 'color-theme-solarized)
(color-theme-solarized-dark)

;; uncomment to turn on tabbar by default
;;(tabbar-mode)
(toggle-scroll-bar nil)

(setq inhibit-splash-screen t)

(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
;; commenting here.. 
;;(autoload 'js2-mode "js2" nil t)
;;(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(autoload 'js3-mode "js3" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js3-mode))

;; autocomplete
(add-to-list 'load-path "/home/dberesford/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/dberesford/.emacs.d/ac-dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

(add-to-list 'ac-modes 'js3-mode)

(require 'grep-a-lot)
(grep-a-lot-setup-keys)

(setq tramp-default-method "ssh")

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
(global-set-key [f8] 'nav-toggle)

(defun beautify-json ()
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
     "jq ." (current-buffer) t)))

