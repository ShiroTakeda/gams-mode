;;; gams-install.el --- Install GAMS from Emacs -*- lexical-binding: t -*-

;; Author: Christophe Gouel <christophe.gouel@inrae.fr>
;; Maintainer: Christophe Gouel
;; Copyright (C) 2025 Christophe Gouel

;; This file is not part of any Emacs.

;;; License:

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

;;; Code:

(defcustom gams-install-directory nil
  "Custom installation directory for GAMS under Linux.
Outside Linux, it is not possible to customize the installation
directory, so this variable is ignored.
If nil, the default directory will be used:
- Windows: C:\\GAMS
- macOS: /Library/Frameworks/GAMS.framework/Versions
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

(defun gams-install-find-scripts-directory ()
  "Find the directory containing the GAMS installation scripts."
  (let ((package-dir (file-name-directory (locate-library "gams-install"))))
    (if package-dir
        package-dir
      (error "Cannot locate GAMS installation scripts directory"))))

;;;###autoload
(defun gams-install (&optional version)
  "Install GAMS using the installation script.
If VERSION is nil and universal argument is used, ask for version number.
If VERSION is nil and no universal argument, install the latest version."
  (interactive "P")
  (let* ((scripts-dir (gams-install-find-scripts-directory))
         (script-path (cond
                       ((eq system-type 'windows-nt)
                        (expand-file-name "gams_install.ps1" scripts-dir))
                       ((or (eq system-type 'darwin) (eq system-type 'gnu/linux))
                        (expand-file-name "gams_install.sh" scripts-dir))
                       (t (user-error "GAMS installation is not supported on this platform"))))
         (user-version (when (consp version)
                         (read-string "Enter GAMS version number: "))))
    (unless (file-exists-p script-path)
      (user-error "Installation script not found at %s" script-path))

    (if user-version
        (gams-install-run-script script-path user-version)
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
         (buffer-name "*GAMS Installation*")
         (command (if (eq system-type 'windows-nt)
                      (progn
                        (when gams-install-directory
                          (message "Note: Custom installation directory is not supported on Windows and will be ignored"))
                        (format "powershell -ExecutionPolicy Bypass -File \"%s\" %s"
                                script-path
                                version))
                    (format "sh \"%s\" %s %s"
                            script-path
                            version
                            (if gams-install-directory (shell-quote-argument gams-install-directory) "")))))

    ;; Setup the buffer
    (when (get-buffer buffer-name)
      (kill-buffer buffer-name))

    ;; Run the command asynchronously
    (async-shell-command command (get-buffer-create buffer-name))

    ;; Show a simple message
    (message (concat
	      "GAMS installation started."
	      (unless (eq system-type 'windows-nt)
		" Enter your password if prompted.")))))


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
