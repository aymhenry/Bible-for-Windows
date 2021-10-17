;---------------------------------------------------------------------------------------------------------------------------
Const $conGetBibleTit = "الانجيل"
Local $updChptr, $updAyaFrom, $updAyaTo
Local $txtAyaFrom, $txtAyaTo
Local $lngMaxAyaLocal,  $lngMaxChpLocal
;---

Dim $plngBible, $plngChaptr, $isOneAya
Dim $lngOldBible, $lngOldChpt

Dim $GUIWidthBible = 480 ,$GUIHeightBible = 440;310
Dim $lngSelectMethod, $TxtShortCut, $radBibleAll
Dim $lngFlagBlockOK = 0 ; 1 i.e blocked

;---------------------------------------------------------------------------------------------------------------------------
#Region Bible Windows
Func cmdGetBible_Click ()

	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf
	$lngExtraFormOpen  = 1
	;------------------
	Local $cmdOK, $cmdCancel, $msg;, $cmdOK_New
	Local $radThisPage, $radNewPage
;Local $radBibleOld, $radBibleNew, $radBibleDel
	Local $lstFilter
	Local $lngAyaFrom, $lngAyaTO

	Const $conLeftSide2 =20, $conTopSide2 =10
	$lngSelectMethod = 0

	$frmGetBible = GUICreate($conGetBibleTit, $GUIWidthBible, $GUIHeightBible ,-1,-1, _
								formStyle (), formExStyle (), $frmMainForm )
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmGetBible )
;------
	;GuiCtrlCreateGroup("الكتاب المقدس", $conLeftSide2, $conTopSide2, $GUIWidthBible - 2*$conLeftSide2, 90+96 ) ;$GUIWidthBible - 2*$conLeftSide2
	GuiCtrlCreateGroup("الكتاب المقدس", $conLeftSide2, $conTopSide2, 180, 190 + 35)

	CreateBibleCmb ($cmbBible,  $conLeftSide2 + 4, $conTopSide2 +22, 160, 175+30)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "حدد الانجيل المطلوب عرضه","الانجيل",1, 2)

;---================================================================================
	GuiCtrlCreateGroup("تصنيف الأسفار", $conLeftSide2+190, $conTopSide2, 250, 190 +35 )
		$lstFilter = GUICtrlCreateList("كل الكتاب", $conLeftSide2+190+10, $conTopSide2 + 22, 180+50, 175+30, BitOR ( $WS_BORDER, $WS_VSCROLL, $WS_TABSTOP, $LBS_NOTIFY))

		GUICtrlSetData ($lstFilter, "العهد القديم بالاسفار القانونية" & "|")  ;1
		GUICtrlSetData ($lstFilter, "العهد الجديد" & "|");2

		GUICtrlSetData ( $lstFilter,"التوراة - أسفار موسى" & "|") ;3
		GUICtrlSetData ( $lstFilter,"الكتب التاريخية" & "|");4
		GUICtrlSetData ( $lstFilter,"الاسفار الشعرية" & "|" );5
		GUICtrlSetData ( $lstFilter,"أسفار الانبياء" & "|" );6
		;GUICtrlSetData ( $lstFilter,"الانبياء الكبار" & "|" );6
		;GUICtrlSetData ( $lstFilter,"الانبياء الصغار" & "|" );7
		GUICtrlSetData ( $lstFilter,"الاسفار القانونية الثانية" & "|" );7

		GUICtrlSetData ( $lstFilter,"البشائر الاربعة - الانجيل" & "|" );8
		GUICtrlSetData ( $lstFilter,"القسم التاريخى - الابركسيس" & "|" );9
		GUICtrlSetData ( $lstFilter,"الرسائل التعليمة - الكاثوليكون" & "|" );10
		;GUICtrlSetData ( $lstFilter,"رسائل بولس - البولس" & "|");12
		GUICtrlSetData ( $lstFilter,"السفر النبوى" & "|" );11
;------
	GuiCtrlCreateGroup("مختصر العنوان", $conLeftSide2+290, $conTopSide2 + 230 , 120+30, 96 ) ;$GUIWidthBible - 2*$conLeftSide2

	$TxtShortCut = GUICtrlCreateInput(" ", $conLeftSide2 + 295 ,$conTopSide2 + 230+30, 110+30, 25 +00 )
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, " اكتب مختصر عنوان الاية مثل مت ٩ : ١-٨"  & @CR & "ثم اضغط إدخال","مختصر العنوان",1, 1)
		; مت ٩ : ١-٨
