;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "rzm"
      user-mail-address "rzm@kount.com")

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

;; helps the go lsp work mo' bettah
(setq lsp-enable-file-watchers nil)

;; some debugger libs for webdev to assist with react work. disable at your leisure
(require 'dap-chrome)
(require 'dap-node)
(require 'dap-ui)

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
