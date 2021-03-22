(defun c:valida_utilidades()
(C:INSTALA_PLOT_PDF2)
(setq filename "C:\\temp")
(setq valida (vl-file-directory-p filename))
(if (= valida T) (prompt (strcat "Verificando se a pasta " filename " existe... OK!\n"))
(vl-mkdir "C:\\temp\\"))

(SETq formato_folha "ISO expand A3 (297.00 x 420.00 MM)")

(setq instal2 (open "C:\\temp\\script_pdf_formato_v0.2.txt" "w"))
(write-line formato_folha instal2)
(close instal2)

(setq instal1 (open "C:\\temp\\script_pdf_v0.2.txt" "w"))
(write-line "C:\\TEMP" instal1)
(close instal1)

(removerappdoinit "PLOT_PDF.VLX")
;;(alert "Instalado com sucesso! \n Feche o Autocad e abra novamente.")
(command "filedia" "1")
(command "_quit")
)


(defun removerappdoinit (filename   /          Default
                               File_List  Fn         Index
                               Regpath    Revision   Startuppath
                               Version
                              )
  ;; codeHimBelonga kdub 2010.11.27
  ;;
  (setq Regpath     "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD"
        revision    (vl-registry-read regpath "CurVer")
        version     (vl-registry-read
                      (setq regpath (strcat regpath "\\" revision))
                      "CurVer"
                    )
        default     (vl-registry-read
                      (setq
                        regpath (strcat regpath "\\" version "\\Profiles")
                      )
                    )
        startupPath (strcat regpath
                            "\\"
                            default
                            "\\Dialogs\\Appload\\Startup"
                    )
        index       0
        file_list   '()
  )
  (while (setq fn (vl-registry-read
                    startupPath
                    (strcat (itoa (setq index (1+ index))) "Startup")
                  )
         )
    (setq file_list (cons fn file_list))
  )
  (setq index    0
        filename (strcase filename)
  )
  (vl-registry-delete startupPath)
  (vl-registry-write startupPath)
  (foreach entry (reverse file_list)
    (if (not (vl-string-search FileName (strcase entry)))
      (progn (vl-registry-write
               startupPath
               (strcat (itoa (setq index (1+ index))) "Startup")
               entry
             )
             (vl-registry-write startupPath "NumStartup" (itoa index))
      )
    )
  )
  (setq index 0
        file_list '()
  )
  (while (setq fn (vl-registry-read
                    startupPath
                    (strcat (itoa (setq index (1+ index))) "Startup")
                  )
         )
    (setq file_list (cons fn file_list))
  )
)