;------
	GuiCtrlCreateGroup("تحديد الأيات", $conLeftSide2, $conTopSide2 + 187+40 , 270, 100 );$GUIWidthBible - 2*$conLeftSide2

	$txtChptr = GUICtrlCreateInput(1, $conLeftSide2 + 70, $conTopSide2 + 210+40, 60, 25, $ES_RIGHT); $a_Settings [4]
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "حدد الاصحاح المطلوب عرضه","الاصحاح",1, 1)

 		GUICtrlCreateLabel ("إصـحاح", $conLeftSide2+5, $conTopSide2 + 210+40, 60, 20 ,BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$updChptr = GUICtrlCreateUpdown($txtChptr, $UDS_ALIGNLEFT)
		GUICtrlSetData ( $txtChptr, 1)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
;-----
	$txtAyaFrom = GUICtrlCreateInput(1, $conLeftSide2 + 70, $conTopSide2 + 230+60, 60, 25, $ES_RIGHT)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "من الايه","الايه",1, 1)

 		GUICtrlCreateLabel ("من الايه", $conLeftSide2+5, $conTopSide2 + 230+60, 60, 20 ,BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$updAyaFrom = GUICtrlCreateUpdown($txtAyaFrom, $UDS_ALIGNLEFT)
		GUICtrlSetData ( $txtChptr, 1)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
;-----
	$txtAyaTo = GUICtrlCreateInput(1, $conLeftSide2 + 70 + 130, $conTopSide2 + 230+60, 60, 25, $ES_RIGHT)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "الى الايه","الايه",1, 1)

 		GUICtrlCreateLabel ("الى الايه", $conLeftSide2 + 135, $conTopSide2 + 230+60, 60, 20 ,BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$updAyaTo = GUICtrlCreateUpdown($txtAyaTo, $UDS_ALIGNLEFT)
		GUICtrlSetData ( $txtChptr, 1)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
;---
	; GROUP WITH RADIO BUTTONS
	GuiCtrlCreateGroup("خيارات العرض", $conLeftSide2, $conTopSide2 +290 +40, 270, 80 ) ;$GUIWidthBible - 2*$conLeftSide2
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radThisPage = GUICtrlCreateRadio ("عرض الانجيل فى هذة الصفحة",  $conLeftSide2 +10 +0 , $conTopSide2 +310+40  , 250, 25)
		;GuiCtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radNewPage = GUICtrlCreateRadio ("عرض الانجيل فى صفحة جديدة",  $conLeftSide2 + 10 +0 , $conTopSide2 + 340+40, 250, 25)
		GuiCtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

		if $pconMaxTabs = $plng_CreatedTabs Then
			GUICtrlSetState ($radNewPage, $GUI_DISABLE)
		EndIf
;----
 	$cmdOK = GUICtrlCreateButton("موافق",  $conLeftSide2 + 320 , $conTopSide2 +340, 100, 30, _
		BitOr($GUI_SS_DEFAULT_LABEL, $BS_DEFPUSHBUTTON))

 	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $conLeftSide2 + 320 , $conTopSide2 +340 + 35, 100, 30 )

	GUISetState ()
	_GUICtrlListBox_SetCurSel($cmbBible, 48)
	GUICtrlSetState ($TxtShortCut, $GUI_FOCUS)

	$isOneAya = CurAyaChk ()
	If $isOneAya <> 0 Then ; i.e no tafser
		GUICtrlSetState ( $txtAyaTo, $GUI_DISABLE)
		GUICtrlSetState ( $updAyaTo, $GUI_DISABLE)
	EndIf

	$plngBible = CurBible()
	$plngChaptr = CurChptr()
	$lngAyaFrom = CurAyaFrom ()
	$lngAyaTO = CurAyaTo ()
	$lngMaxChpLocal = $lngMaxValue
	$lngMaxAyaLocal = $lngMaxAya

	GUICtrlSetLimit ( $updChptr, $lngMaxValue , 1)
	GUICtrlSetLimit ( $updAyaFrom, $lngMaxAya , 1)
	GUICtrlSetLimit ( $updAyaTo, $lngMaxAya , 1)

	GUICtrlSetData ($cmbBible, $avArray[ $plngBible ] ); $a_Settings[4]
	GUICtrlSetData ($txtChptr, $plngChaptr ); $a_Settings[4]
	GUICtrlSetData ($txtAyaFrom, $lngAyaFrom )
	GUICtrlSetData ($txtAyaTo, $lngAyaTO )

	AdjustLowerAya () ; just to write shortcut !!!!

	;ConsoleWrite ( $lngMaxValue & " "  & $lngMaxAya & " " & $plngChaptr)

	Opt("GUIOnEventMode", 0)
	While 1

		$msg = GUIGetMsg(1)

		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return

			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmGetBible)
				frmGetBible_Close ()
				Return

			Case $msg[0] = $lstFilter
				;$lngSelectMethod = GUICtrlRead ($lstFilter, 1)
				$lngSelectMethod = _GUICtrlListBox_GetCurSel($lstFilter)

				ReCreateList ( $lngSelectMethod)

			;Case $msg[0] = $radBibleAll
			;	$lngSelectMethod = 1
			;	ReCreateList ( $lngSelectMethod)
			;Case $msg[0] = $radBibleOld
			;	$lngSelectMethod = 2
			;	ReCreateList ( $lngSelectMethod)
			;Case $msg[0] = $radBibleNew
			;	$lngSelectMethod = 3
			;	ReCreateList ( $lngSelectMethod)
			;Case $msg[0] = $radBibledel
			;	$lngSelectMethod = 4
			;	ReCreateList ( $lngSelectMethod)

			Case $msg[0] = $cmbBible
				cmbBible_Change ()

			Case $msg[0] = $txtChptr
				txtChpt_Change ()

			Case $msg[0] = $txtAyaTo
				AdjustLowerAya ()

			Case $msg[0] = $txtAyaFrom
				AdjustUpperAya ()

			Case $msg[0] = $TxtShortCut
				;ConsoleWrite ("Text modification" & @CR)
				;Case $msg[0] = $cmdGo
				$lngFlagBlockOK = GoShortCut()
				if 0 = $lngFlagBlockOK Then

					ApplyChange ()
					if BitAND (GUICtrlRead ( $radNewPage ), $GUI_CHECKED) = 1  Then
						Local $nTab = TabCreate ()
						SetTabInfoBible ( $nTab )
						TabSetFous ( $nTab ) ; the new one and write bible in IE
					Else 
						UpdateTxt()
					EndIf

					frmGetBible_Close ()
						;TabSetFous ( $plng_BibleDef )
					Return

				EndIf

			Case $msg[0] = $cmdOK
				If $lngFlagBlockOK = 1 then
					$lngFlagBlockOK = 0
					ContinueLoop
				EndIf

				ApplyChange ()  

				if BitAND (GUICtrlRead ( $radNewPage ), $GUI_CHECKED) = 1  Then
					Local $nTab = TabCreate ()
					SetTabInfoBible ( $nTab )
               
					TabSetFous ( $nTab ) ; the new one and write bible in IE
 
				Else

					UpdateTxt()
				EndIf

				frmGetBible_Close ()
					;TabSetFous ( $plng_BibleDef )
				Return

		EndSelect
	WEnd

