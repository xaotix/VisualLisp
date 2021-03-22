telhas : dialog { 
          label = "Digite as cores:"; 
          : column { 
            : boxed_column { 
              : edit_box {
                key = "faceext";
                label = "Face externa:";
                edit_width = 15;
                value = "";
                initial_focus = true;
              }
              : edit_box {
                key = "faceint";
                label = "Face Interna:";
                edit_width = 15;
                value = "";
              }
            }
            : boxed_row {
              : button {
                key = "accept";
                label = " Ok ";
                is_default = true;
              }
              : button {
                key = "cancel";
                label = " Cancelar ";
                is_default = false;
                is_cancel = true;
              }
            }
          }

}