//arquivo daniel_cotas.dcl
formatoDCL2 : dialog {
	label = "Selecione abaixo:";
: row {
: boxed_radio_column {
		label = "Configuração";
		fixed_width = true;
		alignment = centered;
        : toggle { 
        key = "purge"; 
        label = "Purge nos desenhos";
		mnemonic = "P";			
        }
        : toggle { 
        key = "gerartxt"; 
        label = "Gerar TXT"; 
		mnemonic = "T";	
        }
        : toggle { 
        key = "ajustalts"; 
        label = "Ajusta LTS";
		mnemonic = "L";		
        }
        : toggle { 
        key = "gerar_pdf"; 
        label = "Gerar PDF";
		mnemonic = "P";		
        }
        : toggle { 
        key = "geraraec"; 
        label = "Limpar AEC";
		mnemonic = "A";		
        }	
}
: boxed_column {
: button {
         label = "Iniciar!";
         key = "accept";
         mnemonic = "i";
             alignment = centered;
             width = 12;
             is_default = true;
        }
        : button {
             label = "Cancelar";
         key = "cancel";
         mnemonic = "C";
             alignment = centered;
             width = 12;
			 is_cancel = true;
        }
}
}
: text_part {				
     label = "";
}
: button {
      key = "sobre";
      label = "Sobre";
	  			 action = "(mensagem_sobre)";
	   mnemonic = "s";
width = 12;	  
      }
}