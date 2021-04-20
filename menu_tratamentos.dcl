//arquivo daniel_cotas.dcl
pegar_info1 : dialog {
	label = "Escolha o tipo de tratamento:";
: boxed_radio_column {
		label = "Tramentos";
		alignment = centered;
		: radio_button {
			label = "GALVANIZADO";
			value = "0";
			key = "GALVANIZADO";
		mnemonic = "G";	
		}
		: radio_button {
			label = "FICHA 01";
			value = "0";
			key = "FICHA_01";
		mnemonic = "J";	
		}
		: radio_button {
			label = "FICHA 02";
			value = "0";
			key = "FICHA_02";
		mnemonic = "L";	
		}
		: radio_button {
			label = "FICHA 03";
			value = "0";
			key = "FICHA_03";
					mnemonic = "2";	
		}
		: radio_button {
			label = "FICHA 04";
			value = "0";
			key = "FICHA_04";
					mnemonic = "3";	
		}		
		: radio_button {
			label = "FICHA 05";
			value = "0";
			key = "FICHA_05";
					mnemonic = "P";	
		}
		: radio_button {
			label = "FICHA 06";
			value = "0";
			key = "FICHA_06";
							mnemonic = "2";		
		}
		: radio_button {
			label = "FICHA 07";
			value = "0";
			key = "FICHA_07";
					mnemonic = "S";	
		}
		: radio_button {
			label = "FICHA 08";
			value = "0";
			key = "FICHA_08";
					mnemonic = "R";	
		}
		: radio_button {
			label = "FICHA 09";
			value = "0";
			key = "FICHA_09";
					mnemonic = "R";	
		}
		: radio_button {
			label = "SEM PINTURA";
			value = "1";
			key = "SEM_PINTURA";
					mnemonic = "E";	
		}
}
: text_part {				
     label = "";
}
: button {
         label = "Aplicar!";
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
: button {
      key = "sobre";
      label = "Sobre";
	  			 action = "(mensagem_sobre)";
	   mnemonic = "S";
width = 12;	  
      }
}