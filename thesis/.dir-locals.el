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
                        (defun tar/org-latex-src-block (src-block _contents info)
                          "Export SRC-BLOCK as a tcolorbox `codeblock', folding any Org
caption into the box's title and #+name: into the box's label= key."
                          (let* ((lang (or (org-element-property :language src-block) "text"))
                                 (code (org-export-format-code-default src-block info))
                                 (caption (org-export-get-caption src-block))
                                 (caption-str (if caption (org-export-data caption info) ""))
                                 (label (or (org-latex--label src-block info nil nil) "")))
                            (format "\\begin{codeblock}[%s]{%s}{%s}\n%s\\end{codeblock}\n"
                                    caption-str lang label code)))

                        (advice-add 'org-latex-src-block :override #'tar/org-latex-src-block)))
              )))