EndFunc
#EndRegion Bible Windows
;---------------------------------------------------------------------------------------------------------------------------
Func txtChpt_Change ()

		if BitAND (1, $lngExtraFormOpen) = 0 then Return
		;$plngChaptr = 0 + GUICtrlRead ($txtChptr)
		$plngChaptr = Number(GUICtrlRead ($txtChptr))

		if $plngChaptr > $lngMaxChpLocal Then
			GUICtrlSetData ($txtChptr, $lngMaxChpLocal)
			$plngChaptr = $lngMaxChpLocal
		EndIf

		if $plngChaptr <= 0  Then
			GUICtrlSetData ($txtChptr, 1)
			$plngChaptr = 1
		EndIf

		$lngMaxAyaLocal = CalcMaxAya2Chpt ($plngBible, $plngChaptr) ; data not applied yet to aSetting

		if 0= GUICtrlSetLimit ( $updAyaFrom, $lngMaxAyaLocal , 1) then
				MsgBox ($conMirrorR2L + 16, $gconProgName,"GetBible: Error 01-Internal Error Max Aya",0, $frmGetBible)
		endif

		if 0= GUICtrlSetLimit ( $updAyaTo, $lngMaxAyaLocal , 1) then
				MsgBox ($conMirrorR2L + 16, $gconProgName,"GetBible: Error 02-Internal Error Max Aya", 0, $frmGetBible)
		endif

		GUICtrlSetData ($txtAyaFrom, 1);$a_Settings[7]
		GUICtrlSetData ($txtAyaTo,$lngMaxAyaLocal);$a_Settings[7]
		Send ("{TAB}")
		Send ("+{TAB}")
