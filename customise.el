;; customise.el
;;
;; Main entry point to my customisations. This will pull in all the other
;; modules as required.

(message "%s" "customise: Loading customisations...")

(require 'customise-packages)
(require 'customise-code)

;;------------------------------------------------------
;; General configurations
;;------------------------------------------------------

;; Backup file handling.
(setq
  backup-by-copying t  ; don't clobber symlinks
  backup-directory-alist '(("." . "~/.emacs.d/.saves"))  ; don't litter my fs tree
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t  ; use versioned backups
)

;; Mouse handling
(xterm-mouse-mode t)
(if (fboundp 'mouse-wheel-mode)
  (mouse-wheel-mode t)
)

;; Tabs/indentation.
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Show line-number in the mode line
(line-number-mode 1)
(setq linum-format "%4d \u2502 ")

;; Show column-number in the mode line
(column-number-mode 1)

(message "%s" "customise: Done loading customisations")
(provide 'customise)
