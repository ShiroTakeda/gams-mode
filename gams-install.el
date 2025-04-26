;;; gams-install.el --- Install GAMS from Emacs -*- lexical-binding: t -*-

;; Author: Christophe Gouel
;; Keywords: gams, installation
;; Version: 0.1
;; Package-Requires: ((emacs "25.1"))

;;; Commentary:
;; This package provides functions to install GAMS directly from Emacs.
;; Currently supports macOS and Linux platforms.

;;; Code:

(defcustom gams-install-directory nil
  "Custom installation directory for GAMS.
If nil, the default directory will be used:
- macOS: /Applications/GAMS
- Linux: /opt/gams"
  :type 'string
  :group 'gams)

(defun gams-install-get-latest-version (&optional callback)
  "Fetch the latest GAMS version from the download page asynchronously.
If CALLBACK is provided, call it with the version as argument when done."
  (interactive)
  (url-retrieve
   "https://www.gams.com/download/"
   (lambda (status)
     (goto-char (point-min))
     (when (search-forward-regexp "Download GAMS Release \\([0-9]+\\.[0-9]+\\.[0-9]+\\)" nil t)
       (let ((version (match-string 1)))
         (message "Latest GAMS version is %s" version)
         (when callback
           (funcall callback version))
         version)))))

(defun gams-install (&optional version)
  "Install GAMS using the installation script.
If VERSION is nil, install the latest version.
Only works on macOS and Linux."
  (interactive)
  (if (not (or (eq system-type 'darwin) (eq system-type 'gnu/linux)))
      (user-error "GAMS installation is only supported on macOS and Linux")
    (let* ((package-dir (file-name-directory (or load-file-name buffer-file-name)))
           (script-path (expand-file-name "gams_install.sh" package-dir)))
      (unless (file-exists-p script-path)
        (user-error "Installation script not found at %s" script-path))

      (if version
          (gams-install-run-script script-path version)
        (message "Fetching latest GAMS version...")
        (gams-install-get-latest-version
         (lambda (latest-version)
           (gams-install-run-script script-path latest-version)))))))

(defun gams-install-run-script (script-path version)
  "Run the GAMS installation SCRIPT-PATH with VERSION."
  (message "Installing GAMS version %s..." version)
  (let ((default-directory (file-name-directory script-path))
        (buffer (get-buffer-create "*GAMS Installation*"))
        (args (list version)))

    ;; Add custom installation directory if specified
    (when gams-install-directory
      (setq args (append args (list gams-install-directory))))

    (with-current-buffer buffer
      (erase-buffer)
      (display-buffer buffer)
      (let ((process (apply #'start-process "gams-install" buffer "sh" script-path args)))
        (set-process-sentinel
         process
         (lambda (proc event)
           (when (string-match "finished" event)
             (message "GAMS installation completed successfully!"))))))))

(defun gams-install-check-installation ()
  "Check if GAMS is already installed and return the version if found."
  (interactive)
  (let ((gams-path (executable-find "gams")))
    (if gams-path
        (let ((version
               (with-temp-buffer
                 (call-process gams-path nil t nil "lo=3")
                 (goto-char (point-min))
                 (when (re-search-forward "GAMS Release \\([0-9]+\\.[0-9]+\\.[0-9]+\\)" nil t)
                   (match-string 1)))))
          (if version
              (progn
                (message "GAMS %s is installed at %s" version gams-path)
                version)
            (message "GAMS is installed at %s but version could not be determined" gams-path)
            t))
      (message "GAMS is not installed or not in PATH")
      nil)))

(provide 'gams-install)
;;; gams-install.el ends here
