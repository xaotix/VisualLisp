(DEFUN c:instala_plot_pdf2 ()
(command "SHELL" "md C:\\plot_pdf")
(command "SHELL" "del C:\\plot_pdf\\*.dll")
(command "SHELL" "copy R:\\Lisps\\Plot_pdf\\*.dll C:\\plot_pdf\\*.dll")
(ALERT "PLOT_PDF ATUALIZADO.")
)
(DEFUN c:plot_pdf2 ()
(command "BACKGROUNDPLOT" "0")
(command "netload" "C:\\plot_pdf\\Lisps.dll" )
(command "PLOTAGEM")
)

(DEFUN c:plotagem_arquivo ()
(command "BACKGROUNDPLOT" "0")
(command "netload" "C:\\plot_pdf\\Lisps.dll" )
(command "ferramentas_plotagem_arquivo")
)
(DEFUN c:editar_blocos ()
(command "BACKGROUNDPLOT" "0")
(command "netload" "C:\\plot_pdf\\Lisps.dll" )
(command "edita_BLOCO")
)
(DEFUN c:editar_blocos_arquivos ()
(command "BACKGROUNDPLOT" "0")
(command "netload" "C:\\plot_pdf\\Lisps.dll" )
(command "edita_BLOCO_ARQUIVO")
)
(DEFUN c:plot_medabil ()
(command "BACKGROUNDPLOT" "0")
(command "netload" "C:\\plot_pdf\\Lisps.dll" )
(command "plotagem")
)