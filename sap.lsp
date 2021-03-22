(defun c:cfg_plot_pdf ( / )
(setq dcl_id (load_dialog "menu.dcl"))
  (if (not (new_dialog "formatoDCL" dcl_id))
    (exit)
  )
(action_tile
    "cancel"						
    "(done_dialog) (prompt \"cancelado\")(princ)"		
    );action_tile
  (action_tile "accept" "(obtem_dados)")
  (action_tile "sobre" "(mensagem_sobre)")
  (start_dialog)
  (FORMATODCL)
  (unload_dialog dcl_id)
	  (princ)
)





;;; configuraÃ§ão folha
(defun c:plot_pdf ( / )

;;NOVO
(setq filename "C:\\plot_pdf")
(setq valida (vl-file-directory-p filename))
(if (= valida T) (prompt (strcat "Verificando se a pasta " filename " existe... OK!\n"))
((alert "É necessário atualizar o plot_pdf. Feche o CAD e abra novamente. Caso veja esta mensagem novamente ao executar o comando, execute o comando INSTALA_PLOT_PDF2")(C:INSTALA_PLOT_PDF2)(command "quit")))
(C:PLOT_PDF2)
;;FIM NOVO


;;(setq dcl_id (load_dialog "menu.dcl"))
;;  (if (not (new_dialog "formatoDCL" dcl_id))
;;    (exit)
;;  )
;;(action_tile
;;    "cancel"						
;;    "(setq cancelei 1)(done_dialog) (prompt \"cancelado\")(princ)"		
;;    );action_tile
;;  (action_tile "accept" "(setq cancelei 0)(obtem_dados)")
;;  (action_tile "sobre" "(mensagem_sobre)")
;;  (start_dialog)
;;  (FORMATODCL)
;;  (unload_dialog dcl_id)
;;  (if (= cancelei 0)(SELETOR_DIRETORIO)(Prompt "Cancelado"))
;;    ;(SELETOR_DIRETORIO)
;;	  (princ)
)







(defun FORMATODCL ()
(if (= A4 "1")
(SETq formato_folha "ISO expand A4 (210.00 x 297.00 MM)")

	)
(if (= A3 "1")
(SETq formato_folha "ISO expand A3 (297.00 x 420.00 MM)")

	)
(if (= A2 "1")
(SEtq formato_folha "ISO expand A2 (420.00 x 594.00 MM)")

	)
)
(defun obtem_dados ()
	(setq A4 (get_tile "A4"))
	(setq A3  (get_tile "A3"))
	(setq A2 (get_tile "A2"))
  (done_dialog)
;(setq scriptname3 (open "c:\\temp\\script_pdf_formato_v0.2.txt" "w"))
;(write-line formato_folha scriptname3)
;(close scriptname3)	  
  )
  
(defun mensagem_sobre()
(c:dlmutilidadessobre))
  




;;gerador de pdfs
(setq formato2 (getvar "tilemode"))
(setq peganome (getvar "dwgname"))
(setq comprimento (-(strlen peganome) 4))
(setq arrumanome (substr peganome 1 comprimento))
(setq diretorio (getvar "dwgprefix"))
 (setq lerdir_pdf (open "c:\\temp\\script_pdf_v0.2.txt" "r"))
 (setq saida_pdf (read-line lerdir_pdf))
 (close lerdir_pdf)
 (setq lerformato (open "c:\\temp\\script_pdf_formato_v0.2.txt" "r"))
 (setq formato (read-line lerformato))
 (close lerformato)
