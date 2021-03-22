(defun c:StringCount (/ *error* BPT CNT DOC ENT I LST OLST SI SPC SS STR TBLOBJ UFLAG)
(vl-load-com)
;; Lee Mac ~ 22.03.10

(defun *error* (msg)
(and uFlag (vla-EndUndoMark doc))
(or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
(princ (strcat "\n** Erro: " msg " **")))
(princ))


(setq doc (vla-get-ActiveDocument
(vlax-get-Acad-Object))

spc (if (or (eq AcModelSpace (vla-get-ActiveSpace doc))
(eq :vlax-true (vla-get-MSpace doc)))
(vla-get-ModelSpace doc)
(vla-get-PaperSpace doc)) i 1)


(cond ( (eq 4 (logand 4 (cdr (assoc 70 (tblsearch "LAYER" (getvar "CLAYER"))))))

(princ "\n<< A Layer atual está bloqueada >>"))

( (and (setq si -1 ss (ssget '((0 . "TEXT,MTEXT"))))
(setq bPt (getpoint "\nSelecione o ponto de inserção da tabela: ")))

(while (setq ent (ssname ss (setq si (1+ si))))
(if (not (vl-position (setq str (cdr (assoc 1 (entget ent)))) lst))
(setq lst (cons str lst))))

(foreach str lst

(setq cnt (sslength (ssget "_X" (list (cons 0 "TEXT,MTEXT") (cons 1 str)))))

(if (setq si -1 ss (ssget "_X" (list (cons 0 "INSERT") (cons 66 1))))

(while (setq ent (ssname ss (setq si (1+ si))))

(while (not (eq "SEQEND" (cdr (assoc 0 (entget (setq ent (entnext ent)))))))
(if (eq str (cdr (assoc 1 (entget ent))))
(setq cnt (1+ cnt))))))

(setq OLst (cons (list (strlen str) str cnt) OLst)))

(setq uFlag (not (vla-StartUndoMark doc))

tblObj (vla-addTable spc (vlax-3D-point bPt) (+ 2 (length olst)) 2
(* 1.5 (getvar "DIMTXT"))
(* (apply (function max)
(cons 6 (mapcar (function car) OLst))) 2. (getvar "DIMTXT"))))

(vla-setText tblObj 0 0 "Quantidades")
(vla-setText tblObj 1 0 "Descrição")
(vla-setText tblObj 1 1 "Qtd")

(foreach x (vl-sort (mapcar (function cdr) olst)
(function (lambda (a b) (< (car a) (car b)))))

(vla-setText tblObj (setq i (1+ i)) 0 (car x))
(vla-setText tblObj i 1 (itoa (cadr x)))) 

(setq uFlag (vla-EndUndoMark doc))))

(princ))