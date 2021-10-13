
Dim $itmOLD, $itmNew
Dim $itmOLD_1, $itmOLD_2, $itmOLD_3, $itmOLD_4, $itmOLD_5, $itmOLD_6
Dim $itmOLD_4_1, $itmOLD_4_2

Dim $itemOLD_6_Dnyal1, $itemOLD_6_Dnyal2, $itemOLD_6_Dnyal3
Dim $itemOLD_6_Astir [7]
Dim $itemOLD_6_Maz

Dim $itmNew_1, $itmNew_2, $itmNew_3, $itmNew_4
Dim $itmNew_3_1 ; $itmNew_3_2, $itmNew_3_3, $itmNew_3_4, $itmNew_3_5
Dim $itmOLD_6_1, $itmOLD_6_2
;---------------------------------------------------------------------------------------------------------
Func cmdBibleMap_Click ()

	Local $item

	Const $conLeft = 10, $conTop = 10
	Local $GUIWidth = 400, $GUIHeight = 350

	Local $treeview

	Local $acMapFalther[76]
	Local $cmdOK, $cmdOK_New, $cmdCancel
	Local $acItm_Data [76]

	Local $msg

	Local $itemBIble [74], $acMapFalther [74]
	Local $lngCnt

	$frmBibleMap = GUICreate("خريطة الكتاب المقدس", $GUIWidth, $GUIHeight,-1,-1, _
		formStyle (),  formExStyle (), $frmMainForm) ;0x00800000 , $frmMainForm
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmBibleMap )

	$treeview = GUICtrlCreateTreeView($conLeft, $conTop, $GUIWidth - 2*$conLeft, $GUIHeight - 2 * $conTop - 60, _
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
		$itmOLD_6 = GUICtrlCreateTreeViewItem("أخرى", $itmOLD)
			$itmOLD_6_1 = GUICtrlCreateTreeViewItem("تتممة دانيال", $itmOLD_6)
			$itmOLD_6_2 = GUICtrlCreateTreeViewItem("تتممة أستير", $itmOLD_6)

	$itmNew = GUICtrlCreateTreeViewItem("العهد الجديد", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)

		$itmNew_1 = GUICtrlCreateTreeViewItem("البشائر الاربعة - الانجيل", $itmNew)
		$itmNew_2 = GUICtrlCreateTreeViewItem("القسم التاريخى - الابركسيس", $itmNew)
		$itmNew_3 = GUICtrlCreateTreeViewItem("الرسائل التعليمة - الكاثوليكون", $itmNew)
			$itmNew_3_1 = GUICtrlCreateTreeViewItem("رسائل بولس - البولس", $itmNew_3)

		$itmNew_4 = GUICtrlCreateTreeViewItem("السفر النبوى", $itmNew)

	FillItes ($acMapFalther)
	Local $lngCnt
	For $lngCnt =1 to 73
		; to be changed later
		;$acItm_Data [$lngCnt] = GUICtrlCreateTreeViewItem($acMapFalther[$lngCnt], $acMapFalther[$lngCnt])
		$acItm_Data [$lngCnt] = GUICtrlCreateTreeViewItem($avArray [$lngCnt], $acMapFalther[$lngCnt])
	Next

	$itemOLD_6_Dnyal1 = GUICtrlCreateTreeViewItem("تتممة دانيال " & " ٣ : ٢٤-٩٠", $itmOLD_6_1)
	$itemOLD_6_Dnyal2 = GUICtrlCreateTreeViewItem("تتممة دانيال " & "١٣ : ١-٦٥",  $itmOLD_6_1)
	$itemOLD_6_Dnyal3 = GUICtrlCreateTreeViewItem("تتممة دانيال " & "١٤ : ١-٤٢",  $itmOLD_6_1)

	$itemOLD_6_Astir [0] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "١٠ : ٤-١٣ " , $itmOLD_6_2 )
	$itemOLD_6_Astir [1] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(11) & " : " & Num2India(1) & "-" & Num2India(12) , $itmOLD_6_2 )
	$itemOLD_6_Astir [2] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(12) & " : " & Num2India(1) & "-" & Num2India(6) , $itmOLD_6_2 )
	$itemOLD_6_Astir [3] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(13) & " : " & Num2India(1) & "-" & Num2India(18) , $itmOLD_6_2 )
	$itemOLD_6_Astir [4] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(14) & " : " & Num2India(1) & "-" & Num2India(19) , $itmOLD_6_2 )
	$itemOLD_6_Astir [5] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(15) & " : " & Num2India(1) & "-" & Num2India(19) , $itmOLD_6_2 )
	$itemOLD_6_Astir [6] = GUICtrlCreateTreeViewItem("تتممة أستير  " & "ص" &  Num2India(16) & " : " & Num2India(1) & "-" & Num2India(24) , $itmOLD_6_2 )

	$itemOLD_6_Maz = GUICtrlCreateTreeViewItem("المزمور " & Num2India(151), $itmOLD_6)