;----
		Local $strNewShort
		$strNewShort = $acShort [$plngBible] & " " & $plngChaptr & " : 1 - " & $lngMaxAyaLocal
		GUICtrlSetData ($TxtShortCut, $strNewShort)
		$lngFlagBlockOK = 0
		GUICtrlSetColor ($TxtShortCut, 0)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------

Func cmbBible_Change ()
		Local $strItem

		$strItem = GUICtrlRead ( $cmbBible)

		$plngBible = _ArraySearch($avArray, $strItem, 0, 0, 0, 1)

		If @error  or $plngBible > $conItem or $plngBible <= 0 Then
			MsgBox ($conMirrorR2L + 16, $gconProgName,"GetBible: Error 03-Internal Error Bible not found",0, $frmGetBible)
			$plngBible = 1
		endif
		$lngMaxChpLocal = GetBibleChpts ($plngBible )

		if 0= GUICtrlSetLimit ( $updChptr, $lngMaxChpLocal , 1) then ; error
				MsgBox ($conMirrorR2L + 16, $gconProgName,"GetBible: Error 04-Internal Internal Max Chptr", 0, $frmGetBible)
		endif

		GUICtrlSetData ($txtChptr, 1)
		;Send ("+{End}")
		;Send ("+{TAB}")

		txtChpt_Change ()
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func ApplyChange ()
               
		CurBible ($plngBible)
		CurChptr ($plngChaptr)
        ;MsgBox (0, "ApplyChange", "$plngBible = " & $plngBible & " $plngChaptr =" & $plngChaptr)
        ;MsgBox (0, "$a_Settings[4]", "Bible = " & $a_Settings[3] & " Chaptr =" & $a_Settings[4])
   

		CurAyaFrom ( GUICtrlRead ($txtAyaFrom) + 0 )
		CurAyaTo   ( GUICtrlRead ($txtAyaTo)   + 0 )

		if CurAyaChk () <> 0 Then
			CurAyaChk ( CurAyaFrom() )
		EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------

Func ReCreateList ( $lngSele)
	Local $lngCnt, $strSelectBible, $lng
	Local $strItem

	Switch $lngSele
		Case 0
			_GUICtrlListBox_SetCurSel($cmbBible, 48)
			cmbBible_Change ()
			Return
		Case 1
			$strSelectBible = "01 02 03 04 05 06 07 08 09 10 " & _
							  "11 12 13 14 15 16 17 18 19 20 " & _
							  "21 22 23 24 25 26 27 28 29 30 " & _
							  "31 32 33 34 35 36 37 38 39 40 " & _
							  "41 42 43 44 45 46 "
		Case 2
			$strSelectBible = 					"47 48 49 50 " & _
							  "51 52 53 54 55 56 57 58 59 60 " & _
							  "61 62 63 64 65 66 67 68 69 70 " & _
							  "71 72 73 "

		Case 3
			$strSelectBible = "01 02 03 04 05 "


		Case 4
			$strSelectBible = 				 "06 07 08 09 10 " & _
							  "11 12 13 14 15 16 19 "

		Case 5
			$strSelectBible = "20 21 22 23 24 "
		Case 6
			$strSelectBible = 					"27 28 29 " & _
						      "31 32 33 34 35 36 37 38 39 40 " & _
							  "41 42 43 44 "
		Case 7
			$strSelectBible = "17 18 25 26 30 45 46 "
		Case 8
			$strSelectBible = "47 48 49 50 "
		Case 9
			$strSelectBible = "51 "
		Case 10
			$strSelectBible =    "52 53 54 55 56 57 58 59 60 " & _
							  "61 62 63 64 65 66 67 68 69 70 71 72 "
		Case 11
			$strSelectBible = "73 "
	EndSwitch

	$strItem = ""

 	For $lngCnt = 1 to  Stringlen($strSelectBible) step 3
		$lng = StringMid ($strSelectBible, $lngCnt, 3) + 0
		$strItem = $strItem  & "|" & $avArray[$lng]
	Next

    GUICtrlSetData ($cmbBible, "" )
    GUICtrlSetData ($cmbBible, StringTrimLeft ($strItem, 1), $avArray[0] )

	_GUICtrlListBox_SetCurSel($cmbBible, 0)

	;_GUICtrlComboBox_SetCurSel($cmbBible, $lngFrom -1)

	cmbBible_Change ()

