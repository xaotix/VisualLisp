(defun c:regenera_texto()
(command "-style" "romans" "romant.shx" "" "" "" "" "" "")
(command "regenall")
(command "-style" "romans" "romans.shx" "" "" "" "" "" "")
)