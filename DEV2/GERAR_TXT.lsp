;------ inicio gerar_dwt-------;
(defun c:gerar_dwt ( / )
    (SELETOR_DIRETORIO2)
  (princ)
)
(defun SELETOR_DIRETORIO2 nil
(SETQ lista2 (LM:getfiles "Gerar DWT's - V0.1a - By Daniel Lins Maciel" "" "dwg"))
(setq diretorio (getvar "dwgprefix"))
(setq arquivo_scr (strcat "c:\\temp\\"  "script_dwt_v0.2.scr"))
(if lista2
(progn
(setq script_dwt (open arquivo_scr "w")
count 0
)
(while (setq filename (nth count lista2))
(write-line (strcat "_open \"" filename "\"") script_dwt)
;(write-line formatofolha script_dwt)


(write-line "tec_lsdwt" scriptname)
(write-line arrumanome scriptname)
(write-line "_close" scriptname)
(write-line "n" scriptname)
(setq count (1+ count))
)
(close script_dwt)
;;;
)
)
(command "FILEDIA" "0")
(command "SCRIPT" arquivo_scr "filedia" "1")
(princ)

)
;------ mensagem sobre --------;
(defun mensagem_gerar_dwt()
(alert "-----------------------------------------------------
GERAR_DWT - V. 0.1 - Nov/2013
-----------------------------------------------------
By Daniel L. Maciel
daniel.maciel@medabil.com.br
-----------------------------------------------------
-----------------------------------------------------
COMANDOS:
-----------------------------------------------------

-----------------------------------------------------
Modo de uso:
-----------------------------------------------------

-----------------------------------------------------
CHANGELOG:
V.01: Lisp criado.
-----------------------------------------------------"))
;-------------------------------------------------------------
;-----------------fim gerar_dwt-------------------------------