(setq resultado_nome (strcat saida_pdf "\\" arrumanome ".pdf"))
(setq resultado_nome2 (strcat (getvar "dwgprefix") "PDF\\" arrumanome ".pdf"))
(setq pasta_pdf2 (strcat (getvar "dwgprefix") "PDF\\"))
;
;
;
(defun c:gerar_pdf_s2(/)
(setq pasta_pdf2 (strcat (getvar "dwgprefix") "PDF\\"))
(setq valida (vl-file-directory-p pasta_pdf2))
(if (= valida T)(prompt "Validando Pasta...ok")(vl-mkdir pasta_pdf2))
;
;
;
(setq resultado_nome (strcat (getvar "dwgprefix") "PDF\\" arrumanome ".pdf"))
(if (= 1 formato2) (gerar_model))
(if (= 0 formato2) (gerar_layout))
)
;
;
(defun c:gerar_pdf_s(/)
;
;
;
(if (= 1 formato2) (gerar_model))
(if (= 0 formato2) (gerar_layout))
)
;
;
;
(defun gerar_model(/) 
;;GERAR PARA MODEL
(command "-plot" "yes" "" "DWG To PDF.pc3" FORMATO
"m" "landscape" "no" "e" "fit" "center" "yes" "penas.ctb"
"yes" "AS" resultado_nome "n" "y")
)
;
;
;
;
;
;
;
(defun gerar_layout(/) 
;;gerar para layout
(command "-plot" "yes" "" "DWG To PDF.pc3" FORMATO 
"m" "landscape" "no" "e" "fit" "center" "yes" "penas.ctb"
"yes" "n" "n" "n" resultado_nome "n" "y")
)
;
;
;
;
;
;
;
;

;
;
;