EndFunc
;---------------------------------------------------------------------------------------------------------------------------

Func CreateBibleCmb (byref $cmbBible, $lngX, $lngY, $lngWdth, $lngHig)
	Local $lngCnt
	;Local $strItem

	;$cmbBible = GUICtrlCreateCombo($avArray[0], $lngX, $lngY, $lngWdth, $lngHig, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST) ) ; create first item
	$cmbBible = GUICtrlCreateList($avArray[0], $lngX, $lngY, $lngWdth, $lngHig, BitOR ( $WS_BORDER, $WS_VSCROLL, $WS_TABSTOP, $LBS_NOTIFY))
	;_GUICtrlComboBox_SetMinVisible(-1, 10)

	;$strItem =""

 	For $lngCnt = 1 to $conITem
		;$strItem = $strItem  & "|" & $avArray[$lngCnt]
		GUICtrlSetData ($cmbBible, $avArray[$lngCnt] & "|") ;  $a_Settings[3] add other item snd set a new default
	Next
	CurBible ()
	;, $avArray[CurBible()]  & "|"

	;GUICtrlSetData ($cmbBible, $strItem, $avArray[CurBible()] ) ;  $a_Settings[3] add other item snd set a new default
	;Return

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func frmGetBible_Close ()
;	$lngExtraFormOpen = BitAND (255-$lngFrmGetBibleID, $lngExtraFormOpen); ; make the first bit 0
	$lngExtraFormOpen  = 0
	IF IsPtr ( $frmGetBible ) Then
		GUIDelete($frmGetBible)
		$frmGetBible = 0

	EndIf

;	if $lngExtraFormOpen =0 then Opt("GUIOnEventMode", 1)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func AdjustUpperAya ()
	Local $lngAyaFrom = GUICtrlRead ($txtAyaFrom) + 0
	Local $lngAyaTo = GUICtrlRead ($txtAyaTo) + 0

	if $lngAyaFrom > $lngAyaTo Then
		GUICtrlSetData ($txtAyaTo, $lngAyaFrom + 0)
	endif

;========
		Local $strNewShort
		$strNewShort = $acShort [$plngBible] & " " & $plngChaptr & " : " & _
						GUICtrlRead ($txtAyaFrom) & " - " & GUICtrlRead ($txtAyaTo)

		GUICtrlSetData ($TxtShortCut, $strNewShort)
		$lngFlagBlockOK = 0
		GUICtrlSetColor ($TxtShortCut, 0)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func AdjustLowerAya ()
	Local $lngAyaFrom = GUICtrlRead ($txtAyaFrom) + 0
	Local $lngAyaTo = GUICtrlRead ($txtAyaTo) + 0

	if $lngAyaFrom > $lngAyaTo  or $isOneAya <> 0  Then
		GUICtrlSetData ($txtAyaFrom, $lngAyaTo + 0)
	endif
;========
		Local $strNewShort
		$strNewShort = $acShort [$plngBible] & " " & $plngChaptr & " : " & _
						GUICtrlRead ($txtAyaFrom) & " - " & GUICtrlRead ($txtAyaTo)

		GUICtrlSetData ($TxtShortCut, $strNewShort)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func FindBibNo ( $strShor)
	Local $lngBible, $acShort2
	Local $lngCnt
