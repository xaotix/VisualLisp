(defun c:smbs


   ( /

    *error*
    _StartUndo
    _EndUndo
    _Assoc++
    _SumAttributes
    _GetTextString
    _ApplyFooToSelSet

    acdoc
    acspc
    alist
    data
    pt

  )
(alert "
-------- Gerador de quantidades 1.0 --------
Este programa quantifica as ocorrências
em que os itens da LAYER 3 (MBS) 
selecionados se repetem e gera uma 
tabela.

-------------------------------------------

Como Usar:
1 - Defina a escala da cota;
2 - Execute SMBS;
3 - Selecione os itens;
4 - Confirme
5 - Clique no ponto de inserção da
tabela.

-------------------------------------------")
(SETQ TAMANHO (getvar "dimscale"))
(setq tamanhox2 (* tamanho 2))
(command "-style" "Standard" "arial.ttf" tamanhox2 "0.8" "0" "No" "No" "No" "")
;;------------------------------------------------------------;;
  
  (defun *error* ( msg )
    (if acdoc (_EndUndo acdoc))
    (if (not (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*"))
      (princ (strcat "\n** Erro: " msg " **"))
    )
    (princ)
  )

;;------------------------------------------------------------;;

  (defun _StartUndo ( doc ) (_EndUndo doc)
    (vla-StartUndoMark doc)
  )
  
;;------------------------------------------------------------;;

  (defun _EndUndo ( doc )
    (if (= 8 (logand 8 (getvar 'UNDOCTL)))
      (vla-EndUndoMark doc)
    )
  )

;;------------------------------------------------------------;;

  (defun _Assoc++ ( key alist )
    (
      (lambda ( pair )
        (if pair
          (subst (list key (1+ (cadr pair))) pair alist)
          (cons  (list key 1) alist)
        )
      )
      (assoc key alist)
    )
  )

;;------------------------------------------------------------;;

  (defun _SumAttributes ( entity alist )
    (while
      (not
        (eq "SEQEND"
          (cdr
            (assoc 0
              (entget
                (setq entity (entnext entity))
              )
            )
          )
        )
      )
      (setq alist (_Assoc++ (_GetTextString entity) alist))
    )
  )

;;------------------------------------------------------------;;
  
  (defun _GetTextString ( entity )    
    (
      (lambda ( string )
        (mapcar
          (function
            (lambda ( pair )
              (if (member (car pair) '(1 3))
                (setq string (strcat string (cdr pair)))
              )
            )
          )
          (entget entity)
        )
        string
      )
      ""
    )
  )

;;------------------------------------------------------------;;

  (defun _ApplyFooToSelSet ( foo ss / i )
    (if ss (repeat (setq i (sslength ss)) (foo (ssname ss (setq i (1- i))))))
  )

;;------------------------------------------------------------;;

  (setq acdoc (vla-get-activedocument (vlax-get-acad-object))
        acspc (vlax-get-property acdoc (if (= 1 (getvar 'CVPORT)) 'Paperspace 'Modelspace))
  )
  (cond
    ( (= 4 (logand 4 (cdr (assoc 70 (tblsearch "LAYER" (getvar 'CLAYER))))))
      (princ "\nA layer atual está travada.")
    )
    ( (not (vlax-method-applicable-p acspc 'AddTable))
      (princ "\nGeração de tabela não está disponível nesta versão do AutoCAD.")
    )
    ( (and
        (setq data
          (_ApplyFooToSelSet
            (lambda ( entity / typ )
              (setq alist
                (cond
                  ( (eq "INSERT" (setq typ (cdr (assoc 0 (entget entity)))))
                    (_SumAttributes entity alist)
                  )
                  ( (eq "MULTILEADER" typ)
                    (_Assoc++ (cdr (assoc 304 (entget entity))) alist)
                  )
                  ( (wcmatch typ "*DIMENSION")
                    (_Assoc++ (cdr (assoc 1 (entget entity))) alist)
                  )
                  ( (_Assoc++ (_GetTextString entity) alist) )
                )
              )
            )
			(ssget '((0 . "*TEXT")(8 . "3")))
            ;(ssget
            ; '(
            ;    (-4 . "<OR")
            ;      (0 . "TEXT,MTEXT,MULTILEADER")
            ;      (-4 . "<AND")
            ;        (0 . "INSERT")
            ;        (66 . 1)
            ;      (-4 . "AND>")
            ;      (-4 . "<AND")
            ;        (0 . "*DIMENSION")
            ;        (1 . "*?*")
            ;      (-4 . "AND>")
            ;    (-4 . "OR>")
            ;  )
            ;)
          )
        )
        (setq pt (getpoint "\nClique no ponto de inserção da tabela: "))
      )
      (_StartUndo acdoc)
      (LM:AddTable acspc (trans pt 1 2) "Quantidades"
        (cons (list "Desc." "Qtd.")
          (vl-sort
            (mapcar
              (function
                (lambda ( x ) (list (car x) (itoa (cadr x))))
              )
              data
            )
            (function (lambda ( a b ) (< (car a) (car b))))
          )            
        )
      )
      (_EndUndo acdoc)
    )
  )
  (princ)
  (princ "Powered By Daniel Lins Maciel - 08/08/2014.")
)


(defun LM:AddTable ( space pt title data / _isAnnotative textheight style )

  (defun _isAnnotative ( style / object annotx )
    (and
      (setq object (tblobjname "STYLE" style))
      (setq annotx (cadr (assoc -3 (entget object '("ROMANS")))))
      (= 1 (cdr (assoc 1070 (reverse annotx))))
    )
  )

  (
    (lambda ( table ) (vla-put-StyleName table (getvar 'CTABLESTYLE)) (vla-SetText table 0 0 title)
      (
        (lambda ( row )
          (mapcar
            (function
              (lambda ( rowitem ) (setq row (1+ row))
                (
                  (lambda ( column )
                    (mapcar
                      (function
                        (lambda ( item )
                          (vla-SetText table row (setq column (1+ column)) item)
                        )
                      )
                      rowitem
                    )
                  )
                  -1
                )
              )
            )
            data
          )
        )
        0
      )
      table
    )
    (
      (lambda ( textheight )
        (vla-AddTable space (vlax-3D-point pt) (1+ (length data)) (length (car data)) textheight
          (* 1 textheight
            (apply 'max
              (cons (/ (strlen title) (length (car data)))
                (mapcar 'strlen (apply 'append data))
              )
            )
          )
        )
      )
      (* 1.2
        (/
          (setq textheight
            (vla-gettextheight
              (setq style
                (vla-item
                  (vla-item
                    (vla-get-dictionaries (vla-get-document space)) "ACAD_TABLESTYLE"
                  )
                  (getvar 'CTABLESTYLE)
                )
              )
              acdatarow
            )
          )
          (if (_isAnnotative (vla-gettextstyle style acdatarow))
            (cond ( (getvar 'CANNOSCALEVALUE) ) ( 1.0 ))
            1.0
          )
        )
      )
    )
  )
)