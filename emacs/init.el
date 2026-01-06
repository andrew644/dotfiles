;; Package setup
(require 'package)
(setq package-archives
	  '(
		("melpa" . "https://melpa.org/packages/")
		("gnu" . "https://elpa.gnu.org/packages/")
		)
	  )

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-integration t
		evil-want-keybinding nil
		evil-want-C-u-scroll t
		evil-want-C-i-jump nil
		)
  :config
  (evil-mode 1)
  )

;; Theme
(use-package tokyonight-themes
  :vc (:url "https://github.com/xuchengpeng/tokyonight-themes")
  :config
  (load-theme 'tokyonight-moon :no-confirm))

;;;;;;;;;;;;;;;;
;; Settings
;;;;;;;;;;;;;;;;
(setq-default tab-width 4)

;; Remove ui
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Use system clipboard
(setq select-enable-clipboard t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((tokyonight-themes :url
			"https://github.com/xuchengpeng/tokyonight-themes"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
