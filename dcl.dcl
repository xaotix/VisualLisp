// DCL File to be saved as listboxexample.dcl
lbox : list_box { width = 25; fixed_width = true; alignment = centered; }

listboxexample : dialog { label ="Selecione o tipo de produto"; spacer;
height = 20;
  : row {
      : lbox { key = "lst1"; label = "Grupo de Mercadoria" ; }
	  height = 19;
    : lbox { key = "lst2"; label = "Grupo de Mercadoria Externa"; width = 30; }
  }
        : button {
             label = "Ok";
         key = "ok";
         mnemonic = "c";
             alignment = centered;
             width = 12;
			 width = 8.0;
			fixed_width = true;
			is_default = true;
        }
        : button {
             label = "Cancelar";
         key = "cancel";
         mnemonic = "c";
             alignment = centered;
             width = 12;
			 width = 8.0;
			fixed_width = true;
        }
        : button {
             label = "Sobre";
         key = "sobre";
         mnemonic = "S";
             alignment = centered;
             width = 12;
			 width = 8.0;
			 action = "(mensagem_sobre)";
			fixed_width = true;
        }
}

materiais2 : dialog { label ="Selecione o Material a ser aplicado."; spacer;
height = 20;
  : row {
      : lbox { key = "lst1"; label = "Tipo de produto" ; }
	  height = 19;
    : lbox { key = "lst2"; label = "Material"; width = 30; }
  }
        : button {
             label = "Ok";
         key = "ok";
         mnemonic = "O";
             alignment = centered;
             width = 12;
			 width = 8.0;
			fixed_width = true;
			is_default = true;
        }
        : button {
             label = "Cancelar";
         key = "cancel";
         mnemonic = "c";
             alignment = centered;
             width = 12;
			 width = 8.0;
			fixed_width = true;
        }
        : button {
             label = "Sobre";
         key = "sobre";
         mnemonic = "s";
             alignment = centered;
             width = 12;
			 width = 8.0;
			 action = "(mensagem_sobre)";
			fixed_width = true;
        }
}