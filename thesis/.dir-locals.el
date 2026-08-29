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

              (eval . (progn
                        (defun tar/org-latex-src-block-wrap-tcolorbox (text backend info)
                          "Wrap minted environments in a tcolorbox codeblock"
                          (when (org-export-derived-backend-p backend 'latex)
                            (replace-regexp-in-string
                             "\\\\begin{minted}\\(\\[.*?\\]\\)?{\\([a-zA-Z0-9+-]+\\)}"
                             "\\\\begin{codeblock}{\\2}"
                             (replace-regexp-in-string "\\\\end{minted}" "\\\\end{codeblock}" text))))

                        (add-to-list 'org-export-filter-src-block-functions
                                     'tar/org-latex-src-block-wrap-tcolorbox)))
              )))
