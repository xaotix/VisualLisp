(setq filename "R:\\Lisps\\")
(setq valida (vl-file-directory-p filename))
(if (= valida T) ((prompt (strcat "Verificando se a pasta " filename " existe... OK!\n")(load "R:\\Lisps\\mercadorias.VLX")))(Alert "Não há mais necessidade de carregar o lisp Plot_PDF, as ferramentas foram todas unificadas para o lisp Mercadorias.vlx."))


