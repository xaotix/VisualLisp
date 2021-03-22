(vl-load-com)
(defun c:CreateTableStyle()
    ;; Get the AutoCAD application and current document
    (setq acad (vlax-get-acad-object))
    (setq doc (vla-get-ActiveDocument acad))

    ;; Get the Dictionaries collection and the TableStyle dictionary
    (setq dicts (vla-get-Dictionaries doc))
    (setq dictObj (vla-Item dicts "acad_tablestyle"))
    
    ;; Create a custom table style
    (setq key "MyTableStyle"
          class "AcDbTableStyle")
    (setq custObj (vla-AddObject dictObj key class))

    ;; Set the name and description for the style
    (vla-put-Name custObj "MyTableStyle")
    (vla-put-Description custObj "This is my custom table style")

    ;; Sets the bit flag value for the style
    (vla-put-BitFlags custObj 1)

    ;; Sets the direction of the table, top to bottom or bottom to top
    (vla-put-FlowDirection custObj acTableTopToBottom)

    ;; Sets the supression of the table header
    (vla-put-HeaderSuppressed custObj :vlax-false)

    ;; Sets the horizontal margin for the table cells
    (vla-put-HorzCellMargin custObj 0.22)

    ;; Sets the supression of the table title
    (vla-put-TitleSuppressed custObj :vlax-false)

    ;; Sets the vertical margin for the table cells
    (vla-put-VertCellMargin custObj 0.22)

    ;; Set the alignment for the Data, Header, and Title rows
    (vla-SetAlignment custObj (+ acDataRow acTitleRow) acMiddleLeft)
    (vla-SetAlignment custObj acHeaderRow acMiddleCenter)

    ;; Set the background color for the Header and Title rows
    (setq colObj (vlax-create-object "AutoCAD.AcCmColor.19"))
    (vla-SetRGB colObj 98 136 213)
    (vla-SetBackgroundColor custObj (+ acHeaderRow acTitleRow) colObj)

    ;; Clear the background color for the Data rows
    (vla-SetBackgroundColorNone custObj acDataRow :vlax-true)

    ;; Set the bottom grid color for the Title row
    (vla-SetRGB colObj 0 0 255)
    (vla-SetGridColor custObj acHorzBottom acTitleRow colObj)

    ;; Set the bottom grid lineweight for the Title row
    (vla-SetGridLineWeight tableStyle acHorzBottom acTitleRow acLnWt025)

    ;; Set the inside grid lines visible for the data and header rows
    (vla-SetGridVisibility custObj acHorzInside  (+ acDataRow acHeaderRow) :vlax-true)

    ;; Set the text height for the Title, Header and Data rows
    (vla-SetTextHeight custObj acTitleRow 1.5)
    (vla-SetTextHeight custObj (+ acDataRow acHeaderRow) 1.0)

    ;; Set the text height and style for the Title row
    (vla-SetTextStyle custObj (+ acDataRow acHeaderRow acTitleRow) "Standard")

    ;; Release the color object
    (vlax-release-object colObj)
  (princ)
)