(defun DirectoryDialog ( msg dir flag / Shell Fold Self Path )
  (vl-catch-all-apply
    (function
      (lambda ( / ac HWND )
        (if
          (setq Shell (vla-getInterfaceObject (setq ac (vlax-get-acad-object)) "Shell.Application")
                HWND  (vl-catch-all-apply 'vla-get-HWND (list ac))
                Fold  (vlax-invoke-method Shell 'BrowseForFolder (if (vl-catch-all-error-p HWND) 0 HWND) msg flag dir)
          )
          (setq Self (vlax-get-property Fold 'Self)
                Path (vlax-get-property Self 'Path)
                Path (vl-string-right-trim "\\" (vl-string-translate "/" "\\" Path))
          )
        )
      )
    )
  )
  (if Self  (vlax-release-object  Self))
  (if Fold  (vlax-release-object  Fold))
  (if Shell (vlax-release-object Shell))
  Path
)





(defun SELETOR_DIRETORIO nil
;	(setq A4 (get_tile "A4"))
;	(setq A3  (get_tile "A3"))
;	(setq A2 (get_tile "A2"))
;  (done_dialog)
;
(setq scriptname3 (open "c:\\temp\\script_pdf_formato_v0.2.txt" "w"))
(write-line formato_folha scriptname3)
(close scriptname3)


    (SETQ LISTA (LM:getfiles "Gerar PDFs - V0.4D" "" "dwg;dxf"))
	

	
	
	;(setq fldr (directorydialog "Selecione a pasta da etapa:\n(o diretorio PDF sera criado automaticamente)" "F:\\" 512))
	(if (= tmload T)
	(setq fldr (directorydialog "Selecione a pasta da etapa:\n(o diretorio PDF sera criado automaticamente)" tm_com  512))
	(setq fldr (directorydialog "Selecione a pasta da etapa:\n(o diretorio PDF sera criado automaticamente)" "F:\\" 512))
	)
(setq valida_pasta (vl-string-search ".TEC/PDF/" (strcase (STRCAT fldr "/PDF/"))))		

(setq diretorio (getvar "dwgprefix"))
(setq arquivo_scr (strcat "c:\\temp\\"  "script_pdf_v0.2.scr"))
(setq arquivo_cfg (strcat   "c:\\temp\\" "script_pdf_v0.2.txt"))

(setq pastapdf (strcat fldr "\\PDF"))
(setq valida (vl-file-directory-p pastapdf))




(if (> valida_pasta 1)
(
;(alert (strcat "Pasta criada: " fldr "/PDF\n Clique em Ok e aguarde enquanto os arquivos serão gerados."))
;(acet-file-mkdir (strcat fldr "\\PDF"))


(if (= valida T) 
((prompt (strcat "Verificando se a pasta " pastapdf " existe... OK!\n"))(alert (strcat "Pasta " pastapdf " já existe. Os arquivos PDFs serão salvos nela.")))
((alert (strcat "Pasta " pastapdf " criada. Os arquivos PDFs serão salvos nela."))(vl-mkdir (strcat fldr "\\PDF"))))



(if lista
(progn
(setq scriptname (open arquivo_scr "w")
count 0
)
(while (setq filename (nth count LISTA))
(setq gerarp (strcat (chr 40)"c:gerar_pdf_s"(chr 41)))
;(setq finalizei (strcat (chr 40)"Alert \"Processo finalizado!\""(chr 41)))
(write-line (strcat "_open \"" filename "\"") scriptname)
(setq tbm1 (-(strlen FILENAME) 2))
(setq ttr2 (substr filename tbm1 3))
(if (= "DWG" TTR2) (setq salvar1 "n"))
(if (= "DXF" TTR2) (setq salvar1 "y" ))
(if (= "dwg" TTR2) (setq salvar1 "n"))
(if (= "dxf" TTR2) (setq salvar1 "y" ))
;(write-line formatofolha scriptname)
(write-line "_zoom e" scriptname)
(write-line gerarp scriptname)
(write-line "_close" scriptname)
(write-line salvar1 scriptname)
(setq count (1+ count))
)
;(write-line finalizei scriptname)
(close scriptname)
;;;
(setq scriptname2 (open arquivo_cfg "w"))
(write-line (strcat fldr "\\PDF") scriptname2)
(close scriptname2)
)
)
(command "FILEDIA" "0")
(command "SCRIPT" arquivo_scr "filedia" "1")
;(alert "Processo finalizado com exito!")
(princ)

)
;else


((alert (strcat "Pasta selecionada: " fldr "\n \n Pasta de destino inválida. \n A pasta deve ser uma pasta de etapa.\n Se for um pacote de CAMs, selecione a etapa referente a eles, onde estão os projetos de fabricação."))
(SELETOR_DIRETORIO))
))
;
;
;
;
;
;;
;
;
;ACHAR DIRETORIOS E ARQUIVOS


(defun LM:getfiles ( msg def ext / *error* dch dcl des dir dirdata lst rtn )

    (defun *error* ( msg )
        (if (= 'file (type des))
            (close des)
        )
        (if (and (= 'int (type dch)) (< 0 dch))
            (unload_dialog dch)
        )
        (if (and (= 'str (type dcl)) (findfile dcl))
            (vl-file-delete dcl)
        )
        (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*")))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )    
    
    (if
        (and
            (setq dcl (vl-filename-mktemp nil nil ".dcl"))
            (setq des (open dcl "w"))
            (progn
                (foreach x
                   '(
                        "lst : list_box"
                        "{"
                        "    width = 40.0;"
                        "    height = 20.0;"
                        "    fixed_width = true;"
                        "    fixed_height = true;"
                        "    alignment = centered;"
                        "    multiple_select = true;"
                        "}"
                        "but : button"
                        "{"
                        "    width = 20.0;"
                        "    height = 1.8;"
                        "    fixed_width = true;"
                        "    fixed_height = true;"
                        "    alignment = centered;"
                        "}"
                        "getfiles : dialog"
                        "{"
                        "    key = \"title\"; spacer;"
                        "    : row"
                        "    {"
                        "        alignment = centered;"
                        "        : edit_box { key = \"dir\"; label = \"Pasta:\"; }"
                        "        : button"
                        "        {"
                        "            key = \"brw\";"
                        "            label = \"Browse\";"
                        "            fixed_width = true;"
                        "        }"
                        "    }"
                        "    spacer;"
                        "    : row"
                        "    {"
                        "        : column"
                        "        {"
                        "            : lst { key = \"box1\"; }"
                        "            : but { key = \"add\" ; label = \"Adicionar arquivos\"; }"
                        "        }"
                        "        : column {"
                        "            : lst { key = \"box2\"; }"
                        "            : but { key = \"del\" ; label = \"Remover arquivos\"; }"
                        "        }"
                        "    }"
                        ": button {"
						"label = \"Continuar\";"
						"key = \"accept\";"
						"width = 12;"
						"fixed_width = true;"
						"mnemonic = \"O\";"
						"is_default = true;"
						"alignment = centered;"
						"}"
                        "}"
                    )
                    (write-line x des)
                )
                (setq des (close des))
                (< 0 (setq dch (load_dialog dcl)))
            )
            (new_dialog "getfiles" dch)
        )
        (progn
            (setq ext (if ext (LM:getfiles:str->lst (strcase ext) ";") '("*")))
            (set_tile "title" (if (member msg '(nil "")) "Selecione os arquivos" msg))
            (set_tile "dir"
                (setq dir
                    (LM:getfiles:fixdir
                        (if (or (member def '(nil "")) (not (vl-file-directory-p (LM:getfiles:fixdir def))))
                            (getvar 'dwgprefix)
                            def
                        )
                    )
                )
            )
            (setq lst (LM:getfiles:updatefilelist dir ext nil))
            (mode_tile "add" 1)
            (mode_tile "del" 1)
			  (action_tile "brw"
                (vl-prin1-to-string
                   '(if (setq tmp (LM:getfiles:browseforfolder "" nil 512))
                        (setq lst (LM:getfiles:updatefilelist (set_tile "dir" (setq dir tmp)) ext rtn)
                              rtn (LM:getfiles:updateselected dir rtn)
                        )                              
                    )
                )
            )

            (action_tile "dir"
                (vl-prin1-to-string
                   '(if (= 1 $reason)
                        (setq lst (LM:getfiles:updatefilelist (set_tile "dir" (setq dir (LM:getfiles:fixdir $value))) ext rtn)
                              rtn (LM:getfiles:updateselected dir rtn)
                        )
                    )
                )
            )

            (action_tile "box1"
                (vl-prin1-to-string
                   '(
                        (lambda ( / itm tmp )
                            (if (setq itm (mapcar '(lambda ( n ) (nth n lst)) (read (strcat "(" $value ")"))))
                                (if (= 4 $reason)
                                    (cond
                                        (   (equal '("..") itm)
                                            (setq lst (LM:getfiles:updatefilelist (set_tile "dir" (setq dir (LM:getfiles:updir dir))) ext rtn)
                                                  rtn (LM:getfiles:updateselected dir rtn)
                                            )
                                        )
                                        (   (and
                                                (not (vl-filename-extension (car itm)))
                                                (vl-file-directory-p (setq tmp (LM:getfiles:checkredirect (strcat dir "\\" (car itm)))))
                                            )
                                            (setq lst (LM:getfiles:updatefilelist (set_tile "dir" (setq dir tmp)) ext rtn)
                                                  rtn (LM:getfiles:updateselected dir rtn)
                                            )
                                        )
                                        (   (setq rtn (LM:getfiles:sort (append rtn (mapcar '(lambda ( x ) (strcat dir "\\" x)) itm)))
                                                  rtn (LM:getfiles:updateselected dir rtn)
                                                  lst (LM:getfiles:updatefilelist dir ext rtn)
                                            )
                                        )
                                    )
                                    (if (vl-some 'vl-filename-extension itm)
                                        (mode_tile "add" 0)
                                    )
                                )
                            )
                        )
                    )
                )
            )

            (action_tile "box2"
                (vl-prin1-to-string
                   '(
                        (lambda ( / itm )
                            (if (setq itm (mapcar '(lambda ( n ) (nth n rtn)) (read (strcat "(" $value ")"))))
                                (if (= 4 $reason)
                                    (setq rtn (LM:getfiles:updateselected dir (vl-remove (car itm) rtn))
                                          lst (LM:getfiles:updatefilelist dir ext rtn)
                                    )
                                    (mode_tile "del" 0)
                                )
                            )
                        )
                    )
                )
            )

            (action_tile "add"
                (vl-prin1-to-string
                   '(
                        (lambda ( / itm )
                            (if (setq itm
                                    (vl-remove-if-not 'vl-filename-extension
                                        (mapcar '(lambda ( n ) (nth n lst)) (read (strcat "(" (get_tile "box1") ")")))
                                    )
                                )
                                (setq rtn (LM:getfiles:sort (append rtn (mapcar '(lambda ( x ) (strcat dir "\\" x)) itm)))
                                      rtn (LM:getfiles:updateselected dir rtn)
                                      lst (LM:getfiles:updatefilelist dir ext rtn)
                                )
                            )
                            (mode_tile "add" 1)
                            (mode_tile "del" 1)
                        )
                    )
                )
            )

            (action_tile "del"
                (vl-prin1-to-string
                   '(
                        (lambda ( / itm )
                            (if (setq itm (read (strcat "(" (get_tile "box2") ")")))
                                (setq rtn (LM:getfiles:updateselected dir (LM:getfiles:removeitems itm rtn))
                                      lst (LM:getfiles:updatefilelist dir ext rtn)
                                )
                            )
                            (mode_tile "add" 1)
                            (mode_tile "del" 1)
                        )
                    )
                )
            )
         
            (if (zerop (start_dialog))
                (setq rtn nil)
            )
        )
    )
    (*error* nil)
    rtn
)

(defun LM:getfiles:listbox ( key lst )
    (start_list key)
    (foreach x lst (add_list x))
    (end_list)
    lst
)

(defun LM:getfiles:listfiles ( dir ext lst )
    (vl-remove-if '(lambda ( x ) (member (strcat dir "\\" x) lst))
        (cond
            (   (cdr (assoc dir dirdata)))
            (   (cdar
                    (setq dirdata
                        (cons
                            (cons dir
                                (append
                                    (LM:getfiles:sortlist (vl-remove "." (vl-directory-files dir nil -1)))
                                    (LM:getfiles:sort
                                        (if (member ext '(("") ("*")))
                                            (vl-directory-files dir nil 1)
                                            (vl-remove-if-not
                                                (function
                                                    (lambda ( x / e )
                                                        (and
                                                            (setq e (vl-filename-extension x))
                                                            (setq e (strcase (substr e 2)))
                                                            (vl-some '(lambda ( w ) (wcmatch e w)) ext)
                                                        )
                                                    )
                                                )
                                                (vl-directory-files dir nil 1)
                                            )
                                        )
                                    )
                                )
                            )
                            dirdata
                        )
                    )
                )
            )
        )
    )
)

(defun LM:getfiles:checkredirect ( dir / itm pos )
    (cond
        (   (vl-directory-files dir) dir)
        (   (and
                (=  (strcase (getenv "UserProfile"))
                    (strcase (substr dir 1 (setq pos (vl-string-position 92 dir nil t))))
                )
                (setq itm
                    (cdr
                        (assoc (substr (strcase dir t) (+ pos 2))
                           '(
                                ("my documents" . "Documents")
                                ("my pictures"  . "Pictures")
                                ("my videos"    . "Videos")
                                ("my music"     . "Music")
                            )
                        )
                    )
                )
                (vl-file-directory-p (setq itm (strcat (substr dir 1 pos) "\\" itm)))
            )
            itm
        )
        (   dir   )
    )
)

(defun LM:getfiles:sort ( lst )
    (apply 'append
        (mapcar 'LM:getfiles:sortlist
            (vl-sort
                (LM:getfiles:groupbyfunction lst
                    (lambda ( a b / x y )
                        (and
                            (setq x (vl-filename-extension a))
                            (setq y (vl-filename-extension b))
                            (= (strcase x) (strcase y))
                        )
                    )
                )
                (function
                    (lambda ( a b / x y )
                        (and
                            (setq x (vl-filename-extension (car a)))
                            (setq y (vl-filename-extension (car b)))
                            (< (strcase x) (strcase y))
                        )
                    )
                )
            )
        )
    )
)

(defun LM:getfiles:sortlist ( lst )
    (mapcar (function (lambda ( n ) (nth n lst)))
        (vl-sort-i (mapcar 'LM:getfiles:splitstring lst)
            (function
                (lambda ( a b / x y )
                    (while
                        (and
                            (setq x (car a))
                            (setq y (car b))
                            (= x y)
                        )
                        (setq a (cdr a)
                              b (cdr b)
                        )
                    )
                    (cond
                        (   (null x) b)
                        (   (null y) nil)
                        (   (and (numberp x) (numberp y)) (< x y))
                        (   (= "." x))
                        (   (numberp x))
                        (   (numberp y) nil)
                        (   (< x y))
                    )
                )
            )
        )
    )
)

(defun LM:getfiles:groupbyfunction ( lst fun / tmp1 tmp2 x1 )
    (if (setq x1 (car lst))
        (progn
            (foreach x2 (cdr lst)
                (if (fun x1 x2)
                    (setq tmp1 (cons x2 tmp1))
                    (setq tmp2 (cons x2 tmp2))
                )
            )
            (cons (cons x1 (reverse tmp1)) (LM:getfiles:groupbyfunction (reverse tmp2) fun))
        )
    )
)

(defun LM:getfiles:splitstring ( str )
    (
        (lambda ( l )
            (read
                (strcat "("
                    (vl-list->string
                        (apply 'append
                            (mapcar
                                (function
                                    (lambda ( a b c )
                                        (cond
                                            (   (= 92 b)
                                                (list 32 34 92 b 34 32)
                                            )
                                            (   (or (< 47 b 58)
                                                    (and (= 45 b) (< 47 c 58) (not (< 47 a 58)))
                                                    (and (= 46 b) (< 47 a 58) (< 47 c 58))
                                                )
                                                (list b)
                                            )
                                            (   (list 32 34 b 34 32))
                                        )
                                    )
                                )
                                (cons nil l) l (append (cdr l) '(( )))
                            )
                        )
                    )
                    ")"
                )
            )
        )
        (vl-string->list (strcase str))
    )
)

(defun LM:getfiles:browseforfolder ( msg dir flg / err fld pth shl slf )
    (setq err
        (vl-catch-all-apply
            (function
                (lambda ( / app hwd )
                    (if (setq app (vlax-get-acad-object)
                              shl (vla-getinterfaceobject app "shell.application")
                              hwd (vl-catch-all-apply 'vla-get-hwnd (list app))
                              fld (vlax-invoke-method shl 'browseforfolder (if (vl-catch-all-error-p hwd) 0 hwd) msg flg dir)
                        )
                        (setq slf (vlax-get-property fld 'self)
                              pth (LM:getfiles:fixdir (vlax-get-property slf 'path))
                        )
                    )
                )
            )
        )
    )
    (if slf (vlax-release-object slf))
    (if fld (vlax-release-object fld))
    (if shl (vlax-release-object shl))
    (if (vl-catch-all-error-p err)
        (prompt (vl-catch-all-error-message err))
        pth
    )
)

(defun LM:getfiles:full->relative ( dir path / p q )
    (setq dir (vl-string-right-trim "\\" dir))
    (cond
        (   (and
                (setq p (vl-string-position 58  dir))
                (setq q (vl-string-position 58 path))
                (/= (strcase (substr dir 1 p)) (strcase (substr path 1 q)))
            )
            path
        )
        (   (and
                (setq p (vl-string-position 92  dir))
                (setq q (vl-string-position 92 path))
                (= (strcase (substr dir 1 p)) (strcase (substr path 1 q)))
            )
            (LM:getfiles:full->relative (substr dir (+ 2 p)) (substr path (+ 2 q)))
        )
        (   (and
                (setq q (vl-string-position 92 path))
                (= (strcase dir) (strcase (substr path 1 q)))
            )
            (strcat ".\\" (substr path (+ 2 q)))
        )
        (   (= "" dir)
            path
        )
        (   (setq p (vl-string-position 92 dir))
            (LM:getfiles:full->relative (substr dir (+ 2 p)) (strcat "..\\" path))
        )
        (   (LM:getfiles:full->relative "" (strcat "..\\" path)))
    )
)

(defun LM:getfiles:str->lst ( str del / pos )
    (if (setq pos (vl-string-search del str))
        (cons (substr str 1 pos) (LM:getfiles:str->lst (substr str (+ pos 1 (strlen del))) del))
        (LIST str)
    )
)

(defun LM:getfiles:updatefilelist ( dir ext lst )
    (LM:getfiles:listbox "box1" (LM:getfiles:listfiles dir ext lst))
)

(defun LM:getfiles:updateselected ( dir lst )
    (LM:getfiles:listbox "box2" (mapcar '(lambda ( x ) (LM:getfiles:full->relative dir x)) lst))
    lst
)

(defun LM:getfiles:updir ( dir )
    (substr dir 1 (vl-string-position 92 dir nil t))
)

(defun LM:getfiles:fixdir ( dir )
    (vl-string-right-trim "\\" (vl-string-translate "/" "\\" dir))
)

(defun LM:getfiles:removeitems ( itm lst / idx )
    (setq idx -1)
    (vl-remove-if '(lambda ( x ) (member (setq idx (1+ idx)) itm)) lst)
)

(vl-load-com) (princ)
(vl-load-com) (princ)
;;;;;;;;;;;;
;
;
;
;;
;
;
;
;
;
;
;
;;
;
;;;------
;------ inicio gerar_dwt-------;
(defun c:bota_nome ()
(command "tec_lsdwt" arrumanome))
;-------------------------------

(defun c:GERAR_DWT ( / )
 
(if (= tmload T)((setq cancelei 0)(setq dcl_id123 (load_dialog "menu2.dcl"))
  (if (not (new_dialog "formatoDCL2" dcl_id123))(exit))
(action_tile
    "cancel"						
    "(setq cancelei 1)(done_dialog) (prompt \"cancelado\")(princ)"		
    );action_tile
  (action_tile "accept" "(setq cancelei 0)(obtem_dados3)")
  (action_tile "sobre" "(mensagem_sobre)")
  (start_dialog)
  

  
  (cond
		((or(= purge 1)(= gerartxt 1)(= ajustalts 1)(= dlm_limpar 1)(= gerar_pdf 1)(= geraraec 1)) (iniciaprocessofinal))
		((and(= purge 0)(= gerartxt 0)(= ajustalts 0)(= geraraec 0)(= gerar_pdf 0)) (alert "Nada Selecionado"))
				
	)
	
	
 
  
  ;(if (or(= purge 1)(= gerartxt 1)(= ajustalts 1)) 
  ;(gerar_dwt)	(alert "Nada Selecionado")) 
  (unload_dialog dcl_id123)
  
	  (princ))(alert "Lybraries do TecnoMetal não encontradas\n Essa ferramenta precisa ser rodada em desenhos abertos no TecnoMetal"))

)




(defun iniciaprocessofinal ()  
(if (= cancelei 0)(gerar_dwt2)(alert "Cancelado")))

(defun obtem_dados3 ()
(setq purge(atoi(get_tile "purge")))
(setq gerartxt(atoi(get_tile "gerartxt")))
(setq geraraec(atoi(get_tile "geraraec")))
(setq ajustalts(atoi(get_tile "ajustalts")))
(setq gerar_pdf(atoi(get_tile "gerar_pdf")))
;(setq dlm_limpar(atoi(get_tile "dlm_limpar")))
(done_dialog)
)





(defun c:limpeza123 ()
(command "PURGE" "A" "*" "N" "AUDIT" "Y")
)

(defun c:lts123 ()
(setq tm_scala 1)(tm:setup2)(command "psltscale" "1" "ltscale" "10" "-layer" "set" "0" "ltype" "hidden" "tr" "" "ZOOM" "E" "REGENALL")
)
  

(defun gerar_dwt2 ( / )
	(if (= gerar_pdf 1)
(c:CFG_PLOT_PDF))
    (SELETOR_DIRETORIO2)
  (princ)
)
(defun SELETOR_DIRETORIO2 nil
(SETQ lista2 (LM:getfiles "Ferramentas TecnoMetal - V0.1b - By Daniel Lins Maciel" "" "dwg"))

(setq diretorio (getvar "dwgprefix"))
(setq arquivo_scr (strcat "c:\\temp\\"  "script_dwt_v0.2.scr"))
(if lista2
(progn
(setq script_dwt (open arquivo_scr "w")
count 0
)
(while (setq nome_prancha (nth count lista2))
;

(setq nome123 (strcat (chr 40)"c:bota_nome"(chr 41)))
(setq nome124 (strcat (chr 40)"c:limpeza123"(chr 41)))
(setq nome125 (strcat (chr 40)"c:lts123"(chr 41)))
(setq nome126 (strcat (chr 40)"c:GERAR_PDF_S2"(chr 41)))
(setq nome127 (strcat (chr 40)"c:REMOVEAEC"(chr 41)))
(setq nome128 (strcat (chr 40)"c:dlm_limpar"(chr 41)))

(write-line (strcat "_open \"" nome_prancha "\"") script_dwt)
;(write-line formatofolha script_dwt)
(if (= gerartxt 1)
(write-line nome123 script_dwt))
(if (= purge 1)
(write-line nome124 script_dwt))

(if (= ajustalts 1)
(write-line nome125 script_dwt))

(if (= geraraec 1)
(write-line nome127 script_dwt))
(if (= purge 1)
(write-line nome128 script_dwt))

(if (= gerar_pdf 1)
(write-line nome126 script_dwt))



(cond
		((or(= purge 1)(= ajustalts 1)(= geraraec 1)) (write-line "_qsave" script_dwt))
	)
(write-line "_close" script_dwt)
(cond
		((and(= purge 0)(= ajustalts 0)(= geraraec 0)) (write-line "n" script_dwt))
	)
(setq count (1+ count))
)
(close script_dwt)
;
)
)
(command "FILEDIA" "0")
(command "SCRIPT" arquivo_scr "filedia" "1")
(princ)

)
;-------------------------------------------------------------
;-----------------fim gerar_dwt-------------------------------