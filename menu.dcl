//arquivo daniel_cotas.dcl
formatoDCL : dialog {
	label = "Escolha o formato da folha:";
: row {
: boxed_radio_column {
		label = "Configuração";
		fixed_width = true;
		alignment = centered;
		: radio_button {
			label = "A4";
			value = "0";
			key = "A4";
					mnemonic = "4";	
		}
		: radio_button {
			label = "A3";
			value = "1";
			key = "A3";
					mnemonic = "3";	
		}
		: radio_button {
			label = "A2";
			value = "0";
			key = "A2";
					mnemonic = "2";	
		}
}
: boxed_column {
: button {
         label = "Ok!";
         key = "accept";
         mnemonic = "O";
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
	  			 action = "(mensagem_sobre)";
      label = "Sobre";
	   mnemonic = "S";
width = 12;	  
      }
}