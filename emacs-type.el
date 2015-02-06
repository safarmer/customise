;;; emacs-type.el --- predicates for emacs version and system

(defvar emacs21 (string< "GNU Emacs 21" (emacs-version)))
(if emacs21
    (setq emacs-type 'emacs-21))

(defvar emacs22 (string< "GNU Emacs 22" (emacs-version)))
(if emacs22
    (setq emacs-type 'emacs-22))

(defvar emacs23 (>= emacs-major-version 23))
(if emacs23
    (setq emacs-type 'emacs-23))

(defmacro vboundp (sym)
  "Return t if SYM is bound as a variable and non-nil."
  `(and (boundp ',sym) ,sym))
  
(defvar xemacsp (vboundp xemacsp))

(defvar running-x (eq window-system 'x)
  "True if running under X-Windows")

(defmacro if-terminal (&rest then-forms)
  "If we're running in terminal-mode, evaluate THEN-FORMS."
  `(if (not window-system)
       (progn ,@then-forms)))

(defmacro if-not-terminal (&rest then-forms)
  "If we're running in windowed-mode, evaluate THEN form.
Otherwise evaluate optional ELSE forms."
  `(if window-system
       (progn ,@then-forms)))

(defmacro if-not-xemacs (&rest args)
  "Evaluate forms in ARGS iff this is FSF Emacs."
  `(if (not xemacsp)
       (progn ,@args)))

(defmacro if-xemacs (&rest args)
  "Evaluate forms in ARGS iff this is XEmacs."
  `(if xemacsp
       (progn ,@args)))

;; not sure what system-type is for NT XEmacs...
(defmacro if-win32 (&rest args)
  "Evaluate forms in ARGS iff this is NT Emacs."
  `(if (eq system-type 'windows-nt)
       (progn ,@args)))

(defmacro if-not-win32 (&rest args)
  "Evaluate forms in ARGS iff this is not NT Emacs."
  `(unless (eq system-type 'windows-nt)
       (progn ,@args)))

(defvar win32 (eq system-type 'windows-nt))
(defvar terminal (eq window-system nil))

;; computer names
(defvar hostname (or (getenv "HOSTNAME")
		     ;; really need a (string-trim) function
		     (car (split-string (shell-command-to-string "hostname")))
		     ""))

;; true across any system of these types
(defvar cygwin (eq system-type 'cygwin))
(defvar winnt (eq system-type 'windows-nt))
(defvar linux (eq system-type 'gnu/linux))

;; linux personal-CVS server in Westin building
(defvar opal (or (string-equal hostname "opal")
		 (string-equal hostname "opal.cabochon.com")))

(defvar macos (eq system-type 'darwin))
(defvar darwin macos)

;; true for desktop (linux) box at google
(defvar google (and (not darwin)
                    (or (string-match ".desktop$" hostname)
                        (string-match ".google.com$" hostname))))

(defvar ruby
  (or (string-equal hostname "RUBY")
      (string-equal hostname "ruby"))
  "Always true on home XP desktop box, regardless of Emacs version.")

(defvar ruby-cygwin (and ruby (eq system-type 'cygwin))
  "True if we think we're running Cygwin Emacs on home XP box.")

(defvar ruby-nt (and ruby (not ruby-cygwin))
  "True if we think we're running NT Emacs on my home XP box.")

(defvar work-laptop
  (let ((index (string-match "^syegge-" hostname)))
    (and (not (null index)) (zerop index)))
  "True if we think we're running on my Google laptop.")

(setq 
 system-name
 (cond
  ((string-match "google\\.com$" hostname)
   hostname)
  (ruby "ruby.cablespeed.com")
  (work-laptop hostname)
  (t
   (concat hostname ".cabochon.com"))))

;; XEmacs doesn't have `replace-regexp-in-string', which I use a lot
(and xemacsp
     (not (fboundp 'replace-regexp-in-string))
  (defun replace-regexp-in-string
    (regexp rep str &optional fixedcase literal subexp start)
    (replace-in-string str regexp rep literal)))

(provide 'emacs-type)

;;; emacs-type ends here
