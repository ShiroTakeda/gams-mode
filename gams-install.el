(defun gams-install-get-latest-version ()
  "Fetch the latest GAMS version from the download page asynchronously."
  (interactive)
  (url-retrieve
   "https://www.gams.com/download/"
   (lambda (status)
     (goto-char (point-min))
     (when (search-forward-regexp "Download GAMS Release \\([0-9]+\\.[0-9]+\\.[0-9]+\\)" nil t)
       (message "GAMS Version: %s" (match-string 1))))))
