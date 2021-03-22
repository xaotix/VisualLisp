(defun saveVars()
  (setq faceext(get_tile "faceext"))
  (setq faceint(get_tile "faceint"))
)

(defun C:FTELHA()

  ;;;--- Load the dcl file from disk into memory
  (if(not(setq dcl_id (load_dialog "menut.dcl")))
    (progn
      (alert "The DCL file could not be loaded!")
      (exit)
    )

    ;;;--- Else, the dcl file was loaded into memory
    (progn

      ;;;--- Load the definition inside the DCL file
      (if (not(new_dialog "telhas" dcl_id))
        (progn
        (alert "The SAMPLE2 definition could not be loaded!")
          (exit)
        )
  
        ;;;--- Else, the definition was loaded
        (progn

          ;;;--- If an action event occurs, do this function
          (action_tile "accept" "(saveVars)(done_dialog 2)")
          (action_tile "cancel" "(done_dialog 1)")

          ;;;--- Display the dialog box
          (setq ddiag(start_dialog))

          ;;;--- Unload the dialog box
          (unload_dialog dcl_id)

          ;;;--- If the user pressed the Cancel button
          (if(= ddiag 1)
            (princ "\n Cancelado.")
          )

		  
		  
;;;--- If the user pressed the Okay button
  (if(= ddiag 2)
    (progn

      ;;;--- Multiply the users age x 365 to get the number of days.
      ;;;--- Display the results
      (alert (strcat "Somente para chapas pré-pintadas.\n" "\nFace externa: " faceext "\n Face interna: "  faceint "\n \n Clique em ok e selecione as peças."))
	    (aplica_cor_t)
    )
  )		  
        )
      )
    )
  )

  (princ)
)


(defun aplica_cor_t (/ ss i e )
(command "tilemode" "1")
(vl-load-com)
(if (setq ss (ssget '((0 . "INSERT")(66 . 1))))
(repeat (setq i (sslength ss))
(setq e (vlax-ename->vla-object (ssname ss (setq i (1- i)) )))
(if (Eq (strcase (vla-get-effectivename e)) "M8_COM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) "NOT_PEZ")
(vla-put-textstring itm faceext)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_COM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) "TIP_PEZ")
(vla-put-textstring itm faceint)))
)
;
;
(if (Eq (strcase (vla-get-effectivename e)) "M8_LAM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) "NOT_PEZ")
(vla-put-textstring itm faceext)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_LAM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) "TIP_PEZ")
(vla-put-textstring itm faceint)))
)
				(setq p (getpoint "Clique no ponto de insercao do leader: "))
		(setq textloc (getpoint "Clique no ponto de insercao do texto:"))
(command "_leader" p textloc "" (strcat "FACE EXTERNA: " faceext "\n FACE INTERNA: " faceint) "")
)
(Alert "Nenhuma marca foi selecionada!\n Rotina nao foi aplicada.")
)(princ)
(prompt "FINALIZADO!")
)



