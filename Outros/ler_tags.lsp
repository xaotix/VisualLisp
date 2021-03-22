(defun c:tsel (/ *error* doc spc ss bPt cnt
lst tss olst tblObj cAtt i)
(vl-load-com)

(defun *error* (msg)
(and doc (vla-EndUndoMark doc))
(if
(not
(wcmatch
(strcase msg)
"*BREAK,*CANCEL*,*EXIT*"))
(princ
(strcat
"\n<< Error: " msg " >>")))
(princ))

(setq doc
(vla-get-ActiveDocument
(vlax-get-Acad-Object))
spc (if
(zerop
(vla-get-activespace doc))
(if (= (vla-get-mspace doc) :vlax-true)
(vla-get-modelspace doc)
(vla-get-paperspace doc))
(vla-get-modelspace doc)) i 2)
(cond ((eq 4 (logand 4 (cdr (assoc 70 (tblsearch "LAYER" (getvar "CLAYER"))))))
(princ "\n<< Current Layer Locked >>"))
(t
(if (and (setq ss (ssget '((0 . "*TEXT"))))
(setq bPt (getpoint "\nSelect Point for Table: ")))
(progn
(vla-StartUndoMark doc)
(setq lst
(mapcar
(function
(lambda (x)
(vla-get-TextString
(vlax-ename->vla-object x))))
(vl-remove-if 'listp
(mapcar 'cadr (ssnamex ss)))))
(foreach str (unique lst)
(setq cnt 0.)
(if (setq tss
(ssget "_X"
(list '(-4 . "<OR") '(-4 . "<AND") '(0 . "*TEXT") (cons 1 str) '(-4 . "AND>")
'(-4 . "<AND") '(0 . "INSERT") '(66 . 1) '(-4 . "AND>") '(-4 . "OR>"))))
(foreach Obj (mapcar 'vlax-ename->vla-object
(mapcar 'cadr (ssnamex tss)))
(cond ((eq "AcDbBlockReference" (vla-get-ObjectName Obj))
(foreach Att (append
(vlax-safearray->list
(vlax-variant-value
(vla-getAttributes Obj)))
(if
(not
(vl-catch-all-error-p
(setq cAtt
(vl-catch-all-apply
'vlax-safearray->list
(list
(vlax-variant-value
(vla-getConstantAttributes Obj)))))))
cAtt))
(if (eq Str (vla-get-TextString Att))
(setq cnt (1+ cnt)))))
(t (setq cnt (1+ cnt))))))
(setq oLst (cons (cons str cnt) oLst)))
(setq tblObj
(vla-addTable spc
(vlax-3D-point bPt)
(+ 2 (length olst)) 2 (* 1.5 (getvar "DIMTXT"))
(* (apply 'max
(mapcar 'strlen
(append '("String")
(apply 'append
(mapcar
(function
(lambda (x)
(list (car x)
(rtos (cdr x) 2 0)))) olst)))))
2.0 (getvar "DIMTXT"))))
(vla-setText tblObj 0 0 "String Counter")
(vla-setText tblObj 1 0 "String") 
(vla-setText tblObj 1 1 "Count")
(foreach x (vl-sort olst
(function
(lambda (a b)
(< (car a) (car b)))))
(vla-setText tblObj i 0 (car x))
(vla-setText tblObj i 1 (rtos (cdr x) 2 0))
(setq i (1+ i)))
(vla-EndUndoMark doc)))))
(princ))


;; CAB
(defun unique (lst / result)
(reverse
(while (setq itm (car lst))
(setq lst (vl-remove itm lst)
result (cons itm result)))))