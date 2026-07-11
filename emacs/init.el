;; Packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/")
             '("gnu" . "https://elpa.gnu.org/packages/")
	     )
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Hide startup screen
(setq inhibit-startup-screen t)

;; Hide common UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Disable blinking cursor
(blink-cursor-mode -1)

;; Show line numbers
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

;; Cursor line
(global-hl-line-mode 1)

;; Dark theme
(load-theme 'wombat t)

;; Move by visual lines instead of logical lines
(global-visual-line-mode 1)

;; Scroll margins
(setq scroll-margin 8)
(setq hscroll-margin 8)
(setq scroll-conservatively 101)

;; Font
(set-face-attribute 'default nil
                    :family "MesloLGMDZ Nerd Font Mono"
                    :height 120)

(use-package evil
  :init
  (setq evil-want-integration t
	evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-want-C-i-jump nil
	evil-want-clipboard t
	select-enable-clipboard t
	evil-respect-visual-line-mode t
	)
  :config
  (evil-mode 1)
  )

(use-package tokyonight-themes
  :vc (:url "https://github.com/xuchengpeng/tokyonight-themes")
  :config
  (load-theme 'tokyonight-moon :no-confirm))


;;TODO
;; fuzzy file finder
;; fuzzy ripgrep
;; lsp support
;; - odin
;; - elisp
;; - autocomplete
;; debug support lldb
;; format odin on save
;; tokyonight-moon
;;