;MsgBox (0,0, $strShor)

	$acShort2 = $acShort
	for $lngCnt = 1 to $conItem -1
			$acShort2[$lngCnt] = RemCach ($acShort2[$lngCnt])
	Next

	$acShort2[$conItem] = $acShort2[$conItem] ; رؤ

	$strShor = RemCach ($strShor)

	$lngBible = _ArraySearch($acShort2, $strShor);, 0, 0, 0, 1)

	Return $lngBible
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func GoShortCut()
	Local $strShortCut = GUICtrlRead ($TxtShortCut)
	Local $strBibleName, $strChap, $strAyaFrom, $strAyaTo, $lngTemp
	Local $strNewShort
	ToolTip ("")
	GUICtrlSetColor ($TxtShortCut, 0); black

	$strShortCut = StringStripWS ($strShortCut, 7); all left, right double spc.
	if $strShortCut ="" then Return 1

	; مت ٩ : ١-٨
	$strBibleName = StringStripWS (StringLeft ($strShortCut, 3), 7)

	if StringMid ($strBibleName,3) + 0 > 0 then $strBibleName = StringLeft ($strBibleName, 2)

	if $strBibleName = "1تي" then $strBibleName ="1تيمو"
	if $strBibleName = "2تي" then $strBibleName ="2تيمو"

	$strChap = StringMid ( $strShortCut, StringLen($strBibleName)+1, 4)
	$lngTemp = StringInStr ($strShortCut, ":", 0)

	If $lngTemp > 1 Then
		$strChap = StringLeft ($strChap, $lngTemp-1) + 0
		$strShortCut = StringMid ( $strShortCut, $lngTemp +1, 1000)
	Else
		$strChap = $strChap + 0
		$strShortCut = ""
	EndIf

	$lngTemp = StringInStr ($strShortCut, "-", 0)

	If $lngTemp > 1 Then
		$strAyaFrom = StringLeft ($strShortCut, $lngTemp-1) + 0
		$strAyaTo = StringMid ($strShortCut, $lngTemp+1, 1000) + 0
	Else
		$strAyaFrom = 0
		$strAyaTo = 0
	EndIf

	$strBibleName = FindBibNo ($strBibleName) + 0

	if ($strChap <= 0) or ($strBibleName <= 0) or ($strBibleName > $conITem)  then
		;ConsoleWrite ("Bible =" & $strBibleName & @CRLF)
		;ConsoleWrite ("Chap=" & $strChap & @CRLF)
		GUICtrlSetColor ($TxtShortCut, Dec('FF0000')) ;

		ToolTip ( "خطأ فى تحرير الاختصار");, -1,-1,$gconProgName, 3)
		Return 1
	EndIf

	$strNewShort = $acShort [$strBibleName] & " " & $strChap

	if $strAyaFrom > 0 Then
		$strNewShort = $strNewShort & " : " & $strAyaFrom
	EndIf

	if $strAyaTo > 0 and $strAyaTo > $strAyaFrom Then
		$strNewShort = $strNewShort & " - " & $strAyaTo
	EndIf
	;MsgBox (0,"Result", "Bible=" & $strBibleName & "   Chap=" & $strChap & "  from=" & $strAyaFrom & "  to=" & $strAyaTo)
	GUICtrlSetData ($TxtShortCut, $strNewShort)
;============================
	GUICtrlSetState  ( $radBibleAll, $GUI_CHECKED)

	$lngSelectMethod = 1
	ReCreateList ( $lngSelectMethod )
	_GUICtrlComboBox_SetCurSel($cmbBible, $strBibleName -1)
	cmbBible_Change ()

	if $lngMaxChpLocal < $strChap Then
		;Msgbox($conMirrorR2L + 16,$gconProgName, "خطأ فى رقم الاصحاح لهذ الانجيل")
		GUICtrlSetColor ($TxtShortCut, Dec('FF0000')) ; red
		;TrayTip ( $gconProgName,"خطأ فى رقم الاصحاح لهذ الانجيل", 30 , 1 )
		ToolTip ("خطأ فى رقم الاصحاح لهذ الانجيل")

		Return 1
	EndIf

	GUICtrlSetData ($txtChptr, $strChap)

	txtChpt_Change ()

	if $lngMaxAyaLocal < $strAyaTo or  $lngMaxAyaLocal < $strAyaFrom Then

		GUICtrlSetColor ($TxtShortCut, Dec('FF0000')) ;

		ToolTip ( "خطأ فى رقم الاية لهذا الاصحاح")
		Return 1
	EndIf

	if $strAyaFrom > 0 then
		GUICtrlSetData ($txtAyaFrom, $strAyaFrom)
	EndIf


	if $strAyaTo >= $strAyaFrom And $strAyaFrom > 0 then
		GUICtrlSetData ($txtAyaTo, $strAyato)
	Else
		GUICtrlSetData ($txtAyaTo, $lngMaxAyaLocal)
	EndIf

	Return 0
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
