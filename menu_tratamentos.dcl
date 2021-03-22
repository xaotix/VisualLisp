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
			label = "GALVANIZADO COM JATO";
			value = "0";
			key = "GALVANIZADO_COM_JATO";
		mnemonic = "J";	
		}
		: radio_button {
			label = "PINTURA LÍQUIDA";
			value = "0";
			key = "PINTURA_LIQUIDA";
		mnemonic = "L";	
		}
		: radio_button {
			label = "PINTURA LÍQUIDA 2 DM";
			value = "0";
			key = "PINTURA_LIQUIDA_2_DM";
					mnemonic = "2";	
		}
		: radio_button {
			label = "PINTURA LÍQUIDA 3 DM";
			value = "0";
			key = "PINTURA_LIQUIDA_3_DM";
					mnemonic = "3";	
		}		
		: radio_button {
			label = "PINTURA PÓ";
			value = "0";
			key = "PINTURA_PO";
					mnemonic = "P";	
		}
		: radio_button {
			label = "PINTURA PÓ - 2 DM";
			value = "0";
			key = "PINTURA_PO_2_DM";
							mnemonic = "2";		
		}
		: radio_button {
			label = "PÓS PINTURA LÍQUIDA";
			value = "0";
			key = "POS_PINTURA_LIQUIDA";
					mnemonic = "S";	
		}
		: radio_button {
			label = "PÓS PINTURA PÓ";
			value = "0";
			key = "POS_PINTURA_PO";
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