; 	$cmdOK = GUICtrlCreateButton("موافق", $GUIWidth/2 - $conLeft  -35, $GUIHeight -$conTop -40, 100, 30, _
;		bitor ($WS_TABSTOP, $BS_NOTIFY, $BS_DEFPUSHBUTTON))

	$cmdOK	   = GUICtrlCreateButton ( "إذهـب الى",   $conLeft + 000, $GUIHeight -$conTop -40, 100, 30, $BS_DEFPUSHBUTTON )
	$cmdOK_New = GUICtrlCreateButton ( "صفحة جديدة", $conLeft + 110, $GUIHeight -$conTop -40, 100, 30)
	$cmdCancel = GUICtrlCreateButton ( "إلغاء الامر", $conLeft + 220, $GUIHeight -$conTop -40, 100, 30)

	GUICtrlSetState($itmOld, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "General"-item and paint in bold
	GUICtrlSetState($itmNew, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "Display"-item and paint in bold

	GUISetState()
	Opt("GUIOnEventMode", 0)

	While 1

		$msg = GUIGetMsg(1)
		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return

			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmBibleMap)
			;Case  ($msg[0] = $GUI_EVENT_CLOSE ) and ($msg[1] = $frmBibleMap)
				frmBibleMap_Close ()
				Return

			;Case $msg[0] = $cmdOK_New

			Case $msg[0] = $cmdOK or  $msg[0] = $cmdOK_New

				if $msg[0] = $cmdOK_New Then
					Local $nTab = TabCreate ()
					SetTabInfoBible ( $nTab )
					TabSetFous ( $nTab ) ; the new one and write bible in IE
				EndIf

				$item = GUICtrlRead ($treeview)
				Switch $item
					Case  $itemOLD_6_Maz
						ReadBible (21,151,1,8)

					Case  $itemOLD_6_Astir[1]
						ReadBible (19,11)
					Case  $itemOLD_6_Astir[2]
						ReadBible (19,12)
					Case  $itemOLD_6_Astir[3]
						ReadBible (19,13)
					Case  $itemOLD_6_Astir[4]
						ReadBible (19,14)
					Case  $itemOLD_6_Astir[5]
						ReadBible (19,15)
					Case  $itemOLD_6_Astir[6]
						ReadBible (19,16)
					Case  $itemOLD_6_Astir[0]
						ReadBible (19,10,4,13); to 19,16,1,24

					Case $itemOLD_6_Dnyal2
						ReadBible (32,13)
					Case $itemOLD_6_Dnyal3
						ReadBible (32,14)
					Case $itemOLD_6_Dnyal1
						;ReadBible (32,10, 1, 21)
						ReadBible (32,3, 24, 90)

					Case Else
						$item = _ArraySearch ($acItm_Data, $item)
						if $item >  0  and $item <= 73 Then
							;Msgbox (0,"", $item)
							ReadBible ($item,1)
						EndIf
				EndSwitch

				frmBibleMap_Close ()
				Return

	EndSelect
	WEnd

EndFunc   ;==>Example
;---------------------------------------------------------------------------------------------------------
Func FillItes (ByRef $acMapFalther)
	; موسى الخمسة
	$acMapFalther [1] = $itmOLD_1
	$acMapFalther [2] = $itmOLD_1
	$acMapFalther [3] = $itmOLD_1
	$acMapFalther [4] = $itmOLD_1
	$acMapFalther [5] = $itmOLD_1

	; التاريخية  12 سفر
	$acMapFalther [6] = $itmOLD_2
	$acMapFalther [7] = $itmOLD_2
	$acMapFalther [8] = $itmOLD_2
	$acMapFalther [9] = $itmOLD_2
	$acMapFalther [10] = $itmOLD_2
	$acMapFalther [11] = $itmOLD_2
	$acMapFalther [12] = $itmOLD_2
	$acMapFalther [13] = $itmOLD_2
	$acMapFalther [14] = $itmOLD_2
	$acMapFalther [15] = $itmOLD_2
	$acMapFalther [16] = $itmOLD_2
	$acMapFalther [19] = $itmOLD_2 ; استير

	; الشعرية 5 اسفار
	$acMapFalther [20] = $itmOLD_3
	$acMapFalther [21] = $itmOLD_3
	$acMapFalther [22] = $itmOLD_3
	$acMapFalther [23] = $itmOLD_3
	$acMapFalther [24] = $itmOLD_3

	;الانبياء الكبار 5 اسفار
	$acMapFalther [27] = $itmOLD_4_1
	$acMapFalther [28] = $itmOLD_4_1
	$acMapFalther [29] = $itmOLD_4_1
	$acMapFalther [31] = $itmOLD_4_1 ; حزقيال
	$acMapFalther [32] = $itmOLD_4_1

	; الانبياء الصغار 12
	$acMapFalther [33] = $itmOLD_4_2
	$acMapFalther [34] = $itmOLD_4_2
	$acMapFalther [35] = $itmOLD_4_2
	$acMapFalther [36] = $itmOLD_4_2
	$acMapFalther [37] = $itmOLD_4_2
	$acMapFalther [38] = $itmOLD_4_2
	$acMapFalther [39] = $itmOLD_4_2
	$acMapFalther [40] = $itmOLD_4_2
	$acMapFalther [41] = $itmOLD_4_2
	$acMapFalther [42] = $itmOLD_4_2
	$acMapFalther [43] = $itmOLD_4_2
	$acMapFalther [44] = $itmOLD_4_2
	;----------------------
	$acMapFalther [17] = $itmOLD_5
	$acMapFalther [18] = $itmOLD_5
		;$acMapFalther [74] = $itmOLD_5 ;19
	$acMapFalther [25] = $itmOLD_5
	$acMapFalther [26] = $itmOLD_5
	$acMapFalther [30] = $itmOLD_5
		;$acMapFalther [75] = $itmOLD_5;32
	$acMapFalther [45] = $itmOLD_5
	$acMapFalther [46] = $itmOLD_5

	$acMapFalther [47] = $itmNew_1
	$acMapFalther [48] = $itmNew_1
	$acMapFalther [49] = $itmNew_1
	$acMapFalther [50] = $itmNew_1

	$acMapFalther [51] = $itmNew_2

	$acMapFalther [52] = $itmNew_3_1
	$acMapFalther [53] = $itmNew_3_1
	$acMapFalther [54] = $itmNew_3_1
	$acMapFalther [55] = $itmNew_3_1
	$acMapFalther [56] = $itmNew_3_1
	$acMapFalther [57] = $itmNew_3_1
	$acMapFalther [58] = $itmNew_3_1
	$acMapFalther [59] = $itmNew_3_1
	$acMapFalther [60] = $itmNew_3_1
	$acMapFalther [61] = $itmNew_3_1
	$acMapFalther [62] = $itmNew_3_1
	$acMapFalther [63] = $itmNew_3_1
	$acMapFalther [64] = $itmNew_3_1
	$acMapFalther [65] = $itmNew_3_1

	$acMapFalther [66] = $itmNew_3
	$acMapFalther [67] = $itmNew_3
	$acMapFalther [68] = $itmNew_3
	$acMapFalther [69] = $itmNew_3
	$acMapFalther [70] = $itmNew_3
	$acMapFalther [71] = $itmNew_3
	$acMapFalther [72] = $itmNew_3

	$acMapFalther [73] = $itmNew_4
EndFunc
;---------------------------------------------------------------------------------------------------------
Func frmBibleMap_Close ()
	IF IsPtr ( $frmBibleMap ) Then
		GUIDelete($frmBibleMap)
		$frmBibleMap = 0
	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------