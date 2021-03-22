//arquivo daniel_cotas.dcl
menus : dialog {
	label = "Selecione abaixo:";
: row {
: boxed_column {
label = "TecnoMetal 2D";
: button {
         label = "Mercadorias";
         key = "2dmercadorias";
         mnemonic = "M";
             alignment = centered;
             width = 12;
             is_default = false;
        }
: button {
         label = "Mercadorias - Telhas";
         key = "tmerc";
         mnemonic = "T";
             alignment = centered;
             width = 12;
             is_default = false;
        }
        : button {
             label = "Materiais";
         key = "2dmateriais";
         mnemonic = "a";
             alignment = centered;
             width = 12;
			 is_default = false;
        }
        : button {
             label = "Tratamentos";
         key = "2dtratamentos";
         mnemonic = "t";
             alignment = centered;
             width = 12;
			 is_default = false;
        }
        : button {
             label = "Faces - Telhas";
			 		mnemonic = "f";	
         key = "ftelha";
         mnemonic = "t";
             alignment = centered;
             width = 12;
			 is_default = false;
        }
}
}
:row {
: boxed_column {
label = "TecnoMetal 3D";
: button {
         label = "3D Mercadorias";
         key = "3dmercadorias";
         mnemonic = "3";
             alignment = centered;
             width = 12;
             is_default = false;
        }
        : button {
             label = "3D Materiais";
         key = "3dmateriais";
         mnemonic = "d";
             alignment = centered;
             width = 12;
			 is_default = false;
        }
        : button {
             label = "3D Tratamentos";
         key = "3dtratamentos";
         mnemonic = "o";
             alignment = centered;
             width = 12;
			 is_default = false;
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
: button {
      key = "Cancelar";
      label = "Cancelar";
	   mnemonic = "C";
	   is_cancel = true;
width = 12;	  
      }
}




menus2 : dialog {
	label = "Selecione abaixo:";
: row {
: boxed_column {
label = "Ferramentas";
: button {
         label = "Gerar PDF";
         key = "gerarpdf";
		 		mnemonic = "P";	
                      alignment = centered;
             width = 12;
             is_default = false;
        }
        : button {
             label = "Marcação";
			 		mnemonic = "M";	
         key = "marcacao";
                      alignment = centered;
             width = 12;
			 is_default = false;
        }
        : button {
             label = "TXT, LTS e Purge";
			 		
         key = "gerar_dwt";
         mnemonic = "T";
             alignment = centered;
             width = 12;
			 is_default = false;
        }
        : button {
             label = "Faces - Telhas";
			 		mnemonic = "F";	
         key = "ftelha";
                      alignment = centered;
             width = 12;
			 is_default = false;
        }
}
: boxed_column {
label = "Utilidades";
: button {
         label = "Instalar";
         key = "instalador";
         mnemonic = "U";
             alignment = centered;
             width = 12;
             is_default = false;
        }
: button {
         label = "Ver Scripts";
         key = "scripts";
         mnemonic = "V";
             alignment = centered;
             width = 12;
             is_default = false;
        }	
: button {
         label = "Extrair 3D";
         key = "extrair3d";
         mnemonic = "x";
             alignment = centered;
             width = 12;
             is_default = false;
        }	

: button {
         label = "Formato PDF";
         key = "pdfcfg";
         mnemonic = "o";
             alignment = centered;
             width = 12;
             is_default = false;
        }	
		
       
: button {
         label = "PDF da Prancha";
         key = "pdfprancha";
         mnemonic = "F";
             alignment = centered;
             width = 12;
             is_default = false;
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
: button {
      key = "Cancelar";
      label = "Cancelar";
	   mnemonic = "C";
	   is_cancel = true;
width = 12;	  
      }
}




