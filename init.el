; set custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
 
;; disable tool and Menu bar:
 
(tool-bar-mode -1)
(menu-bar-mode -1)

 
;; disable scroll bar , load-battery. :
 
(scroll-bar-mode -1)
(display-battery-mode 1)
(fringe-mode nil)

;; setup linum-relative:

 
;; set default font:
 
(set-frame-font "Ubuntu Mono 13")
 
;;(add-to-list 'load-path "~/.emacs.d/evil-setup.el")
 
(add-to-list 'load-path "~/.emacs.d/")
 
;; add repos for elpa
 
(require 'package)
 
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
 			 ("marmalade" . "http://marmalade-repo.org/packages/")
 			 ("melpa" . "http://melpa.milkbox.net/packages/")))
 
(package-initialize)

;; end of elpa setup

;; set themes directory:
;; set path for go-mode
;(setenv "GOPATH" "/home/martin/gocode")

(require 'go-autocomplete)





(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
 
;; add key-chords
(require 'key-chord)
(key-chord-mode 1)

;;load slime-helper for quicklisp:

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
(slime-setup '(slime-fancy slime-tramp slime-asdf))




;; multiple-cursors setup:
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; end of multiple cursors

;; ace-jump mode
(require 'ace-jump-mode)
(key-chord-define-global "kj" 'ace-jump-mode)

;; change key-binding from complete-at-point:
(key-chord-define-global "hg" 'slime-complete-symbol)
(key-chord-define-global "nm" 'magit-status) 
(key-chord-define-global "gr" 'golden-ratio)
(key-chord-define-global "rw" 'rotate-windows)
(key-chord-define-global "tw" 'toggle-window-split)
(key-chord-define-global "sc" 'org-capture)

;; evil setup:
;; (require 'evil-setup)
 
;; set theme :
(load-theme 'wombat)



 
;; add winner-mode
(winner-mode 1)
 
;; add auto-complete
(require 'auto-complete-config)
(require 'auto-complete-extension)
(add-to-list 'ac-dictionary-directories "/home/martin/.emacs.d//ac-dict")
 
;; end of auto-complete setup
;; map "C-h" to Delete char.
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)
 
;; use y/n instead of yes / no:
(defalias 'yes-or-no-p 'y-or-n-p)
 
;; flymake-mode for haskell:
(require 'flymake)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'flymake-mode nil)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'flymake-hlint-load)
(add-hook 'haskell-mode-hook 'flymake-mode t)
(add-hook 'haskell-mode-hook 'eldoc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)



;; enable ido-mode:
(setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; setup smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "<menu>") 'smex)


;; toggle window-split:

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))


;; python jedi setup:
(setq jedi:setup-keys t)
(add-hook 'python-mode-hook 'jedi:setup)


;; auto-complete the 2nd.
(when (require 'auto-complete-config)
  ; Load the default configs and do some further tweaking
  (ac-config-default)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)

  ;; default sources of candidates
  (setq-default ac-sources (cons 'ac-source-yasnippet ac-sources))

  ;; A new way of adding keywords is through dictionary:
  ; Any user defined keywords go here
  ;(add-to-list 'ac-user-dictionary "foobar@example.com")
  ; mode-specific keywords
  (add-to-list 'ac-dictionary-directories "~/Emacs/auto-complete/dict")

(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)


  
  ;; Somehow the hook doesn't enable auto-complete-mode for Haskell although it should
  ; ac-modes lists all modes with auto-complete enabled
  (setq ac-modes
      (append '(clojure-mode elisp-mode scheme-mode haskell-mode literate-haskell-mode tuareg-mode js2-mode inferior-haskell-mode scala-mode scala-mode2 )
              ac-modes )))


(add-hook 'inferior-haskell-mode-hook
   (lambda ()
     (setq ac-sources '(my/ac-source-haskell ac-source-dictionary ac-source-words-in-same-mode-buffers)
     )))

;; end of auto-complete for haskell 

;; weather-metno-setup:
(setq weather-metno-location-name "City_of_Edinburgh,Scotland"
      weather-metno-location-latitude 55
      weather-metno-location-longitude 3)

;; org-capture:
(setq org-default-notes-file (expand-file-name "~/todo.org"))



;; Org-mode setup:

(define-key mode-specific-map [?a] 'org-agenda)


(setq org-default-notes-file (expand-file-name "~/notes.org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/todo.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))

(global-set-key (kbd "C-c c") 'org-capture)

;; end of org-mode .


(setq evil-default-cursor t)

;; ;; load the ensime lisp code...
;; (add-to-list 'load-path "~/ensime_2.9.2-0.9.8.9/elisp")
;; (require 'ensime)

;; ;; This step causes the ensime-mode to be started whenever
;; ;; scala-mode is started for a buffer. You may have to customize this step
;; ;; if you're not using the standard scala mode.
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; setup python :
(setq py-install-directory "~/.emacs.d/site-lisp/python-mode.el-6.1.1")
(add-to-list 'load-path py-install-directory)
(require 'python-mode)


;; switch window contents
(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;; End of switch window contents.

;; Sunrise / Sunset ThemeChanger
(setq calendar-location-name "Edinburgh, UK")
(setq calendar-latitude 56.0 )
(setq calendar-longitude -3.2)

;; setup Ruby:
(require 'ruby-tools)
(require 'ruby-electric)
(add-hook 'ruby-mode 'ruby-tools-mode 1)
(add-hook 'ruby-mode 'ruby-electric-mode)

;; setup Yasnippet :
(yas-global-mode 1)

;; dimm rainbow-delimiters
;; (defun krig-paren-clr (n)
;;   (let ((c (+ ?\x59 (* (- n 1) 8))))
;;     (format "#%X%X%X" c c c)))

;; (defun krig-rainbow-face-n (n)
;;   (intern (format "rainbow-delimiters-depth-%d-face" n)))


;; common Lisp:
;; paredit hook:
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;;(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;(add-hook 'lisp-mode-hook 'highlight-parentheses-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;;(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'show-paren-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
(add-hook
 'lisp-mode-hook
	  (lambda ()
	    (font-lock-add-keywords nil
				    '(("deftest" . font-lock-keyword-face)
				      ("clunit:assert-equal" . font-lock-keyword-face)
				      ("clunit:assert-true" . font-lock-keyword-face)
				      ("clunit:defsuite" . font-lock-keyword-face)
				      ("clunit:run-suite" . font-lock-keyword-face)))))

;; ;;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; (defun cliki:start-slime ()
;;   (save-excursion (slime)))


;;(add-hook 'slime-mode-hook 'cliki:start-slime)
;; (require 'rainbow-delimiters)
;; (global-rainbow-delimiters-mode)
;; ;; (cl-loop for i from 1 to 9 do
;; ;; 	 (set-face-foreground (krig-rainbow-face-n i)
;; ;			      (krig-paren-clr i)
;; ))


(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'slime-repl-mode))



;;(load (expand-file-name "~/quicklisp/setup.lisp"))
;; ;; Replace "sbcl" with the path to your implementation
;; setup Clojure:
(add-hook 'clojure-mode-hook 'paredit-mode)
;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
;; (cl-loop for i from 1 to 9 do
;; 	 (set-face-foreground (krig-rainbow-face-n i)
;; 			      (krig-paren-clr i)))

;(require 'clojure-jump-to-file)

;(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;(setq nrepl-hide-special-buffers t)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'nrepl-mode))

;;recentf -mode
(require 'recentf)
 
;; get rid of `find-file-read-only' and replace it with something
;; more useful.
(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
 
;; enable recent files mode.
(recentf-mode t)
 
; 50 files ought to be enough.
(setq recentf-max-saved-items 50)
 
(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))

;; end of recentf-mode.
;; open-line-above
(defun smart-open-line-above ()
  "Insert an empty line above the current line."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))


(global-set-key (kbd "M-o") 'smart-open-line-above)

;;end of smart-open line

;; Add Popwin Window-Manger
(require 'popwin)
(popwin-mode t)


;; ;; ;; ;; Try JDEE:
;; (add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;; (load "jde")


;; (add-hook 'java-mode-hook '(lambda ()
;; 			     (load "jde")
;; 			     (global-semantic-idle-completions-mode t)
;; 			     (global-semantic-decoration-mode t)
;; 			     (global-semantic-highlight-func-mode t)
;; 			     (global-semantic-show-unmatched-syntax-mode t)
;; 			     (jde-mode)
;; 			     (setq ac-sources (append '(ac-source-semantic) ac-sources))
;; 			     (local-set-key (kbd "RET") 'newline-and-indent)
;;			     (semantic-mode t)
;; ))
(defun lispdoc ()
  "Searches lispdoc.com for SYMBOL, which is by default the symbol currently under the curser"
  (interactive)
  (let* ((word-at-point (word-at-point))
         (symbol-at-point (symbol-at-point))
         (default (symbol-name symbol-at-point))
         (inp (read-from-minibuffer
               (if (or word-at-point symbol-at-point)
                   (concat "Symbol (default " default "): ")
                 "Symbol (no default): "))))
    (if (and (string= inp "") (not word-at-point) (not
                                                   symbol-at-point))
        (message "you didn't enter a symbol!")
      (let ((search-type (read-from-minibuffer
                          "full-text (f) or basic (b) search (default b)? ")))
        (browse-url (concat "http://lispdoc.com?q="
                            (if (string= inp "")
                                default
                              inp)
                            "&search="
                            (if (string-equal search-type "f")
                                "full+text+search"
                              "basic+search")))))))

(define-key lisp-mode-map (kbd "C-c l") 'lispdoc)

(defun byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))


;; set yas-expand key
(global-set-key (kbd "C-<tab>") 'yas-expand-from-trigger-key)


;; add column-marker
(add-hook 'clojure-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'lisp-mode-hook (lambda () (interactive) (column-marker-1 80)))

;; Teach compile the syntax of the kibit output
(require 'compile)
(add-to-list 'compilation-error-regexp-alist-alist
         '(kibit "At \\([^:]+\\):\\([[:digit:]]+\\):" 1 2 nil 0))
(add-to-list 'compilation-error-regexp-alist 'kibit)

;; A convenient command to run "lein kibit" in the project to which
;; the current emacs buffer belongs to.
(defun kibit ()
  "Run kibit on the current project.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile "lein kibit"))

(defun kibit-current-file ()
  "Run kibit on the current file.
Display the results in a hyperlinked *compilation* buffer."
  (interactive)
  (compile (concat "lein kibit " buffer-file-name)))


;; setup go-mode:
(add-hook 'before-save-hook 'gofmt-before-save)

;; setup javascript:
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)
;(add-hook ‘js-mode-hook (lambda () (slime-js-minor-mode 1)))
;(add-hook 'js2-mode-hook (lambda () (slime-js-minor-mode 1)))

;(load-file "/home/martin/.emacs.d/setup-slime-js.el")

;; (global-set-key [f5] 'slime-js-reload)
;; (add-hook 'js2-mode-hook
;;           (lambda ()
;;             (slime-js-minor-mode 1)))
;; (add-hook 'css-mode-hook
;;           (lambda ()
;;             (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
;;             (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css)))

;; Bookmarklet to load skewer:
;;
;;     javascript:(function(){var d=document ;var s=d.createElement('script');s.src='http://localhost:8023/skewer';d.body.appendChild(s);})()
;;
(defun skewer-start ()
  (interactive)
  (let ((httpd-port 8023))
    (httpd-start)
    (message "Ready to skewer the browser. Now jack in with the bookmarklet.")))

(defun skewer-demo ()
  (interactive)
  (let ((httpd-port 8024))
    (run-skewer)
    (skewer-repl)))

(require 'parenface)
(set-face-foreground 'paren-face "gray32")

(require 'powerline)
(powerline-center-theme)

(require 'ac-nrepl-compliment)
(add-hook 'nrepl-mode-hook 'ac-nrepl-compliment-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-compliment-setup)
(eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'nrepl-mode))
(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook
	  'set-auto-complete-as-completion-at-point-function)

(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook
	  'set-auto-complete-as-completion-at-point-function)

;; change slime-output faces:
(set-face-foreground 'slime-repl-output-face "lightsalmon")
(set-face-foreground 'slime-repl-result-face "#e2ffb8")
(set-face-foreground 'slime-repl-inputed-output-face "#e2ffb8")



