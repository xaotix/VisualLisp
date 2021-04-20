(defun c:LERINI()
(setq inifile (strcat tm_com "\DAT\\Work.ini"))
(setq inifile2 (strcat diretorio "\DAT\\Lot.ini"))
(setq ARQUIVOINI_EQ (acet-ini-get inifile "Setting" "Oper" "ENGENHARIA"))
(acet-ini-set inifile2 "Setting" "Oper" ARQUIVOINI_EQ)
(acet-ini-set inifile2 "Setting" "LotName" TM_LOTTO)
(acet-ini-set inifile2 "Setting" "LotDesc" "ETAPA TECNOMETAL AJUSTADA COM LISP MERCADORIAS / POWERED BY MEDABIL - SA - DANIEL LINS MACIEL")
;(alert pasta)
(setq tm_dis ARQUIVOINI_EQ)
(tm:setup2)
)



;valida as pastas
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




(setq resultado "0")
(setq stringmarca "0")
(defun mensagem_sobre()
(alert "
-----------------------------------------------------
MERCADORIAS - V.10.1 - 24/06/2014
-----------------------------------------------------
By Daniel L. Maciel
daniel.maciel@medabil.com.br
-----------------------------------------------------
-----------------------------------------------------
COMANDOS:
-----------------------------------------------------
FERRAMENTAS - Suíte de aplicativos
-----------------------------------------------------
-----------------------------------------------------
CHANGELOG:
v.10 - Lisp Refeito. Ferramentas do Plot_PDf
adicionadas ao lisp.
v.10.1 - Adicionado Mercadorias de Telhas
-----------------------------------------------------
"))
(defun c:dlmutilidadessobre()
(mensagem_sobre))
(prompt "LISP MERCADORIAS CARREGADO v.10")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:MERCADORIAS2 ()

(setq stringmarca "DES_PEZ")
(alert "SOMENTE PARA 2D! \n NÃO Edite as mercadorias. Selecione os listados e aplique nas marcas.")
(MENU_LISTA)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:TMERC ()

(setq stringmarca "DES_PEZ")
(alert "SOMENTE PARA 2D! \n NÃO Edite as mercadorias. Selecione os listados e aplique nas marcas.")
(MENU_LISTA_TELHAS)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




(DEFUN C:3DMERCADORIAS ()

(setq stringmarca "DES_PEZ")
 (alert "SOMENTE PARA 3D!\nAplique as mercadorias\n Somente depois de marcar o modelo.")
(MENU_LISTA)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag3d_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:tratamentos ()

(setq stringmarca "TRA_PEZ")
 (alert "SOMENTE PARA 2D! \n NÃO EDITE OS TRATAMENTOS! \n SÃO SOMENTE OS TRATAMENTOS LISTADOS.")
(trt1)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:3dtratamentos ()

(setq stringmarca "TRA_PEZ")

 (alert "SOMENTE PARA 3D! \n NÃO EDITE OS TRATAMENTOS! \n SÃO SOMENTE OS TRATAMENTOS LISTADOS.") 
(trt1)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag3d_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:materiais2 ()

(setq stringmarca "MAT_PRO")
 (alert "SOMENTE PARA 2D!\n") 
(trt2)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFUN C:3dmateriais2 ()

(setq stringmarca "MAT_PRO")
(alert "SOMENTE PARA 3D!") 
(trt2)
(alerta_msg)
(if (= cancelei 0)(c:dlm_tag3d_aplica)(Prompt "Cancelado"))
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun alerta_msg()
(SETQ MENSAGEM2 (STRCAT "Não há descrição sobre a mercadoria " RESULTADO))
(if (= RESULTADO "CANTONEIRA")(setq MENSAGEM2 "CANTONEIRA\n Somente para cantoneira laminada sem acessório. Se tiver acessório, marque como SUPORTE"))
(if (= RESULTADO "VIGA LAM W")(setq MENSAGEM2 "VIGA LAM W\n Para todos os laminados W ou HP, com ou sem acessório."))
(if (= RESULTADO "PERFIL DE ROLAMENTO LAM")(setq MENSAGEM2 "PERFIL DE ROLAMENTO LAM\n Para todas as vigas de rolamento com perfil W ou HP, com ou sem acessório"))
(if (= RESULTADO "VIGA LAM GEN")(setq MENSAGEM2 "VIGA LAM GEN\n Fora o W e o HP. Para todos os laminados genericos (cantoneiras laminadas também se tiverem acessórios), com ou sem acessório."))
(if (= RESULTADO "VIGA SOLDADA")(setq MENSAGEM2 "VIGA SOLDADA\n Para todos os perfis soldados, com ou sem acessório."))
(if (= RESULTADO "VIGA DE ROLAMENTO SOLD")(setq MENSAGEM2 "VIGA DE ROLAMENTO SOLD\n Para todas as vigas de rolamento com perfis soldados."))
(if (= RESULTADO "VIGA CAIXAO SOLD")(setq MENSAGEM2 "VIGA CAIXAO SOLD\n Para todas as vigas caixão, com ou sem acessório."))
(if (= RESULTADO "PILARETE")(setq MENSAGEM2 "PILARETE\n Se o perfil for soldado: somente pecas menores que 2 metros. Se o perfil for laminado: somente perfis tipo W ou HP menores que 1,2 metros."))
(if (= RESULTADO "PONTALETE")(setq MENSAGEM2 "PONTALETE\n Se o perfil for soldado: somente pecas menores que 2 metros. Se o perfil for laminado: somente perfis tipo W ou HP menores que 1,2 metros."))
(if (= RESULTADO "CHUMBADOR")(setq MENSAGEM2 "CHUMBADOR\n Somente para chumbadores sem acessório com barra redonda"))
(if (= RESULTADO "INSERTO")(setq MENSAGEM2 "INSERTO\n Somente para insertos com barra redonda."))
(if (= RESULTADO "SUPORTE")(setq MENSAGEM2 "SUPORTE\n Peças com acessório e perfil dobrado, de comprimento de 50 a 6000 mm. Se forem somente pecas com chapas soldadas, que não seja um perfil I ou caixão, também. Se o perfil principal for uma terça padronizada, que fabrica nas purlins, marque como TERCA COM ACABAMENTO."))
(if (= RESULTADO "GRADE DE PISO")(setq MENSAGEM2 "GRADES DE PISO\n Grades de piso - Sempre terceirizadas."))
(if (= RESULTADO "CHAPA DE PISO")(setq MENSAGEM2 "Chapas de piso tipo xadrez ou similares que sejam sem acessório. Se for conjunto soldado, marque como PLATAFORMA/PASSARELA"))
(if (= RESULTADO "CHAPA")(setq MENSAGEM2 "CHAPA\nQualquer tipo de chapa que seja sem acessório e que não tenha dobra. Ex.: uma tala, uma chapa de nivelamento, etc. (maior ou igual a 1,55)"))
(if (= RESULTADO "PERFIL DOBRADO")(setq MENSAGEM2 "PERFIL DOBRADO\n Qualquer perfil dobrado que não seja padrão e que não tenha acessórios. Limite de tamanho: 6 metros. Se for maior, indicar solda de emenda em projeto e marcar posicões de até 6 metros. Se tiver acessório, marque como SUPORTE."))
(if (= RESULTADO "TIRANTE")(setq MENSAGEM2 "TIRANTE\n Tirante ou contravento com ou sem acessório."))
(if (= RESULTADO "GUARDA CORPO")(setq MENSAGEM2 "GUARDA CORPO\n Somente para qualquer tipo de guarda-corpo"))
(if (= RESULTADO "ESCADA")(setq MENSAGEM2 "ESCADA\n Somente escada totalmente soldada"))
(if (= RESULTADO "ESCADA MARINHEIRO")(setq MENSAGEM2 "ESCADA MARINHEIRO\n Somente Escada marinheiro metalica."))
(if (= RESULTADO "LATERAL DE ESCADA")(setq MENSAGEM2 "LATERAL DE ESCADAz\n Qualquer lateral de escada."))
(if (= RESULTADO "PLATAFORMA/PASSARELA")(setq MENSAGEM2 "PLATAFORMA/PASSARELA\n Plataforma ou passarela totalmente soldada."))
(if (= RESULTADO "DEGRAU")(setq MENSAGEM2 "DEGRAU\n Qualquer tipo de degrau de escada, menos se for purlin padrão, no caso marcar como TERCA COM ACABAMENTO. Se o degrau for com chapa expandida, marque como PLATAFORMA/PASSARELA."))
(if (= RESULTADO "TRELICA SOLDADA")(setq MENSAGEM2 "TRELICA SOLDADA\n Qualquer tipo de trelica que seja totalmente soldada."))
(if (= RESULTADO "TERCA COM ACABAMENTO")(setq MENSAGEM2 "TERCA COM ACABAMENTO \n Terca padrão que tenha recorte, acessório ou furacão especial.Somente terças que são fabricadas nas maquinas de purlin, que tenham dimensoes padronizadas, encontradas no manual. Se não atender estas premissas e tiver acessório: SUPORTE. Sem acessório: PERFIL DOBRADO."))
(if (= RESULTADO "TERCA PURLIN Z")(setq MENSAGEM2 "TERCA PURLIN Z\n Terca padrão, que tenha furacões padrão e não tenha acessórios ou recortes."))
(if (= RESULTADO "TERCA PURLIN C")(setq MENSAGEM2 "TERCA PURLIN C\n Terca padrão, que tenha furacões padrão e não tenha acessórios ou recortes."))
(if (= RESULTADO "BARJOIST")(setq MENSAGEM2 "Trelica soldada, sistema padrão barjoist."))
(if (= RESULTADO "CALHA")(setq MENSAGEM2 "Calha chapa fina, de espessura menor que 1,55."))
(if (= RESULTADO "ARREMATE")(setq MENSAGEM2 "Arremate chapa fina, de espessura menor que 1,55."))
(if (= RESULTADO "CARTOLA TRINS")(setq MENSAGEM2 "Perfil cartola chapa fina, de espessura menor que 1,55."))
(if (= RESULTADO "QUADRO DE TELA")(setq MENSAGEM2 "Quadro de tela de lanternin. Para quadro de zenital, marque como ARREMATE"))
(if (= RESULTADO "ROOF CURB")(setq MENSAGEM2 "Somente para roof curbs."))
(if (= RESULTADO "ABRACADEIRA")(setq MENSAGEM2 "Somente para abraçadeiras."))
(if (= RESULTADO "ARREMATE")(setq MENSAGEM2 "Somente para chapa fina."))
;
;

(if (= RESULTADO "CP SSR2")(setq MENSAGEM2 "Somente para TODO O SISTEMA DE TELHA SSR2 E SSR3 QUE SÃO EXECUTADAS EM OBRA."))
(if (= RESULTADO "SSR1")(setq MENSAGEM2 "Somente para TODO O SISTEMA DE TELHA SSR1 QUE É EXECUTADO SOMENTE INTERNA"))
(if (= RESULTADO "SSR2")(setq MENSAGEM2 "Somente para TODO O SISTEMA DE TELHA SSR2 E SSR3 QUE SÃO EXECUTADAS SOMENTE INTERNAS"))
(if (= RESULTADO "SSR1M")(setq MENSAGEM2 "Somente para TODO O SISTEMA DA NOVA TELHA SSR1 EM OBRA"))
(if (= RESULTADO "SSR1BM")(setq MENSAGEM2 "Somente para TODO O SISTEMA DA NOVA TELHA SSR1 BATIDA EM OBRA"))
(if (= RESULTADO "SSR1F")(setq MENSAGEM2 "Somente para TODO O SISTEMA DA NOVA TELHA SSR1 EM FABRICA"))
(if (= RESULTADO "SSR1BF")(setq MENSAGEM2 "Somente para TODO O SISTEMA DA NOVA TELHA SSR1 BATIDA EM FABRICA"))
(if (= RESULTADO "STEEL DECK")(setq MENSAGEM2 "Somente para TODO SISTEMA DE TELHA STEEL DECK QUE SÃO EXECUTADOS SOMENTE INTERNO"))
(if (= RESULTADO "PANEL RIB II")(setq MENSAGEM2 "Somente para TODO SISTEMA DE TELHA PANEL RIB II QUE SÃO EXECUTADOS SOMENTE INTERNO"))
(if (= RESULTADO "PANEL RIB III")(setq MENSAGEM2 "Somente para TODO SISTEMA DE TELHA PANEL RIB III QUE SÃO EXECUTADOS SOMENTE INTERNO"))
(if (= RESULTADO "TELHA ONDULADA")(setq MENSAGEM2 "Somente para SISTEMA DE TELHA PARA LANTERNIN E COM FABRICAÇÃO INTERNA"))
(if (= RESULTADO "TELHA FORRO")(setq MENSAGEM2 "Somente para SISTEMA DE TELHA  FORRO DA MEDABIL"))
(if (= RESULTADO "CALHA")(setq MENSAGEM2 "Somente para SISTEMA DE CALHA COM CHAPA FINA E FABRICAÇÃO INTERNA E/OU EXTERNA"))
(if (= RESULTADO "CUMEEIRA")(setq MENSAGEM2 "Somente para SISTEMA DE CUMEEIRA COM CHAPA FINA E FABRICAÇÃO INTERNA E/OU EXTERNA"))
(if (= RESULTADO "CAIXA DE COLETA")(setq MENSAGEM2 "Somente para SISTEMA DE CAIXA DE COLETA FORA DO PADRÃO"))
(if (= RESULTADO "TAMPAS")(setq MENSAGEM2 "Somente para SISTEMA DE TAMPAS DAS CALHAS"))
(if (= RESULTADO "LANTERNIN")(setq MENSAGEM2 "Somente para TODO O SISTEMA DE ESTRUTURA E ARREMATES QUE COMPÕEM O CONJUNTO LANTERNIN, COM FABRICAÇÃO INTERNA E/OU EXTERNA"))
(if (= RESULTADO "QUADRO DE TELA")(setq MENSAGEM2 "Somente para TODO O SISTEMA DE ESTRUTURA E ARREMATES QUE COMPÕEM O CONJUNTO LANTERNIN, COM FABRICAÇÃO INTERNA E/OU EXTERNA"))
(if (= RESULTADO "ILUMINACAO ZENITAL")(setq MENSAGEM2 "Somente para TODO O SISTEMA PADRÃO DE ILUMINAÇÃO COM FABRICAÇÃO INTERNA E/OU EXTERNA"))
(if (= RESULTADO "TELHA POLICARBONATO")(setq MENSAGEM2 "Somente para SISTEMA DE TELHA POLICARBONATO"))

;
;

;
;TRATAMENTOS
(if (= RESULTADO "A36")(setq MENSAGEM2 "MATERIAL A36 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "A572GR42")(setq MENSAGEM2 "MATERIAL A572GR42 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "A572GR50")(setq MENSAGEM2 "MATERIAL A572GR50 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "A588")(setq MENSAGEM2 "MATERIAL A588 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "SAE1008")(setq MENSAGEM2 "MATERIAL SAE1008 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "SAE1020")(setq MENSAGEM2 "MATERIAL SAE1020 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "CIVIL 300")(setq MENSAGEM2 "MATERIAL CIVIL 300 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "CIVIL 350")(setq MENSAGEM2 "MATERIAL CIVIL 350 SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(if (= RESULTADO "ZAR345-Z275 ZINC")(setq MENSAGEM2 "MATERIAL ZAR345-Z275 ZINC SELECIONADO \n LEMBRE-SE DE ATUALIZAR OS CAMS! SE FOR PROJETO 3D, APLIQUE OS MATERIAIS NO MODELO E EXTRAIA NOVAMENTE OS CAMS. SE FOR 2D, GERE NOVAMENTE OS CAMS."))
(ALERT MENSAGEM2)
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun trt2 ( / )
 (setq dcl_id (load_dialog "menu_materiais.dcl"))
 (if (not (new_dialog "pegar_info2" dcl_id))
 (exit)
 )
 	 (action_tile
    "cancel"						
    "(setq cancelei 1)(done_dialog) (prompt \"cancelado\")(princ)"		
    );action_tile
;(action_tile
 ;"cancel"						
 ;"(done_dialog) (prompt \"cancelado\")(princ)"		
 ;);action_tile
 (action_tile "accept" "(setq cancelei 0)(obtem_dados2)")
 (action_tile "sobre" "(mensagem_sobre)")
 (start_dialog)
 (pegar_info1)
 (unload_dialog dcl_id)
 (princ)
)
(defun pegar_info1 ()
(if (= A36 "1")(setq RESULTADO "A36"))
(if (= A572GR42 "1")(setq RESULTADO "A572GR42"))
(if (= A572GR50 "1")(setq RESULTADO "A572GR50"))
(if (= A588 "1")(setq RESULTADO "A588"))
(if (= SAE1008 "1")(setq RESULTADO "SAE1008"))
(if (= SAE1020 "1")(setq RESULTADO "SAE1020"))
(if (= CIVIL300 "1")(setq RESULTADO "CIVIL 300"))
(if (= CIVIL350 "1")(setq RESULTADO "CIVIL 350"))
(if (= ZAR345Z275ZINC "1")(setq RESULTADO "ZAR345-Z275 ZINC"))

)
(defun obtem_dados2 ()
	(setq A36 (get_tile "A36"))
	(setq A572GR42 (get_tile "A572GR42"))
	(setq A572GR50 (get_tile "A572GR50"))
	(setq A588 (get_tile "A588"))
	(setq SAE1008 (get_tile "SAE1008"))
	(setq SAE1020 (get_tile "SAE1020"))
	(setq CIVIL300 (get_tile "CIVIL300"))
	(setq CIVIL350 (get_tile "CIVIL350"))
	(setq ZAR345Z275ZINC (get_tile "ZAR345Z275ZINC"))

 (done_dialog)
 )
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun trt1 ( / )
 (setq dcl_id (load_dialog "menu_tratamentos.dcl"))
 (if (not (new_dialog "pegar_info1" dcl_id))
 (exit)
 )
(action_tile
 "cancel"						
 "(setq cancelei 1)(done_dialog) (prompt \"cancelado\")(princ)"		
 );action_tile
 (action_tile "accept" "(setq cancelei 0)(obtem_dados1)")
 (action_tile "sobre" "(mensagem_sobre)")
 (start_dialog)
 (pegar_info2)
 (unload_dialog dcl_id)
 (princ)
)
(defun pegar_info2 ()
(if (= FICHA_01 "1")(setq resultado "FICHA 01"))
(if (= FICHA_02 "1")(setq resultado "FICHA 02"))
(if (= FICHA_03 "1")(setq resultado "FICHA 03"))
(if (= FICHA_04 "1")(setq resultado "FICHA 04"))
(if (= FICHA_05 "1")(setq resultado "FICHA 05"))
(if (= FICHA_06 "1")(setq resultado "FICHA 06"))
(if (= FICHA_07 "1")(setq resultado "FICHA 07"))
(if (= FICHA_08 "1")(setq resultado "FICHA 08"))
(if (= FICHA_09 "1")(setq resultado "FICHA 09"))
(if (= SEM_PINTURA "1")(setq resultado "SEM PINTURA"))
)
(defun obtem_dados1 ()
(setq FICHA_01 (get_tile "FICHA_01"))
(setq FICHA_02 (get_tile "FICHA_02"))
(setq FICHA_03 (get_tile "FICHA_03"))
(setq FICHA_04 (get_tile "FICHA_04"))
(setq FICHA_05 (get_tile "FICHA_05"))
(setq FICHA_06 (get_tile "FICHA_06"))
(setq FICHA_07 (get_tile "FICHA_07"))
(setq FICHA_08 (get_tile "FICHA_08"))
(setq FICHA_09 (get_tile "FICHA_09"))
(setq SEM_PINTURA (get_tile "SEM_PINTURA"))
 (done_dialog)
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;
;
;
;;;;;;inicio rotina para mercadorias - menu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MENU_LISTA ( / *error* UpdateList data dclfile dclhandle )

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
("Perfis Laminados" ("VIGA LAM W" "PERFIL DE ROLAMENTO LAM" "VIGA LAM GEN"))
("Perfis Soldados" ("VIGA SOLDADA" "VIGA DE ROLAMENTO SOLD" "VIGA CAIXAO SOLD"))
("Perfis Miscelanea" ("PILARETE" "PONTALETE"))
("Purlin" ("TERCA COM ACABAMENTO" "TERCA PURLIN C" "TERCA PURLIN Z"))
("Cantoneira" ("CANTONEIRA"))
("Chumbacão" ("CHUMBADOR" "INSERTO"))
("Miscelanea" ("CHAPA" "PERFIL DOBRADO" "SUPORTE" "GRADE DE PISO" "CHAPA DE PISO" "TIRANTE" "GUARDA CORPO" "PLATAFORMA/PASSARELA"))
("Escada" ("LATERAL DE ESCADA"  "DEGRAU" "GUARDA CORPO" "ESCADA" "ESCADA MARINHEIRO" "PLATAFORMA/PASSARELA" ))
("Trelica" ("TRELICA SOLDADA"))
("Telhas" ("ROOF CURB" "ABRACADEIRA" "ARREMATE"))
)
)



 (cond
 ( (<= (setq dclHandle (load_dialog dclFile)) 0)

 (princ "\n--> Erro fatal.")
 )
 ( (not (new_dialog "listboxexample" dclHandle))

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





;;;;;;inicio rotina para mercadorias - menu;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun MENU_LISTA_TELHAS ( / *error* UpdateList data dclfile dclhandle )

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
("Telhas" ("PANEL RIB II" "PANEL RIB III" "TELHA ONDULADA" "TELHA FORRO" "CP SSR2" "SSR1" "SSR2" "SSR1M" "SSR1BM" "SSR1F" "SSR1BF"))
("Steel Deck" ("STEEL DECK"))
("Trins" ("ARREMATE" "CALHA" "CUMEEIRA" "CARTOLA TRINS" "CAIXA DE COLETA" "TAMPAS"))
("Lanternin" ("LANTERNIN" "QUADRO DE TELA"))
("Zenital" ("ILUMINACAO ZENITAL" "TELHA POLICARBONATO"))
("Outros" ("ROOF CURB" "ABRACADEIRA"))
)
)



 (cond
 ( (<= (setq dclHandle (load_dialog dclFile)) 0)

 (princ "\n--> Erro fatal.")
 )
 ( (not (new_dialog "listboxexample" dclHandle))

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



(defun c:dlm_tag_aplica (/ ss i e )
;
;(SETQ MENSAGEM (strcat RESULTADO "MENSAGEM"))
(command "tilemode" "1")
(vl-load-com)
(if (setq ss (ssget '((0 . "INSERT")(66 . 1))))
(repeat (setq i (sslength ss))
(setq e (vlax-ename->vla-object (ssname ss (setq i (1- i)) )))
(if (Eq (strcase (vla-get-effectivename e)) "M8_COM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_PRO")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_LAM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_ELE")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "M8_ELU")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_PRO")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_PRO_M")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_LAM_M")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_ELU_M")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_ELU")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_ELE_M")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_ELE")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)
(if (Eq (strcase (vla-get-effectivename e)) "P8_LAM")
(foreach itm (vlax-invoke e 'GetAttributes)
(if (eq (vla-get-tagstring itm) stringmarca)
(vla-put-textstring itm resultado)))
)

)
(Alert "Nenhuma marca foi selecionada!\n Rotina não foi aplicada.")
)(princ)
(prompt "FINALIZADO!")
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun C:dlm_tag3d_aplica ()
 (setq	gs	(ssget)
	i	0
	des_pez	RESULTADO
 )
 (repeat (sslength gs)
 (setq ent (ssname gs i))
 (if	(= (cdr (assoc 0 (entget ent))) "TEC_PROFILE3D")
 (command "tec_stsetvar3d"	ent "profiledata" stringmarca des_pez)
 )
 (setq i (1+ i))
 )
 (alert "Finalizado!") 
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;