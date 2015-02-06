(message "%s" "customise-packages: Checking for packages to install...")

(defvar my-packages
  '(
    ;; Themes
    ample-zen
    atom-dark-theme

    ;; Code related packages


    ;; Random packages
    nethack
  )
  "The list of packages I would like to have installed automatcally on startup."
)


(defun my-check-packages-p ()
  "Checks to see if all of the packages are installed."
)

(message "%s" "customise-packages: Done.")
(provide 'customise-packages)
