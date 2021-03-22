(defun c:smbs2 (/ ss lst tss olst ofile)
(vl-load-com)
(if (setq ss (ssget '((0 . "*TEXT")(8 . "3"))))
(progn
(setq lst
(mapcar
(function
(lambda (x)
(vla-get-TextString
(vlax-ename->vla-object x))))
(vl-remove-if 'listp
(mapcar 'cadr (ssnamex ss)))))
(foreach str (unique lst)
(if (setq tss
(ssget "_X"
(list '(0 . "*TEXT") (cons 1 str))))
(setq olst
(cons
(cons str (sslength tss)) olst))
(setq olst
(cons
(cons str 0.) olst))))
(setq ofile
;(open (strcat (getvar "DWGPREFIX")(substr (getvar "DWGNAME") 1(- (strlen(getvar "DWGNAME")) 4)) "-MBS.txt") "w"))
(open "c:\\TEMP\\REPORT.MBS.TXT" "w"))
(mapcar
(function
(lambda (x)
(write-line
(strcat "Peça: " (car x) "\t" "Qtd: " 
(vl-princ-to-string (cdr x))) ofile))) olst)
(close ofile)
(command "notepad" "c:\\TEMP\\REPORT.MBS.TXT")
(princ "Quantidades gravadas com sucesso!"))
(princ "\n<< Nada Selecionado! >>"))
(princ))

;; CAB
(defun unique (lst / result)
(reverse
(while (setq itm (car lst))
(setq lst (vl-remove itm lst)
result (cons itm result)))))

