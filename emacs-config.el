
(setq user-full-name "Fabien Cesari"
      user-mail-address "fabien.cesari@gmail.com")

(setq inhibit-startup-screen t)

(add-to-list 'load-path "/opt/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/elib/")

(add-to-list 'load-path "~/.emacs.d/external/jdee-2.4.1/lisp")
(add-to-list 'load-path "~/.emacs.d/external/")
(add-to-list 'load-path "~/.emacs.d/external/git/")
(add-to-list 'load-path "~/.emacs.d/external/muse/lisp")
(add-to-list 'load-path "~/.emacs.d/external/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/external/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/external/cedet/")
(add-to-list 'load-path "~/.emacs.d/external/autocomplete/")
(add-to-list 'load-path "~/.emacs.d/external/nxhtml/util")
(add-to-list 'load-path "~/.emacs.d/external/rhtml")
(add-to-list 'load-path "~/.emacs.d/external/php-mode")
(add-to-list 'load-path "~/.emacs.d/external/arduino-mode")

(load "tempo")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(gdb-max-frames 100)
 '(global-subword-mode t)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(tool-bar-mode t))


(set-face-attribute 'default nil :height 120)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'psvn)

(require 'git)

; change window focus with shift-arrows
;;;; (require 'windmove)
(windmove-default-keybindings)
(setq windmove-wrap-around t)
(require 'buffer-move)

(global-set-key (kbd "C-+") 'hs-toggle-hiding)

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'espresso-mode-hook   'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-donw>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

;;; I prefer cmd key for meta
(setq mac-command-modifier 'meta)
(setq mac-right-option-modifier nil)

(require 'tramp)
(setq tramp-default-method "ftp")

;(require 'multi-term)
;(setq multi-term-program "/bin/zsh")

(require 'sudo-save)

;;;(autoload 'python-mode "python-mode" "Python Mode." t)
;;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;;(setq mac-option-modifier 'none)
;;(setq mac-command-modifier 'meta)

(when (eq system-type 'darwin)
  (setq mac-pass-command-to-system nil) )

(require 'exec-path-from-shell) ;; if not using the ELPA package
     (exec-path-from-shell-initialize)

(when
    (load
     (expand-file-name "~/.emacs.d/external/package.el"))
  (package-initialize))

(load "doxymacs")
 (load "xml-parse")
 (require 'doxymacs)
 (add-hook 'c-mode-common-hook'doxymacs-mode)
 (defun my-c-font-lock-doxy-html (limit)
   (while (re-search-forward "<.+?>" limit 'move)
     (let ((beg (match-beginning 0))
           (end (match-end 0)))
       (if (nth 4 (syntax-ppss beg))
           (when (nth 4 (syntax-ppss end))
             (c-put-font-lock-face beg end 'font-lock-keyword-face))
         (goto-char end))))
   nil)
 (defun my-c-mode-common-hook ()
   (font-lock-add-keywords nil '((my-c-font-lock-doxy-html))))
 (add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;Matlab-emacs config
;; add repo to the pah.
(setq load-path (append load-path(list "~/.emacs.d/external/matlab-emacs")))

(autoload 'matlab-mode "matlab" "Enter MATLAB Mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)

;; Customization:
(setq matlab-indent-function t) ; if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 76))                ; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; Turn off Matlab desktop
(setq matlab-shell-command-switches '("-nojvm"))

(require 'cedet)
(load "~/.emacs.d/external/cedet/lisp/cedet/cedet.el")

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another 
;; package (Gnus, auth-source, ...).

;; Add further minor-modes to be enabled by semantic-mode.
;; See doc-string of `semantic-default-submodes' for other things
;; you can use here.
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)

;; Enable Semantic
(semantic-mode 1)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Configure arduino OS X dirs.
;;(setq ede-arduino-appdir "/Applications/Arduino.app/Contents/Resources/Java")

(require 'muse-mode)     ; load authoring mode
(require 'muse-html)     ; load publishing styles I use
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)
(require 'muse-project)  ; publish files in projects


;; Muse project configuration -- May be system dependend, so not Ideal.

(load "~/.emacs.d/external/nxhtml/autostart.el")
(setq
      nxhtml-global-minor-mode t
      mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil
      nxml-degraded t)
     (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
(lambda () (rinari-launch)))

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/external/autocomplete//ac-dict")
(ac-config-default)

(require 'mumamo-fun)
(setq mumamo-chunk-coloring 'submode-colored)
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-html-mumamo))
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-html-mumamo))

(require 'ruby-mode)
(require 'ruby-style)
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

;(setq load-path (cons (expand-file-name "~/.emacs.d/external/emacs-rails") load-path))
;(require 'rails-autoload)

;(add-to-list 'load-path "~/.emacs.d/external/rinari")
;(require 'rinari)
;(setq rinari-tags-file-name "TAGS")

(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.module$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.install$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.engine$" . php-mode))

(add-hook 'svn-log-edit-mode-hook
          '(lambda () "SVN log edit mode"
             (flyspell-mode 1 )
             (auto-fill-mode 0)))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.mdt$" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook 'turn-on-flyspell)
                                        ;(require 'tex)
(load "auctex.el" nil t t)

(require 'tex-site)
;;;; (if window-system (require 'font-latex))
(add-hook 'LaTeX-mode-hook 'turn-on-flyspell)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-bib-cite)

;; spell
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(global-set-key (kbd "C-$") 'flyspell-auto-correct-word)

'(ispell-dictionary "en_GB-ise")
'(ispell-program-name "aspell")
'(flyspell-issue-message-flag nil)

(let ((langs '("american" "francais")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))

;; easy spell check
(global-set-key [f6] 'cycle-ispell-languages)
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(autoload 'processing-mode "processing-mode" "Processing mode" t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/usr/bin/processing-java")

(setq org-publish-project-alist
      '(("blog"
         :base-directory "~/work/magnizdat/site/blog_emacs"
         :html-extension "html"
         :base-extension "org"
         :publishing-directory "~/work/magnizdat/site/blog_emacs/public_html"
         :publishing-function (org-html-publish-to-html)
         :html-preamble nil
         :html-postamble nil)))

(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(require 'sudo-save)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
