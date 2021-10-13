
	Dim $itmOLD, $itmNew
	Dim $itmOLD_1, $itmOLD_2, $itmOLD_3, $itmOLD_4, $itmOLD_5
	Dim $itmOLD_4_1, $itmOLD_4_2

	Dim $itmNew_1, $itmNew_2, $itmNew_3, $itmNew_4
	Dim $itmNew_3_1 ; $itmNew_3_2, $itmNew_3_3, $itmNew_3_4, $itmNew_3_5

;-------------------------------------------------------------------------
Func cmdBibleAdd_Click ()

	Local $item

	Const $conLeftSide3 = 10, $conTop = 10
	Local $GUIWidth = 400, $GUIHeight = 350

	Local $treeview

	Local $acMapFalther[76]
	Local $OK_Btn
;	Local $acItm_Data [76]

	Local $msg

	Local $itemBIble [74], $acMapFalther [74]
	Local $lngCnt

	$frmBibleAdd = GUICreate("العناوين الاساسية بالكتاب المقدس", $GUIWidth, $GUIHeight,-1,-1, _
		formStyle (),  formExStyle (), $frmMainForm) ;0x00800000 , $frmMainForm

		;BitOR ($DS_SETFOREGROUND,$DS_MODALFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_POPUPWINDOW),$WS_EX_TOPMOST + $WS_EX_STATICEDGE + $WS_EX_LAYOUTRTL, $frmMainForm) ;0x00800000
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmBibleAdd )

	$treeview = GUICtrlCreateTreeView($conLeftSide3, $conTop, $GUIWidth - 2*$conLeftSide3, $GUIHeight - 2 * $conTop - 60, _
		BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)

	$itmOLD = GUICtrlCreateTreeViewItem("العهد القديم", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)

		$itmOLD_1 = GUICtrlCreateTreeViewItem("التوراة - أسفار موسى", $itmOLD)
		$itmOLD_2 = GUICtrlCreateTreeViewItem("الكتب التاريخية", $itmOLD)
		$itmOLD_3 = GUICtrlCreateTreeViewItem("الاسفار الشعرية", $itmOLD)
		$itmOLD_4 = GUICtrlCreateTreeViewItem("أسفار الانبياء", $itmOLD)
			$itmOLD_4_1 = GUICtrlCreateTreeViewItem("الانبياء الكبار", $itmOLD_4)
			$itmOLD_4_2 = GUICtrlCreateTreeViewItem("الانبياء الصغار", $itmOLD_4)
		$itmOLD_5 = GUICtrlCreateTreeViewItem("الاسفار القانونية الثانية", $itmOLD)


	$itmNew = GUICtrlCreateTreeViewItem("العهد الجديد", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)

		$itmNew_1 = GUICtrlCreateTreeViewItem("البشائر الاربعة - الانجيل", $itmNew)
		$itmNew_2 = GUICtrlCreateTreeViewItem("القسم التاريخى - الابركسيس", $itmNew)
		$itmNew_3 = GUICtrlCreateTreeViewItem("الرسائل التعليمة - الكاثوليكون", $itmNew)
			$itmNew_3_1 = GUICtrlCreateTreeViewItem("رسائل بولس - البولس", $itmNew_3)

		$itmNew_4 = GUICtrlCreateTreeViewItem("السفر النبوى", $itmNew)

	Local $lngCnt
;	For $lngCnt =1 to 73
;		$acItm_Data [$lngCnt] = GUICtrlCreateTreeViewItem($avArray [$lngCnt], $acMapFalther[$lngCnt])
;	Next


 	$OK_Btn = GUICtrlCreateButton("موافق", $GUIWidth/2 - $conLeftSide3  -35, $GUIHeight -$conTop -40, 100, 30, _
		bitor ($WS_TABSTOP, $BS_NOTIFY, $BS_DEFPUSHBUTTON))

	GUICtrlSetState($itmOld, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "General"-item and paint in bold
	GUICtrlSetState($itmNew, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "Display"-item and paint in bold

	GUISetState()
	GUICtrlSetState ($treeview, $GUI_FOCUS)
	Opt("GUIOnEventMode", 0)

	While 1

		$msg = GUIGetMsg(1)
		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmBibleAdd)
				frmBibleAdd_Close ()
				Return

			Case $msg[0] = $OK_Btn

				;$item = _ArraySearch ($acItm_Data, $item)
				if $item >  0  and $item <= 73 Then
					ReadBible ($item,1)
				EndIf

				frmBibleAdd_Close ()
				Return


	EndSelect
	WEnd

EndFunc   ;==>Example
;-------------------------------------------------------------------------

Func ReadBible ($iBible, $ichpt)
		CurBible ($iBible) ;$a_Settings [3] = $iBible
		CurChptr ($ichpt) ;$a_Settings [4] = $ichpt
		CurAyaFrom(1)
		CurAyaTo(1000)

		if CurAyaChk () <> 0 Then
			CurAyaChk (1)
		EndIf

	UpdateTxt()

EndFunc
;-------------------------------------------------------------------------
Func frmBibleAdd_Close ()

	IF IsPtr ( $frmBibleAdd ) Then
		GUIDelete($frmBibleAdd)
		$frmBibleAdd = 0
	EndIf

EndFunc
