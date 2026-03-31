((org-mode . ((eval . (defun tar/acks-as-section (headline backend info)
                        "Export Acknowledgements heading as \\section instead of \\chapter."
                        (when (org-export-derived-backend-p backend 'latex)
                          (replace-regexp-in-string
                           "\\\\chapter\\*{\\(Acknowledgements\\)}"
                           "\\\\section*{\\1}"
                           headline))))

              (eval . (defun tar/abstract-as-section (headline backend info)
                        "Export Abstract heading as \\section instead of \\chapter; put it on a new page too."
                        (when (org-export-derived-backend-p backend 'latex)
                          (replace-regexp-in-string
                           "\\\\chapter\\*{\\(Abstract\\)}"
                           "\\\\newpage\n\\\\section*{\\1}"
                           headline))))

              (eval . (defun tar/intro-in-toc (headline backend info)
                        "Add the Introduction to the table of contents."
                        (when (org-export-derived-backend-p backend 'latex)
                          (replace-regexp-in-string
                           "\\(\\\\label{sec:intro}\\)"
                           "\\1\n\\\\addcontentsline{toc}{chapter}{\\\\nameref{sec:intro}}"
                           headline))))

              ;; (eval . (defun tar/display-minitoc (headline backend info)
              ;;           "Add minitoc to the start of each chapter."
              ;;           (when (org-export-derived-backend-p backend 'latex)
              ;;             (replace-regexp-in-string
              ;;              "\\(\\\\chapter{.+}\n\\\\label{.+}\\)"
              ;;              "\\1\n\\\\minitoc\n\\\\newpage"
              ;;              headline))))
              )))
