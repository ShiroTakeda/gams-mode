;;; gams-install.el --- Install GAMS from Emacs -*- lexical-binding: t -*-

;; Author: Christophe Gouel
;; Maintainer: Christophe Gouel
;; Copyright (C) 2025 Christophe Gouel
;; Keywords: gams, installation
;; Version: 1.00
;; Package-Requires: ((emacs "25.1"))

;; This file is not part of any Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; A copy of the GNU General Public License can be obtained from this
;; program's author or from the Free Software Foundation,
;; Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

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

;;;###autoload
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

;;;###autoload
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
  (let* ((default-directory (file-name-directory script-path))
         (command (concat "sh " (shell-quote-argument script-path) " "
                         (shell-quote-argument version)
                         (when gams-install-directory
                           (concat " " (shell-quote-argument gams-install-directory))))))

    ;; Use compile instead of start-process
    (with-current-buffer (compile command)
      (setq-local compilation-scroll-output t)

      ;; Set process sentinel to clean up
      (set-process-sentinel
       (get-buffer-process (current-buffer))
       (lambda (proc event)
         (when (string-match "finished" event)
           ;; Extract the installation path from the last line of output
           (with-current-buffer (process-buffer proc)
             (save-excursion
               (goto-char (point-max))
               (forward-line -1)
               (when (looking-at "^\\(.+\\)$")
                 (let ((install-path (match-string 1)))
                   ;; Copy path to kill ring
                   (kill-new install-path)
                   ;; Display success message with path
                   (message "GAMS installation completed successfully! GAMS was installed in %s. Remember to add this folder to your PATH!"
                            install-path)))))))))))

;;;###autoload
(defun gams-install-check-installation ()
  "Check if GAMS is already installed and return the version if found."
  (interactive)
  (let ((gams-path (executable-find "gams")))
    (if gams-path
        (let ((version
               (with-temp-buffer
                 ;; Run GAMS without arguments to get version info
                 (call-process gams-path nil t nil)
                 (goto-char (point-min))
                 ;; Look for the version in the standard format
                 (when (re-search-forward "\\*\\*\\* GAMS Release[ \t]*:[ \t]*\\([0-9]+\\.[0-9]+\\.[0-9]+\\)" nil t)
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
