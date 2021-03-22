(defun c:dlm_limpar (/ *error* uFlag)
  (vl-load-com)

  (defun *error* (msg)
    (and uFlag (vla-EndUndoMark *doc))
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Error: " msg " **")))
    (princ))

  (setq *doc (cond (*doc) ((vla-get-ActiveDocument
                             (vlax-get-acad-object)))))

  (setq uFlag (not (vla-StartUndoMark *doc)))

  (vlax-for blk (vla-get-Blocks *doc)
    
    (if (eq :vlax-true (vla-get-isXref blk))
      (if (vl-catch-all-error-p
            (vl-catch-all-apply
              (function vla-Detach) (list blk)))
        (princ (strcat "\n** Error Detaching Xref: "
                       (vla-get-name blk) " **")))))

  (vlax-for lay (vla-get-Layers *doc)    
    (vla-put-Lineweight lay acLnWt025)
    (vla-put-LayerOn lay :vlax-true))

  ;(vlax-for lay (vla-get-layouts *doc)
   ; (if (not (eq "MODEL" (strcase (vla-get-Name lay))))
    ;  (vla-delete lay)))

  ;(vlax-for v (vla-get-views *doc)
   ; (vla-delete v))

  (command "_.-scalelistedit" "_R" "_Y" "_E")

  (vl-Catch-All-Apply
    (function
      (lambda nil
        (vla-Remove
          (vla-GetExtensionDictionary (vla-Get-Layers *doc)) "ACAD_LAYERFILTERS"))))

  (if (setq states (layerstate-getnames t t))
    (mapcar (function layerstate-delete) states))

  (repeat 3 (vla-PurgeAll *doc))

  (mapcar (function setvar)
          
          '("CLAYER" "INSBASE"        "LTSCALE" "MSLTSCALE" "PSLTSCALE")
          '(  "0"     (0 0 0)         10           10           1    ))

  (setq uFlag (vla-EndUndoMark *doc))
  (princ))