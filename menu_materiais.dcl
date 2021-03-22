//arquivo daniel_cotas.dcl
pegar_info2 : dialog {
	label = "Escolha o tipo de material:";
: boxed_radio_column {
		label = "Tipo de Aço";
		alignment = centered;
		: radio_button {
			label = "A36";
			value = "0";
			key = "A36";
					mnemonic = "A";	
		}
		: radio_button {
			label = "A572GR42";
			value = "0";
			key = "A572GR42";
					mnemonic = "5";	
		}
		: radio_button {
			label = "A572GR50";
			value = "0";
			key = "A572GR50";
					mnemonic = "5";	
		}
		: radio_button {
			label = "A588";
			value = "0";
			key = "A588";
					mnemonic = "8";	
		}		
		: radio_button {
			label = "SAE1008";
			value = "0";
			key = "SAE1008";
					mnemonic = "S";	
		}
		: radio_button {
			label = "SAE1020";
			value = "0";
			key = "SAE1020";
					mnemonic = "S";	
		}
		: radio_button {
			label = "CIVIL 300";
			value = "0";
			key = "CIVIL300";
					mnemonic = "I";	
		}
		: radio_button {
			label = "CIVIL 350";
			value = "1";
			key = "CIVIL350";
					mnemonic = "C";	
		}
			: radio_button {
			label = "ZAR345-Z275 ZINC";
			value = "0";
			key = "ZAR345Z275ZINC";
					mnemonic = "Z";	
		}
: text_part {				
     label = "";
}
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