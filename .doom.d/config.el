;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "ryan"
      user-mail-address "ryan@plextrac.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; some themes I like
;; (setq doom-theme 'doom-dark+)
;; (setq doom-theme 'doom-tomorrow-night)
;; (setq doom-theme 'doom-opera)
;; (setq doom-theme 'misterioso)
;; (setq doom-theme 'doom-henna)
;; (setq doom-theme 'doom-acario-dark)
;; (setq doom-theme 'doom-one)

;; I like to think I have an eye for aesthetics. here are my custom themes
;; (setq doom-theme 'rzm-dark+)
;; (setq doom-theme 'rzm-manoj-dark)

;; currently enabled theme and font settings
(setq doom-theme 'rzm-dark+)
(setq doom-font (font-spec :family "Menlo" :size 14)
      doom-big-font (font-spec :family "Menlo" :size 20))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dev/rzm-notes/")

;; org capture templates
(setq org-capture-templates
      '(("t" "Personal todos" entry
       (file+headline +org-capture-todo-file "todos")
       "* [ ] %?\n%i\n%a" :prepend t)
      ("n" "Personal notes" entry
       (file+headline +org-capture-notes-file "notes")
       "* %u %?\n%i\n" :prepend t)
      ("j" "Journal" entry
       (file+olp+datetree +org-capture-journal-file)
       "* %U %?\n%i\n" :prepend t)
      ("p" "Templates for projects")
      ("pt" "Project-local todo" entry
       (file+headline +org-capture-project-todo-file "Inbox")
       "* TODO %?\n%i\n%a" :prepend t)
      ("pn" "Project-local notes" entry
       (file+headline +org-capture-project-notes-file "Inbox")
       "* %U %?\n%i\n%a" :prepend t)
      ("pc" "Project-local changelog" entry
       (file+headline +org-capture-project-changelog-file "Unreleased")
       "* %U %?\n%i\n%a" :prepend t)
      ("o" "Centralized templates for projects")
      ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
      ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
      ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;;;;;;;;;;;;;;;
;; rzm customs ;;
;;;;;;;;;;;;;;;;;

(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; kill trailing whitespace

;; syntax highlighting for uncommon extensions
(add-to-list 'auto-mode-alist '("\\.yaml.tmpl\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.cshtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.info\\'" . Info-on-current-buffer))
(add-hook 'window-setup-hook #'toggle-frame-maximized) ;; fullscreen

;; prettier js
(add-hook '+javascript-npm-mode-hook 'prettier-js-mode) ;; fullscreen


;; helps the go lsp work mo' bettah
(setq lsp-enable-file-watchers nil)

;; suppress minor mode-line modes from displaying
(rich-minority-mode 1)
(setq rm-blacklist
      (format "^ \\(%s\\)$"
              (mapconcat #'identity
                         '("Fly.*" "Projectile.*" "PgLn" "GCMH" "WK" "better-jumper" "EG.*" "dtrt-indent" "$" "Abbrev" "yas" "SP" "~" "ws" "wb" "GitGutter" "ivyjk")
                         "\\|")))

;; my minimalist mode line that makes me feel cool
(setq-default mode-line-format
              (list
               " --   "
               'mode-line-mule-info
               'mode-line-modified
               'mode-line-frame-identification
               "   "
               'mode-line-buffer-identification
               "   "
               'mode-line-position
               '(vc-mode vc-mode)
               "   ("
               'mode-name
               ")   --  "
               ))
