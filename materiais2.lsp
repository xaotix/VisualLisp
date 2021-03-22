;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:materiais ()
(setq stringmarca "MAT_PRO")
(alert "SOMENTE PARA 2D! \n NAO Edite Os materiais. Selecione os listados e aplique nas marcas.")
(menu_materiais2)
(if (= cancelei 0)((mensagem_mat2d)(c:dlm_tag_aplica))(Prompt "Cancelado"))
)

(defun mensagem_mat2d()
(alert (strcat "Material " resultado " aplicado."))
)
(defun mensagem_mat3d()
(alert (strcat "Material " resultado " aplicado."))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:3dmateriais ()
(setq stringmarca "MAT_PRO")
 (alert "SOMENTE PARA 3D!\nAplique os materiais\n Somente depois de marcar o modelo.")
(menu_materiais2)
(if (= cancelei 0)((mensagem_mat3d)(C:dlm_tag3d_aplica))(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;inicio rotina para mercadorias - menu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun menu_materiais2 ( / *error* UpdateList data dclfile dclhandle )

 (setq dclFile "dcl.dcl")


 (defun *error* ( msg )

 (if dclHandle (unload_dialog dclHandle))
 (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
  (princ (strcat "\n** Erro: " msg " **")))
 (princ)
 )

 (defun UpdateList ( key lst )
 (start_list key)
 (mapcar 'add_list lst)
 (end_list)
 )

 ;; Inicio da listagem

 (setq Data '(
("Estrutura" ("CIVIL 300" "CIVIL 350" "ZAR345-Z275 ZINC" "A36" "A572GR42" "A572GR50" "SAE1020" "A588" "SAE1008" "SAE1010" "SAE1012" "SAE1018"  "A500" "A501" "A53" "XADREZ A36" "XADREZ ALUM" "SAC300" "SAC350" "SCH40 SAE1008" "SCH40 SAE1008"))
("Telhas" ("ACO INOX" "ALUMINIO" "ALUMINIO ENV" "ALUMINIO PP" "GALVANIZADO" "PP ZINC" "PP GALV" "PP GALV PERF" "PP ZINC PERF"  "ZAR345-Z275 GALV"  "ZINCALUME" "ALUM ESP 1,00"))
)
)



 (cond
 ( (<= (setq dclHandle (load_dialog dclFile)) 0)

 (princ "\n--> Erro fatal.")
 )
 ( (not (new_dialog "materiais2" dclHandle))

 (setq dclHandle (unload_dialog dclHandle))
 (princ "\n--> Erro fatal.")
 )
 ( t
 

 (or *Make* (setq *Make* "0"))
 (or *Model* (setq *Model* "0"))

  
  
 (UpdateList "lst1" (mapcar 'car Data))
 (set_tile "lst1" *Make*)

 
 (UpdateList "lst2" (cadr (nth (atoi *Make*) Data)))
 (set_tile "lst2" *Model*)

 

 (action_tile "lst1"
  (strcat
  "(UpdateList \"lst2\" (setq lst2 (cadr (nth (atoi (setq *Make* $value)) Data))))"
  "(setq *Model*"
  " (set_tile \"lst2\""
  " (if (< (atoi *Model*) (length lst2)) *Model* \"0\")"
  " )"
  ")"
  )
 )

 

 (action_tile "lst2" "(setq *Model* $value)")
	 	 (action_tile "ok" "(setq cancelei 0)(done_dialog)")
	 (action_tile
    "cancel"						
    "(setq cancelei 1)(done_dialog) (prompt \"cancelado\")(princ)"		
    );action_tile
	 (ACTION_TILE "SOBRE" "(mensagem_sobre)")
	   ;; Dialog setup, lets start it:
 (start_dialog)
	 (setq valor1 (atoi *model*))
		(setq resultado (nth valor1 lst2))
	 ;(EXE_CUTA)
	 
 (setq dclHandle (unload_dialog dclHandle))
 )
 )
 (princ)
 
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;