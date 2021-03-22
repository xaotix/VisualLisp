(defun c:atributosEXT  nil (DLMAtributos  t ) (princ)) ;; Extractor

(defun c:atributosEDIT nil (DLMAtributos nil) (princ)) ;; Editor

;;-------------------------------------------------------------------------------;;

(defun c:atributos ( / *error* )

  (defun *error* ( msg )
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Erro: " msg " **")))
    (princ)
  )
    
  (initget "Editor eXtrator")
  
  (if (eq "Editor" (getkword "\n [Editor/eXtrator] <eXtrator> : "))
    (DLMAtributos nil)
    (DLMAtributos  t )
  )
)


(defun DLMAtributos




  (  

      MODE  

      /
      *ERROR*
      DLM:GETSAVEPATH
      DLM:WRITECONFIG
      DLM:READCONFIG
      PAD
      DLM:RELEASEOBJECT
      DLM:DIRECTORYDIALOG
      DLM:GETALLFILES
      DLM:OBJECTDBXDOCUMENT
      UNIQUEASSOC
      DLM:POPUP
      DLM:WRITEDCL
      DLM:LOGO
      MAKE_LIST
      MAKE_BLOCK_LIST
      MAKE_TAG_LIST
      SORTBYFIRST
      DIR_TEXT
      DIR_MODE
      REMOVE_ITEMS
      UNIQUE
      STR-MAKE
      PTR->L
      L->PTR
      LIST_UP
      LIST_DOWN
      TAG_CHOOSER
      TAG_CHOOSER_B
      TAG_EDITOR
      FORMAT_OPTIONS
      CALCINSPT
      
      *ACAD
      *ADOC
      *DLMAtributos_CRD*
      *DLMAtributos_CUR*
      *DLMAtributos_DEF*
      *DLMAtributos_DWG*
      *DLMAtributos_LST*
      *DLMAtributos_PAT*
      *MACEDI_BLK*
      *MACEDI_CUR*
      *MACEDI_DEF*
      *MACEDI_LST*
      *MACEDI_PAT*
      ATT$LST
      ATTLST
      BASSOC
      BLK
      BLKASSOC
      BLKLST
      BLK_STR
      BNME
      BSTR
      CFGFNAME
      COL
      CTMP
      DBX
      DCFLAG
      DCFNAME
      DCTAG
      DCTAGTITLE
      DCTITLE
      DOCLST
      DOUBLECLICKTIME
      DWG$LST
      DWLST
      ENT
      EXPRESS
      EXTRA
      FILEPATH
      FILETYPE
      FLAG
      FMODE
      FOLDER
      I
      ITEMS
      ITM
      LST
      MAX_ROW
      NEW_TAG
      NEW_VAL
      OBJ
      OBJNME
      ODOC
      OFILE
      OLD_ROW
      OV
      PROGBAR
      PTR
      ROW
      SAVEPATH
      SHELL
      SI
      SS
      STR
      SYM
      SYMLIST
      TAG
      TAGASSOCLIST
      TAGLST
      TAG_LST
      TAG_STR
      TMP
      UATTRIBS
      UTAGS
      VAL
      VALLIST
      Versao
      VL
      WSHSHELL
      XLAPP
      XLCELLS
      _F
   
   )
  
  (vl-load-com)
  
  (setq Versao "1.0")
  

  (defun *error* ( msg )

    (and ofile  (close ofile))
    (and ov     (mapcar (function setvar) vl ov))
    (and dcTag  (unload_dialog dcTag))
    (and Express ProgBar (acet-ui-progress))
    
    (mapcar 'DLM:ReleaseObject (list *acad *adoc Shell WSHShell dbx oDoc xlApp xlCells))

    (mapcar
      (function (lambda ( symbol ) (set symbol nil)))

      '(*acad *adoc *DLMAtributos_def* *DLMAtributos_Lst* *DLMAtributos_Pat* *DLMAtributos_Cur* *DLMAtributos_dwg* *DLMAtributos_crd*
                    *MacEdi_Blk* *MacEdi_cur* *MacEdi_def* *MacEdi_Lst* *MacEdi_Pat*)
    )
    
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Error: " msg " **")))
    
    (princ)
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:GetSavePath ( / tmp )
    (cond      
      ( (setq tmp (getvar 'ROAMABLEROOTPREFIX))

        (or (eq "\\" (substr tmp (strlen tmp)))
            (setq tmp (strcat tmp "\\"))
        )
        (strcat tmp "Support")
      )
      ( (setq tmp (findfile "ACAD.pat"))

        (setq tmp (vl-filename-directory tmp))

        (and (eq "\\" (substr tmp (strlen tmp)))
             (setq tmp (substr tmp (1- (strlen tmp))))
        )
        tmp
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:WriteConfig ( filename lst / ofile )
    
    (if (setq ofile (open filename "w")) 
      (progn
        (foreach x lst (write-line (vl-prin1-to-string x) ofile))
        
        (setq ofile (close ofile))
        T
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:ReadConfig ( filename lst / ofile )

    (if (and (setq filename (findfile filename))
             (setq ofile (open filename "r")))
      (progn
        (foreach x lst (set x (read (read-line ofile))))
        
        (setq ofile (close ofile))
        T
      )
    )
  ) 

  ;;-------------------------------------------------------------------------------;;
  
  (defun Pad ( Str Chc Len )
    (while (< (strlen Str) Len)
      (setq Str (strcat Str (chr Chc)))
    )    
    Str
  )

  ;;-------------------------------------------------------------------------------;;
            
  (defun DLM:ReleaseObject ( obj )

    (and obj (eq 'VLA-OBJECT (type obj)) (not (vlax-object-released-p obj))
      (not
        (vl-catch-all-error-p
          (vl-catch-all-apply
            (function vlax-release-object) (list obj)
          )
        )
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:DirectoryDialog ( msg dir flag / Shell Fold Path ac HWND )

    (setq Shell (vla-getInterfaceObject (setq ac (vlax-get-acad-object)) "Shell.Application")
          HWND  (vl-catch-all-apply 'vla-get-HWND (list ac))
          Fold  (vlax-invoke-method Shell 'BrowseForFolder (if (vl-catch-all-error-p HWND) 0 HWND) msg flag dir)
    )
    (vlax-release-object Shell)
    
    (if Fold
      (progn
        (setq Path (vlax-get-property (vlax-get-property Fold 'Self) 'Path))
        (vlax-release-object Fold)
        
        (and (= "\\" (substr Path (strlen Path)))
             (setq Path (substr Path 1 (1- (strlen Path)))))
      )
    )
    Path
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:GetAllFiles ( Dir Subs Filetype / GetSubFolders )
    
    (defun GetSubFolders ( folder / _f )
      (mapcar
        (function
          (lambda ( f ) (setq _f (strcat folder "\\" f))
            (cons _f (apply (function append) (GetSubFolders _f)))
          )
        )
        (cddr (vl-directory-files folder nil -1))
      )
    )

    (apply (function append)
      (vl-remove (quote nil)
        (mapcar
          (function
            (lambda ( Filepath )
              (mapcar
                (function
                  (lambda ( Filename )
                    (strcat Filepath "\\" Filename)
                  )
                )
                (vl-directory-files Filepath Filetype 1)
              )
            )
          )
          (append (list Dir) (apply (function append) (if subs (GetSubFolders Dir))))
        )
      )
    )
  )
  
  ;;-------------------------------------------------------------------------------;;

  (defun DLM:ObjectDBXDocument ( / acVer )

    (vla-GetInterfaceObject (vlax-get-acad-object)
      (if (< (setq acVer (atoi (getvar "ACADVER"))) 16)
        "ObjectDBX.AxDbDocument"
        (strcat "ObjectDBX.AxDbDocument." (itoa acVer))
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun UniqueAssoc ( lst / result ass )
    (setq result (list (car lst)))

    (while (setq lst (cdr lst))

      (setq result
        (if (setq ass (assoc (caar lst) result))
          (subst (cons (car ass) (append (cdr ass) (cdar lst))) ass result)
          (cons (car lst) result)
        )
      )
    )

    result
  )

  ;;-------------------------------------------------------------------------------;;
  
  (defun DLM:Popup ( title flags msg / WSHShell result )
    
    (setq WSHShell (vlax-create-object "WScript.Shell"))
    (setq result   (vlax-invoke WSHShell 'Popup msg 0 title flags))
    (vlax-release-object WSHShell)

    result
  )

  ;;-------------------------------------------------------------------------------;;

  (defun DLM:WriteDCL ( fname / ofile )

    (if (not (findfile fname))

      (if (setq ofile (open fname "w"))
        (progn          

          (foreach str

            '(
              "//-------------------------------------------------------------------------------//"
              "//  Author: Daniel Lins Maciel							                        //"
              "//-------------------------------------------------------------------------------//"
              ""
              ""
              ""
              "boxcol : boxed_column {      width =  60; fixed_width  = true; alignment = centered; }"
              "subcol : boxed_column {      width =  40; fixed_width  = true; alignment = centered; }"
              "edit34 :     edit_box { edit_width =  34; fixed_width  = true; alignment = centered; }"
              "edit34r:     edit_box { edit_width =  34; fixed_width  = true; alignment =    right; }"
              "butt3  :       button {      width =   3; fixed_width  = true; alignment = centered; }"
              "butt10 :       button {      width =  10; fixed_width  = true; alignment = centered; }"
              "butt12 :       button {      width =  12; fixed_width  = true; alignment = centered; }"
              "butt20 :       button {      width =  20; fixed_width  = true; alignment = centered; }"
              "space1 :       spacer {     height = 0.1; fixed_height = true; }"
              ""
              ""
              ""
              ""
              "DLMAtributos : dialog { key = \"dcl_title\";"
              "  spacer;"
              "  : text { label = \"Suporte: Daniel Lins Maciel - daniel.maciel@medabil.com.br\"; alignment = right; }"
              ""
              "  : boxcol { label = \"Bloco\";"
              ""
              "    : row {"
              ""
              "      : edit34 { key = \"block_name\"; label = \"Nome:\"; }"
              "      : butt3  { key = \"block_pick\"; label = \">>\"; }"
              ""
              "    }"
              ""
              "    : row {"
              ""
              "      spacer;"
              ""
              "      : column {"
              ""
              "        space1;"
              "        : toggle { label = \"Todas as Tags\"   ; key = \"tags\"; fixed_width = true; alignment = centered; }"
              "        space1;"
              ""
              "      }"
              ""
              "      : butt20 { label = \"Escolher Tags...\"; key = \"tag_button\"; }"
              ""
              "      spacer;"
              "      "
              "    }"
              ""
              "    spacer;"
              ""
              "  }"
              "  "
              "  spacer;"
              ""
              "  : row {"
              ""
              "    spacer;"
              "    : butt20 { key = \"add\"; label = \"Adicionar Bloco\"; }"
              "    : butt10 { key = \"clr\"; label = \"Limpar\"; }"
              "    : butt20 { key = \"rem\"; label = \"Remover Bloco\"; }"
              "    spacer;"
              ""
              "  }"
              "  "
              "  spacer;"
              ""
              "  : list_box { key = \"block_list\" ; multiple_select = true; fixed_width = false;"
              "               alignment = centered; tabs = \"30\"; tab_truncate = true; }"
              ""
              "  : text   { label = \"Clique duplo para editar entrada   \"; alignment = right; }"
              ""
              "  : boxcol { label = \"Pasta dos arquivos\";"
              ""
              "    : row {"
              ""
              "      : column {"
              ""
              "        space1;"
              "        : text   { key = \"dir_text\"; alignment = left; }"
              "        space1;"
              ""
              "      }"
              ""
              "      : butt10 { label = \"Diret�rio...\"; key = \"dir\"; }"
              ""
              "    }"
              ""
              "    : row {"
              ""
              "      : toggle { key = \"sub_dir\"; label = \"Incluir sub-diret�rios\"; }"
              "      : toggle { key = \"cur_dwg\"; label = \"Somente arquivo atual\"   ; }"
              ""
              "    }"
              ""
              "    spacer;"
              "  }"
              ""
              "  spacer;"
              ""
              "  : row {"
              ""
              "    : butt12 { key = \"option\"; label = \"Op��es\"; }"
              ""
              "    : butt12 { key = \"accept\"; label = \"OK\"; is_default = true; }"
              ""
              "    : butt12 { key = \"cancel\"; label = \"Cancelar\"; is_cancel = true; }"
              "    "
              "    : image  { key = \"logo\"; alignment = centered;"
              "               width = 16.06 ; fixed_width  = true;"
              "               height = 2.06 ; fixed_height = true; color = -15; }"
              "  }"
              ""
              "}"
              ""
              ""
              ""
              ""
              "DLMAtributos_opt : dialog { key = \"dcl_opt_title\";"
              "  spacer;"
              ""
              "  : boxed_radio_column { label = \"Formatar Op��es\";"
              "    spacer;"
              ""
              "    : radio_button { key = \"grp_file\"  ; label = \" Agrupar por nome de arquivo\"; }"
              "    : radio_button { key = \"grp_block\" ; label = \" Agrupar por nome de bloco\";    }"
              "    : radio_button { key = \"grp_dwglst\"; label = \" Agrupar por lista de prancha\"; }"
              ""
              "    spacer;"
              "  }"
              "  spacer;"
              ""
              "  : row { spacer;"
              ""
              "    : toggle { key = \"coord\"; label = \" Extrair Coordenadas dos blocos\"; }"
              ""
              "  }"
              "  spacer;"
              ""
              "  ok_cancel;"
              "}"
              ""
              ""
              ""
              ""
              "DLMAtributos_tags : dialog { key = \"dcl_sub_title\";"
              ""
              "  spacer_1;"
              "  : edit34 { label =   \"Tag:\";  key = \"tag\"; }"
              ""
              "  spacer_1;"
              "  : row {"
              ""
              "    : butt20 { label = \"Adicionar Tag\";    key = \"tag_add\"; }"
              "    : butt20 { label = \"Remover Tag\"; key = \"tag_rem\"; }"
              "    "
              "  }"
              "  spacer;"
              ""
              "  : list_box { label = \"Tags para extrair:\"; multiple_select = true; key = \"tag_list\";"
              "               fixed_width = false; alignment = centered;   }"
              ""
              "  : boxed_column { label = \"Ordem das Tags\";"
              ""
              "    : row {"
              ""
              "      spacer;"
              ""
              "      : butt10 { label = \"Cima\"    ; key = \"up\"   ; }"
              "      : butt10 { label = \"Baixo\"  ; key = \"down\" ; }"
              "      : butt10 { label = \"ABC\"   ; key = \"abc\"  ; }"
              ""
              "      spacer;"
              ""
              "    }"
              ""
              "    spacer;"
              "  }"
              ""
              "  spacer_1;"
              ""
              "  ok_cancel;"
              "}"
              ""
              ""
              ""
              ""
              "DLMAtributos_tagsb : dialog { key = \"dcl_sub_title\";"
              ""
              "  spacer_1;"
              "  : edit34r { label =   \"Bloco:\";  key = \"blk\"; }"
              ""
              "  spacer_1;"
              "  : edit34r { label =     \"Tag:\";  key = \"tag\"; }"
              ""
              "  spacer_1;"
              "  : row {"
              ""
              "    : butt20 { label = \"Add Tag\";    key = \"tag_add\"; }"
              "    : butt20 { label = \"Remover Tag\"; key = \"tag_rem\"; }"
              "  }"
              "  spacer;"
              ""
              "  : list_box { label = \"Tags para extrair:\"; key = \"tag_list\";"
              "               fixed_width = false; multiple_select = true; alignment = centered; }"
              ""
              "  : boxed_column { label = \"Ordem das tags\";"
              ""
              "    : row {"
              ""
              "      spacer;"
              ""
              "      : butt10 { label = \"Cima\"    ; key = \"up\"   ; }"
              "      : butt10 { label = \"Baixo\"  ; key = \"down\" ; }"
              "      : butt10 { label = \"ABC\"   ; key = \"abc\"  ; }"
              ""
              "      spacer;"
              ""
              "    }"
              ""
              "    spacer;"
              "  }"
              ""
              "  spacer_1;"
              ""
              "  ok_cancel;"
              "}"
              ""
              ""
              ""
              ""
              "macedit : dialog { key = \"dcl_title\";"
              "  spacer;"
              "  : text { label = \"suporte: Daniel Lins Maciel - daniel.maciel@medabil.com.br\"; alignment = right; }"
              ""
              "  : boxcol { label = \"Bloco\";"
              ""
              "    : row {"
              ""
              "      : edit34 { key = \"block_name\"; label = \"Nome:\"; }"
              "      : butt3  { key = \"block_pick\"; label = \">>\"; }"
              ""
              "    }"
              ""
              "    spacer;"
              ""
              "  }"
              ""
              "  : boxcol { label = \"Tag Entry\";"
              ""
              "    : row {"
              ""
              "      : edit34 { key = \"tag_name\"; label = \"Nome da Tag:\"; }"
              "      : butt3  { key = \"tag_pick\"; label = \">>\"; }"
              ""
              "    }"
              ""
              "    : row {"
              ""
              "      : edit34  { key = \"new_value\"; label = \"Novo valor:\"; }"
              "      : spacer  { width = 3; fixed_width = true; }"
              "      "
              "    }"
              ""
              "  spacer;"
              ""
              "  }"
              "  "
              "  spacer;"
              ""
              "  : row {"
              ""
              "    spacer;"
              "    : butt20 { key = \"add\"; label = \"Adicionar Tag\"; }"
              "    : butt10 { key = \"clr\"; label = \"Limpar\"; }"
              "    : butt20 { key = \"rem\"; label = \"Remover Tag\"; }"
              "    spacer;"
              ""
              "  }"
              "  "
              "  spacer;"
              ""
              "  : list_box { key = \"tag_list\" ; multiple_select = true;"
              "               fixed_width = false; alignment = centered; tabs = \"30\"; } "
              ""
              "  : text { label = \"Clique duplo para editar   \"; alignment = right; }"
              "    "
              "  : boxcol { label = \"Pasta:\";"
              ""
              "    : row {"
              ""
              "      : column {"
              ""
              "        space1;"
              "        : text   { key = \"dir_text\"; alignment = left; }"
              "        space1;"
              ""
              "      }"
              ""
              "      : butt10 { label = \"Diret�rio...\"; key = \"dir\"; }"
              ""
              "    }"
              ""
              "    : row {"
              ""
              "      : toggle { key = \"sub_dir\"; label = \"Incluir Sub-Diret�rios\"; }"
              "      : toggle { key = \"cur_dwg\"; label = \"Somente diret�rio atual\"   ; }"
              "      "
              "    }"
              ""
              "    spacer;"
              "  }"
              ""
              "  spacer;"
              ""
              "  : row {"
              ""
              "    : spacer { width = 16.06; fixed_width = true; }"
              ""
              "    ok_cancel;"
              "    "
              "  }"
              "  "
              "}"
              ""
              ""
              ""
              ""
              "macedit_tags : dialog { key = \"dcl_sub_title_edit\";"
              ""
              "  : subcol { label = \"Tag\";"
              "  "
              "    : edit34r { label = \"Nome:\" ; key = \"tag_sub\"; }"
              "    : edit34r { label = \"Novo Valor:\"; key = \"new_value_sub\"; }"
              ""
              "    spacer;"
              "    "
              "  }"
              ""
              "  spacer;"
              ""
              "  ok_cancel;"
              "}"
              ""

              )

            (write-line str ofile)
          )

          (setq ofile (close ofile))

          (while (not (findfile fname)))
          
        t)  ; File written successfully
        
    nil) ; Filepath not Found
      
  t)) ; DCL file already exists


  ;;-------------------------------------------------------------------------------;;

  (defun Make_List ( key lst )
    (start_list key)
    (mapcar (function add_list) lst)
    (end_list)
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Make_Block_List ( key lst )
    (start_list key)
    
    (mapcar (function add_list)
      (mapcar
        (function
          (lambda ( x )
            (strcat
              (if (< 29 (strlen (car x)))
                (strcat (substr (car x) 1 26) "...") (car x)
              )
              "\t"
              (if (cdr x)
                (Str-Make (cdr x) ",") "ALL TAGS"
              )
            )
          )
        )
        lst
      )
    )
    (end_list)
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Make_Tag_List ( key lst )
    (start_list key)
    
    (mapcar (function add_list)
      (mapcar
        (function
          (lambda ( x )
            (strcat
              (if (< 29 (strlen (car x)))
                (strcat (substr (car x) 1 26) "...") (car x)
              )
              "\t"
              (cond ((cdr x)) ("- NO VALUE -"))
            )
          )
        )
        lst
      )
    )
    (end_list)
  )

  ;;-------------------------------------------------------------------------------;;

  (defun SortByFirst ( lst )
    (if lst
      (vl-sort lst
        (function
          (lambda ( a b ) (< (car a) (car b)))
        )
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Dir_Text ( key str )
    (set_tile key
      (if str
        (if (< 45 (strlen str))
          (strcat (substr str 1 42) "...") str
        )
        ""
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Dir_Mode ( val )
    (mapcar
      (function
        (lambda ( x )
          (mode_tile x (atoi val))
        )
      )
      '("sub_dir" "dir" "dir_text")
    )
  )
  
  ;;-------------------------------------------------------------------------------;;

  (defun Remove_Items ( items lst / i ) (setq i -1)
    (vl-remove-if
      (function
        (lambda ( x )
          (vl-position (setq i (1+ i)) items)
        )
      )
      lst
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun unique ( lst / result )
    (reverse
      (while (setq itm (car lst))
        (setq lst (vl-remove itm lst) result (cons itm result))
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Str-Make ( lst del / str x ) (setq str (car lst))
    (foreach x (cdr lst)
      (setq str (strcat str del x))
    )
    str
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Ptr->L ( ptr )
    (read (strcat "(" ptr ")"))
  )

  ;;-------------------------------------------------------------------------------;;

  (defun L->Ptr ( lst )
    (vl-string-trim "()" (vl-princ-to-string lst))
  )

  ;;-------------------------------------------------------------------------------;;

  (defun List_Up ( ind lst ) ; Gile
    (cond (  (or (null ind) (null lst)) lst)
          (  (= 0  (car ind))
             (cons (car lst)  (list_up (cdr (mapcar '1- ind)) (cdr lst))))
          (  (= 1  (car ind))
             (cons (cadr lst) (list_up (cdr (mapcar '1- ind)) (cons (car lst) (cddr lst)))))
          (t (cons (car lst)  (list_up (mapcar '1- ind) (cdr lst))))))

  ;;-------------------------------------------------------------------------------;;

  (defun List_Down ( ind lst )
    (reverse
      (list_up
        (reverse
          (mapcar
            (function
              (lambda ( x )
                (- (1- (length lst)) x)
              )
            )
            ind
          )
        )
        (reverse lst)
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Tag_Chooser ( tag lst / str tmp ptr items oldptr )

    (cond (  (not (new_dialog "DLMAtributos_tags" tag))

             (DLM:Popup "Aten��o!" 16 "Attribute Tag Dialog could not be Loaded"))

          (t

             (Make_List "tag_list" (setq tmp lst))
             (set_tile "dcl_sub_title" dcTagTitle)
             (mode_tile "tag" 2)
           
             (action_tile "tag"      "(setq str $value)")

             (action_tile "tag_list" "(setq ptr $value)")

             (action_tile "abc"
               (vl-prin1-to-string
                 (quote
                   (if tmp
                     (Make_List "tag_list" (setq tmp (acad_strlsort tmp)))
                   )
                 )
               )
             )
                   
             (action_tile "up"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if ptr
                       (progn
                         (setq oldptr
                           (mapcar
                             (function
                               (lambda ( x ) (nth x tmp))
                             )
                             (Ptr->L ptr)
                           )
                         )                         
                         (Make_List "tag_list" (setq tmp (List_Up (Ptr->L ptr) tmp)))
                         
                         (set_tile "tag_list"
                           (setq ptr
                             (L->Ptr
                               (mapcar
                                 (function
                                   (lambda ( x )
                                     (vl-position x tmp)
                                   )
                                 )
                                 oldptr
                               )
                             )
                           )
                         )
                       )
                       (DLM:Popup "Informa��o" 48 "Please Select Tag(s) to Move Up")
                     )
                   )
                 )
               )
             )

             (action_tile "down"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if ptr
                       (progn
                         (setq oldptr
                           (mapcar
                             (function
                               (lambda ( x ) (nth x tmp))
                             )
                             (Ptr->L ptr)
                           )
                         )                         
                         (Make_List "tag_list" (setq tmp (List_Down (Ptr->L ptr) tmp)))
                         
                         (set_tile "tag_list"
                           (setq ptr
                             (L->Ptr
                               (mapcar
                                 (function
                                   (lambda ( x )
                                     (vl-position x tmp)
                                   )
                                 )
                                 oldptr
                               )
                             )
                           )
                         )
                       )                       
                       (DLM:Popup "Informa��o" 48 "Selecione uma tag para mover para baixo.")
                     )
                   )
                 )
               )
             )

             (action_tile "tag_add"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (cond
                       ( (or (not str) (eq "" str))

                         (DLM:Popup "Informa��o" 48 "Digite o nome da tag para poder adicionar"))

                       ( (or (not (snvalid str)) (vl-string-position 32 str))

                         (DLM:Popup "Informa��o" 64
                           (strcat "Attribute Tag not Valid"
                             (if (vl-string-position 32 str)
                               "\n\n[ tag n�o pode ter espa�os ]" ""
                             )
                           )
                         )
                       )                       
                       ( (vl-position (strcase str) tmp)
                        
                         (DLM:Popup "Informa��o" 48 "tag j� existe na lista")
                       )                       
                       (t
                         (set_tile "tag" "")
                        
                         (Make_List "tag_list"
                           (setq tmp
                             (append tmp (list (strcase str)))
                           )
                         )
                         (setq str nil)
                       )
                     )
                   )
                 )
               )
             )

             (action_tile "tag_rem"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if tmp
                       (if (and ptr (listp (setq items (Ptr->L ptr))))
                         (progn
                           (setq tmp (Remove_Items items tmp) ptr nil)
                           (Make_List "tag_list" tmp)
                         )
                         (DLM:Popup "Informa��o" 48 "selecione uma tag para remover")
                       )
                       (DLM:Popup "Informa��o" 64 "n�o foram encontradas tags para remover")
                     )
                   )
                 )
               )
             )

             (action_tile "accept" "(setq lst tmp) (done_dialog)")
           
             (action_tile "cancel" "(done_dialog)")

             (start_dialog)
          )
    )
    (if (listp lst) lst (list lst))
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Tag_Chooser_b ( tag lst / ChkLst bStr str tmp ptr items oldptr )

    (setq chkLst (vl-remove-if
                   (function
                     (lambda ( x )
                       (eq (strcase (car lst)) x)
                     )
                   )
                   (mapcar
                     (function
                       (lambda ( x ) (strcase (car x)))
                     )
                     *DLMAtributos_Lst*
                   )
                 )
    )

    (cond (  (not (new_dialog "DLMAtributos_tagsb" tag))

             (DLM:Popup "Aten��o!" 16 "Menu de atributos n�o pode ser carregado."))

          (t

             (Make_List "tag_list" (setq tmp (cdr lst)))
           
             (set_tile "dcl_sub_title" dcTagTitle)
             (set_tile "blk" (setq bStr (car lst)))
           
             (mode_tile "tag" 2)

             (action_tile "blk"      "(setq bStr $value)")
           
             (action_tile "tag"      "(setq str  $value)")

             (action_tile "tag_list" "(setq ptr  $value)")

             (action_tile "abc"
               (vl-prin1-to-string
                 (quote
                   (if tmp
                     (Make_List "tag_list" (setq tmp (acad_strlsort tmp)))
                   )
                 )
               )
             )
                   
             (action_tile "up"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if ptr
                       (progn
                         (setq oldptr
                           (mapcar
                             (function
                               (lambda ( x ) (nth x tmp))
                             )
                             (Ptr->L ptr)
                           )
                         )                         
                         (Make_List "tag_list" (setq tmp (List_Up (Ptr->L ptr) tmp)))
                         
                         (set_tile "tag_list"
                           (setq ptr
                             (L->Ptr
                               (mapcar
                                 (function
                                   (lambda ( x )
                                     (vl-position x tmp)
                                   )
                                 )
                                 oldptr
                               )
                             )
                           )
                         )
                       )
                       (DLM:Popup "Informa��o" 48 "por favor selecione uma tag para mover para cima")
                     )
                   )
                 )
               )
             )

             (action_tile "down"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if ptr
                       (progn
                         (setq oldptr
                           (mapcar
                             (function
                               (lambda ( x ) (nth x tmp))
                             )
                             (Ptr->L ptr)
                           )
                         )                         
                         (Make_List "tag_list" (setq tmp (List_Down (Ptr->L ptr) tmp)))
                         
                         (set_tile "tag_list"
                           (setq ptr
                             (L->Ptr
                               (mapcar
                                 (function
                                   (lambda ( x )
                                     (vl-position x tmp)
                                   )
                                 )
                                 oldptr
                               )
                             )
                           )
                         )
                       )                       
                       (DLM:Popup "Informa��o" 48 "selecione uma tag para mover para baixo")
                     )
                   )
                 )
               )
             )

             (action_tile "tag_add"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (cond
                       ( (or (not str) (eq "" str))

                         (DLM:Popup "Informa��o" 48 "selecione uma tag para adicionar")
                       )                       
                       ( (or (not (snvalid str)) (vl-string-position 32 str))
                        
                         (DLM:Popup "Informa��o" 64
                           (strcat "nome do atributo inv�lido"
                             (if (vl-string-position 32 str)
                               "\n\n[ tag n�o pode ter espa�os ]" ""
                             )
                           )
                         )
                       )                       
                       ( (vl-position (strcase str) tmp)
                        
                         (DLM:Popup "Informa��o" 48 "tag j� existe na lista")
                       )                       
                       (t
                         (set_tile "tag" "")
                        
                         (Make_List "tag_list"
                           (setq tmp (append tmp (list (strcase str))))
                         )
                         (setq str nil)
                       )
                     )
                   )
                 )
               )
             )

             (action_tile "tag_rem"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (if tmp
                       (if (and ptr (listp (setq items (Ptr->L ptr))))
                         (progn
                           (setq tmp (Remove_Items items tmp) ptr nil)
                           (Make_List "tag_list" tmp)
                         )
                         (DLM:Popup "Informa��o" 48 "por favor selecione uma tag para remover")
                       )
                       (DLM:Popup "Informa��o" 64 "n�o foram encontradas tags para remover")
                     )
                   )
                 )
               )
             )

             (action_tile "accept"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (cond
                       ( (or (not bStr) (eq "" bStr))

                         (DLM:Popup "Informa��o" 64 "digite o nome do bloco")
                       )                       
                       ( (not (snvalid bStr))
                        
                         (DLM:Popup "Informa��o" 48 "nome do bloco inv�lido")
                       )                       
                       ( (vl-position (strcase bStr) ChkLst)
                        
                         (DLM:Popup "Informa��o" 48 "bloco j� est� na lista")
                       )                       
                       (t
                         (setq lst (cons bStr tmp))
                        
                         (done_dialog)
                       )
                     )
                   )
                 )
               )
             )

             (action_tile "cancel" "(done_dialog)")

             (start_dialog)
          )
    )
    lst
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Tag_Editor ( tag lst / tmp new_tag new_val )

    (cond (  (not (new_dialog "macedit_tags" tag))

             (DLM:Popup "Aten��o!" 16 "menu do editor de tag n�o pode ser carregado!"))

          (t
             (setq tmp
               (vl-remove-if
                 (function
                   (lambda ( x )
                     (eq (strcase (car lst)) (strcase (car x)))
                   )
                 )
                 *MacEdi_lst*
               )
             )
           
             (set_tile "dcl_sub_title" dcTagTitle)
           
             (set_tile "tag_sub"       (setq new_tag (car lst)))
           
             (set_tile "new_value_sub" (setq new_val (cond ((cdr lst)) (""))))

             (action_tile "tag_sub"       "(setq new_tag $value)")
           
             (action_tile "new_value_sub" "(setq new_val $value)")

             (action_tile "accept"
               (vl-prin1-to-string
                 (quote
                   (progn
                     (cond
                       ( (or (not new_tag) (eq "" new_tag))

                         (DLM:Popup "Informa��o" 48 "digite o nome da tag")
                       )                       
                       ( (or (not (snvalid new_tag)) (vl-string-position 32 new_tag))
                        
                         (DLM:Popup "Informa��o" 64
                           (strcat "nome do atributo inv�lido"
                             (if (vl-string-position 32 new_tag)
                               "\n\n[ tag n�o pode ter espa�os ]" ""
                             )
                           )
                         )
                       )                       
                       ( (assoc (setq new_tag (strcase new_tag)) tmp)
                        
                         (DLM:Popup "Informa��o" 48 "tag j� est� na lista")
                       )                       
                       (t
                         (and (eq "" new_val) (setq new_val nil))
                        
                         (setq lst (cons new_tag new_val))
                        
                         (done_dialog)
                       )
                     )
                   )
                 )
               )
             )

             (action_tile "cancel" "(done_dialog)")

             (start_dialog)
          )
    )
    lst
  )

  ;;-------------------------------------------------------------------------------;;

  (defun Format_Options ( tag fmode / tmp ctmp )

    (cond (  (not (new_dialog "DLMAtributos_opt" tag))

             (DLM:Popup "Aten��o!" 16 "menu de op��es n�o pode ser carregado."))

          (t

             (set_tile (setq tmp fmode) "1")
             (set_tile "dcl_opt_title" "op��es")

             (setq ctmp (set_tile "coord" *DLMAtributos_crd*))
 
             (mapcar
               (function
                 (lambda ( tile )
                   (action_tile tile
                     (strcat "(setq tmp " (vl-prin1-to-string tile) " )")
                   )
                 )
               )
               '("grp_file" "grp_block" "grp_dwglst")
             )

             (action_tile "coord"  "(setq ctmp $value)")

             (action_tile "accept" "(setq fmode tmp *DLMAtributos_crd* ctmp) (done_dialog)")

             (action_tile "cancel" "(done_dialog)")

             (start_dialog)
          )
    )
    fmode
  )

  ;;-------------------------------------------------------------------------------;;

  (defun CalcInsPt ( obj str / eLst Alig )
    ;; Modification of VovKa's Routine

    (setq eLst (entget (vlax-vla-object->ename obj))
          Alig (cdr (assoc 72 eLst)))

    (polar
      (vlax-get obj 'InsertionPoint)
      (vla-get-Rotation obj)
      
      (*
        (apply (function +)
          (mapcar
            (function
              (lambda ( e1 e2 ) (- (car e1) (car e2)))
            )          
            (textbox eLst)
            (textbox (subst (cons 1 str) (assoc 1 eLst) eLst))
          )
        )      
        (cond
          ( (or (= Alig 1) (= Alig 4)) 0.5)
          
          ( (= Alig 2) 1.0)
          
          (t 0.0)
        )
      )
    )
  )

  ;;-------------------------------------------------------------------------------;;
  ;;                           --=={  Preliminaries  }==--                         ;;
  ;;-------------------------------------------------------------------------------;;
  
  (if (not (vl-file-directory-p (setq SavePath (DLM:GetSavePath))))
    (progn
      (DLM:Popup "Aten��o!" 16 "pasta de destino inv�lida!")
      (exit)
    )
  )  

  (setq dcfname    (strcat SavePath "\\DLM_ATRIBUTO_V" Versao ".dcl")

        cfgfname   (strcat SavePath "\\DLM_ATRIBUTO_V" Versao ".cfg"))

  (setq DoubleClickTime 0.0000011667)  ;; Increase to allow for slower double-click
  
  (setq *acad (vlax-get-acad-object)
        *adoc (vla-get-ActiveDocument *acad))

  (setq Express
    (and (vl-position "acetutil.arx" (arx))
      (not
        (vl-catch-all-error-p
          (vl-catch-all-apply
            (function (lambda nil (acet-sys-shift-down)))
          )
        )
      )
    )
  ) 
  
  ;;-------------------------------------------------------------------------------;;
  ;;                           --=={  Main Function  }==--                         ;;
  ;;-------------------------------------------------------------------------------;;

  (setq SymList '(*DLMAtributos_def* *DLMAtributos_lst* *DLMAtributos_pat* *DLMAtributos_cur* *DLMAtributos_dwg* *DLMAtributos_crd*
                  *MacEdi_def* *MacEdi_lst* *MacEdi_pat* *MacEdi_cur* *MacEdi_blk*)

        ValList  (list "1" 'nil (getvar 'DWGPREFIX) "0" "grp_file" "0" "1" 'nil (getvar 'DWGPREFIX) "0" 'nil)
  )  

  (setq vl '("DIMZIN") ov (mapcar (function getvar) vl))
  (mapcar (function setvar) vl '(0))
  

  ;;                         --=={  Setup Defaults  }==--                          ;;

  (or (findfile cfgfname)
      (DLM:WriteConfig cfgfname ValList))

  (DLM:ReadConfig cfgfname SymList)

  (mapcar '(lambda ( sym val ) (or (boundp sym) (set sym val))) SymList ValList)

  ;;-------------------------------------------------------------------------------;;
  

  (cond (  (not (DLM:WriteDCL dcfname))

           (DLM:Popup "Aten��o!" 16 "n�o consegui gerar o menu :/")
           (princ "\n** arquivo DCL n�o pode ser gerado **"))

        (  (<= (setq dcTag (load_dialog dcfname)) 0)

           (DLM:Popup "Aten��o!" 16 "n�o encontrei o menu")
           (princ "\n** arquivo DCL n�o encontrado **"))
        

        (Mode

           ;;-------------------------------------------------------------------------------;;

           ;;                           --=={  Extractor Mode  }==--                        ;;

           ;;-------------------------------------------------------------------------------;;
         

           (setq dcTitle    (strcat "AtributosDLM V" Versao)

                 dcTagTitle "Atributos para extrair")

           ;;                        --=={  Begin DCL While Loop  }==--                     ;;

           (while (not (vl-position dcFlag '(1 0)))

             (cond (  (not (new_dialog "DLMAtributos" dcTag))

                      (DLM:Popup "Aten��o!" 16 "menu do Extrator n�o pode ser carregado.")
                      (princ "\n** DCL could not be Loaded **")

                      (setq dcFlag 0))

                   (t

                      (Make_Block_List "block_list" (setq *DLMAtributos_Lst* (SortByFirst *DLMAtributos_Lst*)))
             
                      (Dir_Text  "dir_text"   *DLMAtributos_pat*)
                      (set_tile  "sub_dir"    *DLMAtributos_def*)
                      (set_tile  "dcl_title"       dcTitle)
                      
                      (set_tile  "tags" "1")
                      (mode_tile "tag_button" 1)



                      (Dir_Mode (set_tile "cur_dwg" *DLMAtributos_cur*))

                      (action_tile "cur_dwg" "(Dir_Mode (setq *DLMAtributos_cur* $value))")

                      (action_tile "option"  "(setq *DLMAtributos_dwg* (Format_Options dcTag *DLMAtributos_dwg*))")

                      (action_tile "dir"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (if (setq tmp (DLM:DirectoryDialog "Selecione o diret�rio dos arquivos DWG..." nil 0))
                                (Dir_Text "dir_text" (setq *DLMAtributos_pat* tmp))
                              )
                            )
                          )
                        )
                      )

                      (action_tile "rem"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (if *DLMAtributos_Lst*
                                (if (and ptr (listp (setq items (Ptr->L ptr))))
                                  (progn
                                    (setq *DLMAtributos_Lst* (Remove_Items items *DLMAtributos_Lst*) ptr nil)
                                    (Make_Block_List "block_list" (setq *DLMAtributos_Lst* (SortByFirst *DLMAtributos_Lst*)))
                                  )                                
                                  (DLM:Popup "Informa��o" 48 "selecione um bloco para remover")
                                )
                                (DLM:Popup "Informa��o" 64 "n�o foram encontrados blocos para remover.")
                              )
                            )
                          )
                        )
                      )

                      (action_tile "add"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (cond
                                ( (or (not blk_str) (eq "" blk_str))

                                  (DLM:Popup "Informa��o" 64 "digite o nome do bloco")
                                )                                
                                ( (not (snvalid blk_str))
                                 
                                  (DLM:Popup "Informa��o" 48 "nome do bloco inv�lido")
                                )                                
                                ( (vl-position (strcase blk_str)
                                    (mapcar
                                      (function
                                        (lambda ( x ) (strcase (car x)))
                                      )
                                      *DLMAtributos_Lst*
                                    )
                                  )
                                 
                                  (DLM:Popup "Informa��o" 48 "bloco j� existe na lista")
                                )                                
                                (t
                                  (set_tile "block_name" "")
                                 
                                  (and (eq "1" (get_tile "tags")) (setq tagLst nil))
                                 
                                  (Make_Block_List "block_list"
                                    (setq *DLMAtributos_Lst*
                                      (SortByFirst (cons (cons blk_str tagLst) *DLMAtributos_Lst*))
                                    )
                                  )
                                 
                                  (set_tile  "tags" "1")
                                  (mode_tile "tag_button" 1)
                                 
                                  (setq blk_str nil tagLst nil)
                                )
                              )
                            )
                          )
                        )
                      )

                      (action_tile "tags"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (mode_tile "tag_button" (atoi $value))
                            )
                          )
                        )
                      )

                      (action_tile "clr"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (Make_Block_List "block_list" (setq *DLMAtributos_Lst* nil))
                            )
                          )
                        )
                      )
                    
                      (action_tile "tag_button" "(setq tagLst (Tag_Chooser dcTag tagLst))")

                      (action_tile "sub_dir"    "(setq *DLMAtributos_def* $value)")

                      (action_tile "block_name" "(setq blk_str $value)")

                      (action_tile "block_list"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (setq #st (getvar "DATE") ptr $value)
                              
                              (if (and (eq dclkptr $value)
                                       (< (abs (read (rtos (- #en #st) 2 10))) DoubleClickTime))
                                (progn

                                  (setq n (nth (atoi ptr) *DLMAtributos_Lst*))

                                  (Make_Block_List "block_list"
                                    (setq *DLMAtributos_Lst*
                                      (SortByFirst
                                        (subst
                                          (Tag_Chooser_b dcTag n) n *DLMAtributos_Lst*
                                        )
                                      )
                                    )
                                  )
                                  
                                  (setq dclkptr nil)
                                )
                                
                                (setq #en (getvar "DATE") dclkptr $value)
                              )
                            )
                          )
                        )
                      )

                      (action_tile "block_pick" "(done_dialog 2)")
                      
                      (action_tile "accept"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (cond
                                ( (not *DLMAtributos_Lst*)

                                  (DLM:Popup "Informa��o" 64 "adicione pelo menos um bloco na lista")
                                )
                                (t
                                  (done_dialog 1)
                                )
                              )
                            )
                          )
                        )
                      )                              
                              
                      (action_tile "cancel"     "(done_dialog 0)")
                    
                      (setq dcflag (start_dialog))
                   )
             )

             ;;-------------------------------------------------------------------------------;;

             (if (= dcflag 2)
               
               (if (setq si -1 ss (ssget '((0 . "INSERT") (66 . 1))))
                 
                 (while (setq ent (ssname ss (setq si (1+ si))))
                   (setq obj (vlax-ename->vla-object ent))
                   
                   (if
                     (not
                       (vl-position
                         (strcase
                           (setq bNme
                             (cond
                               (  (vlax-property-available-p obj 'EffectiveName)

                                  (vla-get-EffectiveName obj)
                               )
                               (t (vla-get-Name obj))
                             )
                           )
                         )
                         (mapcar (function strcase)
                           (mapcar (function car) *DLMAtributos_Lst*)
                         )
                       )
                     )
                     
                     (setq *DLMAtributos_Lst*
                       (cons
                         (cons bNme
                           (mapcar (function vla-get-TagString)
                             (append
                               (vlax-invoke Obj 'GetAttributes)
                               (vlax-invoke Obj 'GetConstantAttributes)
                             )
                           )
                         )
                         *DLMAtributos_Lst*
                       )
                     )
                   )
                 )
               )
             )
           )

           ;;                         --=={  End of DCL While Loop  }==--                   ;;

           (setq dcTag (unload_dialog dcTag))

           (if (= 1 dcflag)
             (progn
               
               (setq BlkLst
                 (mapcar
                   (function
                     (lambda ( x ) (cons (strcase (car x)) (cdr x)))
                   )
                   *DLMAtributos_Lst*
                 )
               )               
      
               (vlax-for doc (vla-get-Documents *acad)
                 (setq DocLst
                   (cons
                     (cons (strcase (vla-get-fullname doc)) doc) DocLst
                   )
                 )
               )

               (setq dbx (DLM:ObjectDBXDocument))               

               (setq dwLst
                 (cond
                   ( (eq "1" *DLMAtributos_cur*)
                                               
                     (list
                       (cond
                         (  (eq "" (vla-get-FullName *adoc))
                            
                            (strcat (vla-get-Path *adoc) (vla-get-Name *adoc))
                         )
                         (t (vla-get-FullName *adoc))
                       )
                     )
                   )                   
                   ( (DLM:GetAllFiles *DLMAtributos_pat* (eq "1" *DLMAtributos_def*) "*.dwg") )
                 )
               )

               (if Express (setq ProgBar (acet-ui-progress "Extraindo...Aguarde..." (length dwLst))))

               (foreach dwg dwLst

                 (if Express (acet-ui-progress -1))                 

                 (cond (  (setq flag (eq "1" *DLMAtributos_cur*))

                          (setq oDoc *adoc))

                       (  (setq flag (and (setq oDoc (cdr (assoc (strcase dwg) DocLst))))))

                       (t (setq flag (not (vl-catch-all-error-p
                                            (vl-catch-all-apply
                                              (function vla-open) (list dbx dwg)))))
                          (setq oDoc dbx)))

                 (if flag
                   (progn
                     
                     (vlax-for lay (vla-get-Layouts oDoc)

                       (vlax-for Obj (vla-get-Block lay)

                         (if
                           (and
                             (eq (vla-get-ObjectName Obj) "AcDbBlockReference")
                             (eq :vlax-true (vla-get-HasAttributes Obj))
                             (setq BlkAssoc
                               (assoc
                                 (strcase
                                   (setq ObjNme
                                     (cond
                                       (  (vlax-property-available-p obj 'EffectiveName)
                                        
                                          (vla-get-EffectiveName Obj))
                                       
                                       (t (vla-get-Name Obj))
                                     )
                                   )
                                 )
                                 BlkLst
                               )
                             )
                           )
                           (progn
                             (setq uAttribs (mapcar 'strcase (cdr BlkAssoc)))

                             (foreach Att (append (vlax-invoke Obj 'GetAttributes)
                                                  (vlax-invoke Obj 'GetConstantAttributes))

                               (if (or (not uAttribs)
                                       (vl-position
                                         (strcase (vla-get-TagString Att)) uAttribs))

                                 (setq AttLst
                                   (cons
                                     (cons (vla-get-TagString Att) (list (vla-get-TextString Att))) AttLst
                                   )
                                 )
                               )
                             )                             

                             (if (eq "grp_dwglst" *DLMAtributos_dwg*)
                               (setq AttLst (cons (cons "CAD Filename" (list dwg)) AttLst))
                             )

                             (if (eq "1" *DLMAtributos_crd*)
                               (setq AttLst
                                 (cons
                                   (cons "Block Coords"
                                     (list
                                       (Str-Make
                                         (mapcar (function rtos)
                                           (vlax-get Obj 'InsertionPoint)
                                         )
                                         ","
                                       )
                                     )
                                   )
                                   AttLst
                                 )
                               )
                             )

                             (setq Att$lst (cons (cons ObjNme AttLst) Att$lst) AttLst nil)
                           )
                         )
                       )
                     )

                     (if Att$Lst
                       (setq Dwg$Lst
                         (cons
                           (cons dwg
                             (SortByFirst
                               (mapcar
                                 (function
                                   (lambda ( x )
                                     (cons (car x) (UniqueAssoc (cdr x)))
                                   )
                                 )
                                 (UniqueAssoc Att$lst)
                               )
                             )
                           )
                           Dwg$lst
                         )
                         Att$lst nil
                       )
                       (princ (strcat "\n-- N�o encontrei os atributos no arquivo: " (vl-filename-base dwg) ".dwg --"))
                     )
                   )
                   
                   (princ (strcat "\n** Erro abrindo o arquivo: " (vl-filename-base dwg)  ".dwg **"))
                 )
                 
               ) ; Foreach

               (if Express (setq ProgBar (acet-ui-progress)))

  ;;-------------------------------------------------------------------------------;;

               (if (and Dwg$lst (apply 'or (apply 'append (mapcar 'cadr Dwg$Lst))))
                 (progn

                   (setq xlApp     (vlax-get-or-create-object "Excel.Application")
                         
                         xlCells   (vlax-get-property
                                     (vlax-get-property
                                       (vlax-get-property
                                         (vlax-invoke-method
                                           (vlax-get-property xlApp "Workbooks")
                                             "Add"
                                         )
                                         "Sheets"
                                       )
                                       "Item" 1
                                     )
                                     "Cells"
                                   )
                   )

  ;;-------------------------------------------------------------------------------;;

                   (cond (  (eq "grp_file" *DLMAtributos_dwg*)
                   
                            (setq col 1 row 1 max_row 1)
                            (foreach Dwg (reverse Dwg$Lst)

                              (vlax-put-property xlCells 'Item row col (car Dwg))
                              (setq row (1+ row))
                              
                              (foreach Blk (cdr Dwg)
                               
                                (vlax-put-property xlCells 'Item row col (car Blk))
                                (setq row (1+ row))

                                (setq bAssoc (assoc (strcase (car Blk)) BlkLst))
                                
                                (foreach Tag
                                   (if (cdr bAssoc)
                                     (mapcar
                                       (function
                                         (lambda ( x ) (assoc x (cdr Blk)))
                                       )                                       
                                       (if (eq "1" *DLMAtributos_crd*)
                                         (append (cdr bAssoc) '("Block Coords"))
                                         (cdr bAssoc)
                                       )
                                     )
                                     (cdr Blk)
                                   )
                                  
                                  (setq old_row row)
                                  
                                  (vlax-put-property xlCells 'Item row col (car Tag))
                                  (setq row (1+ row))

                                  (foreach Val (cdr Tag)
                                    
                                    (vlax-put-property xlCells 'Item row col Val)
                                    (setq row (1+ row))

                                    (if (< max_row row) (setq max_row row))
                                  )
                                  (setq col (1+ col) row old_row)
                                )
                                (setq col 1 row (1+ max_row))
                              )
                              (setq row (1+ row))
                            )
                         )
                         (  (eq "grp_block" *DLMAtributos_dwg*)

                            (setq Dwg$Lst
                              (SortByFirst
                                (mapcar
                                  (function
                                    (lambda ( x )
                                      (cons (car x)
                                        (reverse (UniqueAssoc (cdr x)))
                                      )
                                    )
                                  )
                                  (UniqueAssoc
                                    (apply (function append)
                                      (mapcar (function cdr) Dwg$Lst)
                                    )
                                  )
                                )
                              )
                            )

                            (setq col 1 row 1 max_row 1)
                            (foreach Blk Dwg$Lst

                              (vlax-put-property xlCells 'Item row col (car Blk))
                              (setq row (1+ row))

                              (setq bAssoc (assoc (strcase (car Blk)) BlkLst))

                              (foreach Tag
                                 (if (cdr bAssoc)
                                   (mapcar
                                     (function
                                       (lambda ( x ) (assoc x (cdr Blk)))
                                     )                                     
                                     (if (eq "1" *DLMAtributos_crd*)
                                       (append (cdr bAssoc) '("Coords"))
                                       (cdr bAssoc)
                                     )
                                   )
                                   (cdr Blk)
                                 )
                                
                                (setq old_row row)

                                (vlax-put-property xlCells 'Item row col (car Tag))
                                (setq row (1+ row))

                                (foreach Val (cdr Tag)

                                  (vlax-put-property xlCells 'Item row col Val)
                                  (setq row (1+ row))

                                  (if (< max_row row) (setq max_row row))
                                )
                                (setq col (1+ col) row old_row)
                              )
                              (setq col 1 row (1+ max_row))
                            )
                         )
                         (t

                            (setq Dwg$Lst
                              (reverse
                                (UniqueAssoc                                  
                                  (apply (function append)
                                    (mapcar (function cdr)
                                      (apply (function append)
                                        (mapcar (function cdr) Dwg$Lst)
                                      )
                                    )
                                  )                                  
                                )
                              )
                            )

                            (setq TagAssocList
                              (vl-remove 'nil
                                (append 
                                  (setq UTags
                                    (Unique
                                      (apply (function append)
                                        (mapcar (function cdr) BlkLst)
                                      )
                                    )
                                  )
                                  (  (lambda ( data / extra )
                                       (mapcar
                                         (function
                                           (lambda ( x )
                                             (if (not (or (vl-position x UTags)
                                                          (vl-position x '("Arquivo" "Coords"))))
                                               (setq extra (cons x extra))
                                             )
                                           )
                                         )                                         
                                         (mapcar (function car) data)
                                       )                                       
                                       (reverse extra)
                                     )
                                    Dwg$Lst
                                  )
                                  '("Arquivo" "Coords")
                                )
                              )
                            )
                          
                            (setq col 1 row 1)
                          
                            (foreach Tag
                              (mapcar
                                (function
                                  (lambda ( x ) (assoc x Dwg$Lst))
                                )
                                TagAssocList
                              )

                              (vlax-put-property xlCells 'Item row col (car Tag))
                              (setq row (1+ row))

                              (foreach Val (cdr Tag)

                                (vlax-put-property xlCells 'Item row col val)
                                (setq row (1+ row))
                              )
                              (setq col (1+ col) row 1)
                            )
                          )
                   )
                   
                   ;;-------------------------------------------------------------------------------;;
                   
                   (vla-put-visible xlApp :vlax-true)

                   (princ (strcat "\n<< " (itoa (length dwLst)) " Desenhos processados >>"))
                 )
                 
                 (princ "\n** N�o foi encontrado dados suficientes para gerar **")
               )
               
               (DLM:WriteConfig cfgfname (mapcar 'eval SymList))
             )             
             (princ "*Cancel*")
           )

           (mapcar 'DLM:ReleaseObject (list dbx oDoc xlApp xlCells)) (gc) (gc)
        )        

;;-------------------------------------------------------------------------------;;

        (t

           ;;-------------------------------------------------------------------------------;;

           ;;                             --=={  Editor Mode  }==--                         ;;

           ;;-------------------------------------------------------------------------------;;
         

           (setq dcTitle    (strcat "Editor AtributosDLM V" Versao)

                 dcTagTitle "Novo valor de atributo")

           ;;                           --=={  Begin DCL While Loop  }==--                  ;;

           (while (not (vl-position dcflag '(1 0)))

             (cond (  (not (new_dialog "macedit" dcTag))

                      (DLM:Popup "Aten��o!" 16 "menu do editor de atributos n�o pode ser carregado.")
                      (princ "\n** DCL could not be Loaded **")

                      (setq dcFlag 0))

                   (t

                      (Make_Tag_List "tag_list" (setq *MacEdi_Lst* (SortByFirst *MacEdi_Lst*)))

                      (Dir_Text  "dir_text"   *MacEdi_pat*)
                      (set_tile  "sub_dir"    *MacEdi_def*)
                      (set_tile  "dcl_title"     dcTitle  )

                      (set_tile "block_name" (cond ( *MacEdi_blk* ) ("")))
                      (set_tile "tag_name"   (cond (    tag_str   ) ("")))
                      (set_tile "new_value"  (cond (    new_tag   ) ("")))
                    

                      (Dir_Mode (set_tile "cur_dwg" *MacEdi_cur*))

                      (action_tile "cur_dwg" "(Dir_Mode (setq *MacEdi_cur* $value))")

                      (action_tile "sub_dir" "(setq *MacEdi_def* $value)")
 
                      (action_tile "dir"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (if (setq tmp (DLM:DirectoryDialog "Selecione a pasta onde est�o os arquivos..." nil 0))
                                (Dir_Text "dir_text" (setq *MacEdi_pat* tmp))
                              )
                            )
                          )
                        )
                      )

                      (action_tile "rem"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (if *MacEdi_Lst*
                                (if (and ptr (listp (setq items (read (strcat "(" ptr ")")))))
                                  (progn
                                    (setq *MacEdi_Lst* (Remove_Items items *MacEdi_Lst*) ptr nil)
                                    (Make_Tag_List "tag_list" (setq *MacEdi_Lst* (SortByFirst *MacEdi_Lst*)))
                                  )                                
                                  (DLM:Popup "Informa��o" 48 "selecione uma tag na lista para poder remover.")
                                )
                                (DLM:Popup "Informa��o" 64 "sem tags para remover")
                              )
                            )
                          )
                        )
                      )

                      (action_tile "add"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (cond
                                (  (or (not *MacEdi_blk*) (eq "" *MacEdi_blk*))

                                   (DLM:Popup "Informa��o" 64 "digite o nome do bloco")
                                )
                                (  (not (snvalid *MacEdi_blk*))
                                 
                                   (DLM:Popup "Informa��o" 48 "nome do bloco inv�lido")
                                )                                
                                (  (or (not tag_str) (eq "" tag_str))
                                 
                                   (DLM:Popup "Informa��o" 64 "digite o nome da tag")
                                )                                
                                (  (or (not (snvalid tag_str)) (vl-string-position 32 tag_str))
                                 
                                   (DLM:Popup "Informa��o" 64
                                     (strcat "atributo inv�lido"
                                       (if (vl-string-position 32 tag_str)
                                         "\n\n[ tag n�o pode ter espa�os ]" ""
                                       )
                                     )
                                   )
                                )                                
                                (  (vl-position (strcase tag_str)
                                     (mapcar
                                       (function
                                         (lambda ( x ) (strcase (car x)))
                                       )
                                       *MacEdi_Lst*
                                     )
                                   )
                                 
                                   (DLM:Popup "Informa��o" 48 "tag j� existe na lista")
                                )                                
                                (t (mapcar (function set_tile) '("tag_name" "new_value") '("" ""))
                                 
                                   (and (eq "" new_tag) (setq new_tag nil))
                                 
                                   (Make_Tag_List "tag_list"
                                     (setq *MacEdi_Lst*
                                       (SortByFirst
                                         (cons (cons (strcase tag_str) new_tag) *MacEdi_Lst*)
                                       )
                                     )
                                   )
                                 
                                   (setq tag_str nil new_tag nil)
                                )
                              )
                            )
                          )
                        )
                      )
                    
                      (action_tile "clr"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (Make_Tag_List "tag_list" (setq *MacEdi_Lst* nil))
                            )
                          )
                        )
                      )

                      (action_tile "block_name" "(setq *MacEdi_blk* $value)")
                    
                      (action_tile "tag_name"   "(setq tag_str $value)")

                      (action_tile "new_value"  "(setq new_tag $value)")

                      (action_tile "block_pick" "(done_dialog 2)")

                      (action_tile "tag_pick"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (cond
                                (  (or (not *MacEdi_blk*) (eq "" *MacEdi_blk*))

                                   (DLM:Popup "Informa��o" 64 "digite o nome do bloco")
                                )                                
                                (  (not (snvalid *MacEdi_blk*))
                                 
                                   (DLM:Popup "Informa��o" 48 "nome do bloco inv�lido")
                                )                                
                                (  (not (tblsearch "BLOCK" *MacEdi_blk*))
                                 
                                   (DLM:Popup "Informa��o" 64
                                     (strcat "bloco n�o encontrado no desenho"
                                       "\nO bloco precisa estar no desenho para poder listar as tags"
                                     )
                                   )
                                )                                
                                (t (done_dialog 3) )
                              )
                            )
                          )
                        )
                      )

                      (action_tile "tag_list"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (setq #st (getvar "DATE") ptr $value)
                              
                              (if (and (eq dclkptr $value)
                                       (< (abs (read (rtos (- #en #st) 2 10))) DoubleClickTime))
                                (progn

                                  (setq n (nth (atoi ptr) *MacEdi_Lst*))

                                  (Make_Tag_List "tag_list"
                                    (setq *MacEdi_Lst*
                                      (SortByFirst
                                        (subst
                                          (Tag_Editor dcTag n) n *MacEdi_Lst*
                                        )
                                      )
                                    )
                                  )

                                  (setq dclkptr nil)
                                )                                
                                (setq #en (getvar "DATE") dclkptr $value)
                              )
                            )
                          )
                        )
                      )

                      (action_tile "accept"
                        (vl-prin1-to-string
                          (quote
                            (progn
                              (cond
                                (  (or (not *MacEdi_blk*) (eq "" *MacEdi_blk*))

                                   (DLM:Popup "Informa��o" 64 "digite o nome do bloco")
                                )                                
                                (  (not (snvalid *MacEdi_blk*))
                                 
                                   (DLM:Popup "Informa��o" 48 "nome do bloco inv�lido")
                                )                                
                                (  (not *MacEdi_Lst*)
                                 
                                   (DLM:Popup "Informa��o" 64 "adicione pelo menos uma tag na lista")
                                )                                
                                (t (done_dialog 1) )
                              )
                            )
                          )
                        )
                      )
                    
                      (action_tile "cancel" "(done_dialog 0)")

                      (setq dcflag (start_dialog))
                   )
             )

             ;;-------------------------------------------------------------------------------;;

             (cond (  (= 2 dcflag)

                      (while
                        (progn
                          (setq ent (car (entsel "\nSelecione um bloco: ")))

                          (cond (  (eq 'ENAME (type ent))

                                   (if (and (eq "INSERT" (cdr (assoc 0 (entget ent))))
                                            (= 1 (cdr (assoc 66 (entget ent)))))

                                     (not
                                       (setq *MacEdi_blk* (cond (  (vlax-property-available-p
                                                                      (setq obj (vlax-ename->vla-object ent)) 'EffectiveName)
                                                                    
                                                                    (vla-get-EffectiveName obj))

                                                                 (t (vla-get-Name obj)))
                                                
                                              *MacEdi_Lst* (mapcar
                                                             (function
                                                               (lambda ( x ) (cons (vla-get-TagString x)
                                                                                   (vla-get-TextString x)))
                                                             )
                                                             (vlax-invoke obj 'GetAttributes)
                                                           )
                                       )
                                     )
                                     
                                     (princ "\n** Objeto precisa ser um atributo de bloco **")
                                   )
                                )
                          )
                        )
                      )
                   )
                   (  (= 3 dcflag)

                      (while
                        (progn
                          (setq ent (car (nentsel "\nSelecione um atributo: ")))

                          (cond (  (eq 'ENAME (type ent))

                                   (if (eq "ATTRIB" (cdr (assoc 0 (entget ent))))

                                     (if
                                       (progn
                                         (setq obj
                                           (vla-objectidtoobject *adoc
                                             (vla-get-ownerid
                                               (vlax-ename->vla-object ent)
                                             )
                                           )
                                         )
                                         (eq (strcase *MacEdi_blk*)
                                           (strcase
                                             (cond
                                               (  (vlax-property-available-p obj 'EffectiveName)
                                                    
                                                   (vla-get-EffectiveName obj)
                                               )
                                               (t (vla-get-Name obj) )
                                             )
                                           )
                                         )
                                       )

                                       (not (setq tag_str (cdr (assoc 2 (entget ent)))
                                                  new_tag (cdr (assoc 1 (entget ent)))))

                                       (princ (strcat "\n** Tag precisa pertencer ao bloco: " *MacEdi_blk* " **"))
                                     )

                                     (princ "\n** Objeto precisa ser um atributo **")
                                   )
                                )
                          )
                        )
                      )
                   )
             )
           )

           ;;                        --=={  End of DCL While Loop  }==--                    ;;

           (setq dcTag (unload_dialog dcTag))

           (if (= 1 dcflag)
             (progn

               (setq Tag_Lst
                 (mapcar
                   (function
                     (lambda ( x ) (cons (strcase (car x)) (cdr x)))
                   )
                   *MacEdi_Lst*
                 )
               )

               (vlax-for doc (vla-get-Documents *acad)
                 (setq DocLst
                   (cons
                     (cons (strcase (vla-get-fullname doc)) doc) DocLst
                   )
                 )
               )

               (setq dbx (DLM:ObjectDBXDocument))

               (setq dwLst
                 (cond
                   ( (eq "1" *MacEdi_cur*)
                    
                     (list
                       (cond
                         (  (eq "" (vla-get-FullName *adoc))
                               
                            (strcat (vla-get-Path *adoc) (vla-get-Name *adoc)))
                        
                         (t (vla-get-FullName *adoc) )
                       )
                     )
                   )                   
                   ( (DLM:GetAllFiles *MacEdi_pat* (eq "1" *MacEdi_def*) "*.dwg") )
                 )
               )

               (if Express (setq ProgBar (acet-ui-progress "Atualizando atributos...Aguarde..." (length dwLst))))

               (foreach dwg dwLst

                 (if Express (acet-ui-progress -1))                 

                 (cond (  (setq flag (eq "1" *MacEdi_cur*))

                          (setq oDoc *adoc))

                       (  (setq flag (and (setq oDoc (cdr (assoc (strcase dwg) DocLst))))))

                       (t (setq flag (not (vl-catch-all-error-p
                                            (vl-catch-all-apply
                                              (function vla-open) (list dbx dwg)))))
                          (setq oDoc dbx)))

                 (if flag
                   (progn

                     (vlax-for lay (vla-get-layouts oDoc)

                       (vlax-for obj (vla-get-Block lay)

                         (if
                           (and
                             (eq "AcDbBlockReference" (vla-get-ObjectName obj))
                             (eq :vlax-true (vla-get-HasAttributes obj))
                             (eq (strcase *MacEdi_blk*)
                               (strcase
                                 (cond
                                   (  (vlax-property-available-p obj 'EffectiveName)
                                        
                                      (vla-get-EffectiveName obj))
                                   
                                   (t (vla-get-Name obj) )
                                 )
                               )
                             )
                           )
                           (progn

                             (foreach att (vlax-invoke obj 'GetAttributes)

                               (if (setq tag (assoc (strcase (vla-get-TagString att)) *MacEdi_Lst*))
                                 (progn
                                   
                                   (vla-put-InsertionPoint att
                                     (vlax-3D-point
                                       (CalcInsPt att (cond ( (cdr tag) ) ("")))
                                     )
                                   )

                                   (vla-put-TextString att (cond ( (cdr tag) ) ("")))
                                 )
                               )
                             )
                           )
                         )
                       )
                     )
                     (vla-saveas oDoc dwg)
                   )
                   (princ (strcat "\n** Erro abrindo o arquivo: " (vl-filename-base dwg)  ".dwg **"))
                 )
                 
               ) ; Foreach

               (if Express (setq ProgBar (acet-ui-progress)))

               ;;-------------------------------------------------------------------------------;;

               (princ (strcat "\n<< " (itoa (length dwLst)) " Desenhos processados >>"))

               (DLM:WriteConfig cfgfname (mapcar 'eval SymList))
             )
             
             (princ "\n*Cancelar*")
           )

           (mapcar 'DLM:ReleaseObject (list dbx oDoc)) (gc) (gc)
        )
    
  ) ;; COND

;;-------------------------------------------------------------------------------;;
  
  (mapcar (function setvar) vl ov)
  (princ)
)

;;-------------------------------------------------------------------------------;;

(vl-load-com)
(princ "\n By Daniel Lins Maciel 2016-10 ")
(princ "\n Comandos: Extrator: \"atributosEXT\"  Editor: \"atributosEDIT\" ")
(princ)