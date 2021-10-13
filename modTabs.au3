



;Global $conTab_TypeBlank = "N"

;Const $conTab_NO = 0
;Const $conTab_Info = 0
;Const $conTab_ItemID = 1


;---------------------------------------------------------------------------------------------------------
Func TabList ()
 	Local $lngCnt, $strList = "", $strBibleName
	For  $lngCnt = 0 to $plng_CreatedTabs
		;If $lngCnt <> $plng_BibleDef And $lngCnt <> $plng_SearchDef Then
		If $lngCnt <> $plng_SearchDef Then
			$strBibleName =  Dec (StringLeft ( GetTabInfo ($lngCnt), 2) )
			If $strBibleName > 0 and $strBibleName <= $conItem Then
				$strBibleName = $avArray [ $strBibleName + 0 ]
				If StringInStr ( $strList, 	$strBibleName )  = 0 Then
					$strList =  $strList & $strBibleName & "|"
				EndIf
			EndIf
		EndIf
	Next
	Return StringTrimRight ($strList, 1)
EndFunc
;---------------------------------------------------------------------------------------------------------
Func TabClose ()
	Local $lngTab = _GUICtrlTab_GetCurSel ( $hTab )
	ToolTip ("")
	CloseTab_Step2 ( $lngTab )

EndFunc
;---------------------------------------------------------------------------------------------------------
Func TabCloseHover (); handler no paramert
	If $nHoverTab > $plng_CreatedTabs or $nHoverTab < 0 Then Return
	CloseTab_Step2 ( $nHoverTab )
EndFunc

;---------------------------------------------------------------------------------------------------------
Func CloseTab_Step2 ( $lngTab)
;	Local $iCount

	if $lngTab = $plng_BibleDef or  $lngTab = $plng_SearchDef Then ; for saftey only no acccess for this
		;TrayTip ( $gconProgName, "غير مسموح بحذف شريط الانجيل  الاساسى - او حذف شريط البحث", 30 , 1 )
		; _GUICtrlStatusBar_SetBkColor($hStatus, 0x00FF00 ) ; color is BRG
		 _GUICtrlStatusBar_SetText ($hStatus, "غير مسموح بحذف شريط الانجيل  الاساسى - او حذف شريط البحث", 1)
		Return
	EndIf

	If $lngTab = $plng_CurrTabNo then ; it has to be the same just in case if
		$plng_CurrTabNo = $plng_CurrTabNo -1
		if  $plng_CurrTabNo = $plng_SearchDef  or $plng_CurrTabNo < 0 Then
			$plng_CurrTabNo = $plng_BibleDef
		EndIf
		TabSetFous ( $plng_CurrTabNo )
	EndIf

	$plng_CreatedTabs = $plng_CreatedTabs - 1

	_ArrayDelete ( $a_hTabObject, $lngTab)
	_ArrayAdd ( $a_hTabObject, "" )
	_GUICtrlTab_DeleteItem ($hTab, $lngTab)

	DelMenuItem ($lngTab)
EndFunc
;---------------------------------------------------------------------------------------------------------
Func TabSetFous ( $lngTab)
	If $lngTab > $plng_CreatedTabs or $lngTab < 0 Then Return
	$plng_CurrTabNo = $lngTab
	_GUICtrlTab_SetCurFocus($hTab, $lngTab)
	 hTab_Change ()
EndFunc
;---------------------------------------------------------------------------------------------------------
Func Swtch2Tab ($lngTab)
	If $lngTab >= UBound ($a_hTabObject) Or $lngTab < 0 Then ; for safetry
		$lngTab = UBound ($a_hTabObject)-1
	EndIf

	if StringLeft ($a_hTabObject [ $lngTab], 1) <> $conTab_TypeBible Then
		MsgBox ($conMirrorR2L + 16, $gconProgName,"modTabs: Error 01-Internal Tab ID", 0, $frmMainForm)
		Return
	EndIf
	;----
	Local $strPara = GetTabInfo ($lngTab)

	$plng_CurrTabNo = $lngTab
	;ConsoleWrite ("Tab=" & $lngTab & " Id="	& $strPara & @CR)
	ShowBible ( $strPara)
EndFunc
;--------------------------------------------------------------------------------------------------------
Func SrchOpenTabs ( $strObj)
	Local $feedback = _ArraySearch ($a_hTabObject, $strObj)
	Return $feedback; not found i.e -1
EndFunc
;--------------------------------------------------------------------------------------------------------

Func SetTabInfoBible ($lngTab)
	If $lngTab > $plng_CreatedTabs or $lngTab < 0 Then Return
	if $lngTab = $plng_SearchDef Then
		;MsgBox ($conMirrorR2L + 16, $gconProgName,"modTabs Internal Error 002")
		Return
	EndIf
	Local $strPara = BAdrs2Hex ( CurBible(), CurChptr (), CurAyaChk (), CurAyaFrom (), CurAyaTo(), _
							      CurCont () + 2* CurNum () + 4* CurTach () + 8*CurAdd() )

	$a_hTabObject [ $lngTab] = $conTab_TypeBible & $strPara

EndFunc
;---------------------------------------------------------------------------------------------------------
Func GetTabInfo ($lngTab)
	If $lngTab > $plng_CreatedTabs or $lngTab < 0 Then Return
	Return StringTrimLeft ($a_hTabObject [ $lngTab], 1)
EndFunc
;---------------------------------------------------------------------------------------------------------
Func hTab_Change () ; enent handller only
	Local $lngTab = _GUICtrlTab_GetCurSel ($hTab)

	If $lngTab = $plng_BibleDef or  $lngTab = $plng_SearchDef Then
		_GUICtrlMenu_SetItemDisabled ($hFile, $idFileClose, True, False)
		TrayItemSetState ($tryFileClose, $GUI_DISABLE )
	Else
		_GUICtrlMenu_SetItemDisabled ($hFile, $idFileClose, False, False)
		TrayItemSetState ($tryFileClose, $GUI_ENABLE )
	EndIf

	If  $lngTab = $plng_SearchDef Then
		GUICtrlSetState ($a_hTabIDs [$plng_BibleDef], $GUI_Hide); $GUI_ONTOP
		WrtStatus ("البحث عن اية")
		$lngUpdateFlag = 1
	Else
		GUICtrlSetState ($a_hTabIDs [$plng_BibleDef], $GUI_Show); $GUI_ONTOP
		$lngUpdateFlag = 0
	EndIf

	$plng_CurrTabNo = $lngTab

	if 	$lngTab = $plng_SearchDef and $lngExtraFormOpen <> 1 and _IEBodyReadHTML($oIESearch) ="" Then
		cmdSearch_Start ()
		;GUICtrlSetTip ($hTab, "البحث فى الكتاب المقدس")
	ElseIf $lngTab <> $plng_SearchDef Then
		Swtch2Tab ($lngTab)
		;GUICtrlSetTip ($hTab, GetBibibleAdd ())
	EndIf
EndFunc

;---------------------------------------------------------------------------------------------------------
Func WrtBibleAdd ($lngTab =$plng_BibleDef ) ; wrt bible add form a_seting array data
	Local $str = GetBibibleAdd($lngTab)
	 _GUICtrlTab_SetItemText($hTab, $lngTab, $str  )

	 WrtStatus ($str & " (" & Num2India($lngMaxAya) & " آية)" &  " (" & Num2India($lngMaxValue) & " إصحاح)")
EndFunc
;---------------------------------------------------------------------------------------------------------
Func GetBibibleADD ( $lngTab = Default)
	Local $strAdd, $lngMyTab
	Local $N3, $N4, $N5, $N6, $N7

	if $lngTab = Default Then
		$lngMyTab = _GUICtrlTab_GetCurFocus ($hTab) ;= $plng_SearchDef
	Else
		$lngMyTab = $lngTab
	EndIf

	If $lngMyTab > $pconMaxTabs Then Return ""
	If $lngMyTab = $plng_SearchDef Then Return "نتيجة البحث"

	If $lngTab =Default Then
		$N3 = CurBible ()
		$N4 = CurChptr ()
		$N5 = CurAyaChk ()
		$N6 = CurAyaFrom ()
		$N7 = CurAyaTo ()

	Else
		$strAdd = GetTabInfo ($lngTab)

		$N3 = BHex2Adrs ($strAdd, 1)
		$N4 = BHex2Adrs ($strAdd, 2)
		$N5 = BHex2Adrs ($strAdd, 3)
		$N6 = BHex2Adrs ($strAdd, 4)
		$N7 = BHex2Adrs ($strAdd, 5)

	EndIf

	;if $N5 <1 then
	;	$strAdd = $avArray[$N3] & " " & Num2India( $N4 ) & " : " & Num2India( $N6 ) & "-" & Num2India( $N7 )
	;Else
	;	$strAdd = $avArray[$N3] & " " & Num2India( $N4 ) & " : " & Num2India( $N5 )
	;EndIf
	$strAdd = CreateAdd ($N3, $N4, $N6, $N7, $N5)

	Return $strAdd
EndFunc
;---------------------------------------------------------------------------------------------------------
Func CreateAdd ($lngBible, $lngChptr, $lngAyaF, $lngAyaT, $OneManyAya = 0)
	Local $strAdd
	if $OneManyAya <1 then
		$strAdd = $avArray[$lngBible] & " " & Num2India( $lngChptr ) & " : " & Num2India( $lngAyaF ) & "-" & Num2India( $lngAyaT )
	Else
		$strAdd = $avArray[$lngBible] & " " & Num2India($lngChptr ) & " : " & Num2India( $OneManyAya )
	EndIf
	Return $strAdd
EndFunc
;---------------------------------------------------------------------------------------------------------
Func TabCreate ( $strInfo = $conTab_TypeBible, $bModifyArray = 1)
	Local $hImage

	if ( $plng_CreatedTabs =  $pconMaxTabs)  then Return 0 ; error seterror (0)

	Local $strType = StringLeft ($strInfo, 1)
	Local $lngTab = $plng_CreatedTabs + 1

	;if ($lngTab + 1 >  $pconMaxTabs) or ($lngTab < 0 ) then Return 0 ; error seterror (0)

	if $lngTab = $plng_SearchDef Then
		GUICtrlCreateTabItem(   "البحث"  )
	ElseIf $lngTab = $plng_BibleDef Then
		GUICtrlCreateTabItem( $lngTab & "-الانجيل"   )
	Else
		 _GUICtrlTab_InsertItem ($hTab, $lngTab, $lngTab & "-الانجيل", 2)
	EndIf

	if $bModifyArray = 1 Then
		$a_hTabObject [ $lngTab] = $strInfo
	EndIf

	$plng_CreatedTabs = $lngTab

	AddMenuItem ($lngTab)
	Return $lngTab
EndFunc

;-Function-------------------------------------------------------------------------------------------
;Func TabEditInfo ( $lngTab, $strInfo )
;	if $lngTab  >  $pconMaxTabs or $lngTab < 0 then Return 0 ; error seterror (0)
;
;	$a_hTabObject [$lngTab]  = $strInfo
;EndFunc

;-Function-------------------------------------------------------------------------------------------
;Func TabGetType ( $lngTab )
;	if $lngTab  >  $pconMaxTabs or $lngTab < 0 then Return 0 ; error seterror (0)
;
;	;Return StringLeft ($a_hTabObject [$lngTab], $conTab_Info)
;
;	Return $a_hTabObject [$lngTab][$conTab_Info], $conTab_Info
;EndFunc
;---------------------------------------------------------------------------------------------------------
Func IE_Objects ($lngTab, $aRect = 0 )

	if $lngTab = $plng_BibleDef Then
		$oIE = _IECreateEmbedded ()
		$a_hTabIDs [ $plng_BibleDef]  = GUICtrlCreateObj ($oIE,  $aRect[0] , $aRect[1], $aRect[2] ,$aRect[3])
				;GUICtrlSetResizing ($a_hTabIDs [ $plng_BibleDef], bitor($GUI_DOCKTOP , $GUI_DOCKBOTTOM , $GUI_DOCKRIGHT , $GUI_DOCKLEFT))
				GUICtrlSetResizing ($a_hTabIDs [ $plng_BibleDef], bitor($GUI_DOCKTOP , $GUI_DOCKBOTTOM , $GUI_DOCKRIGHT , $GUI_DOCKLEFT))

		_IENavigate ($oIE, "about:blank")
		Local $sHTML = "<HTML><HEAD></HEAD>" & @CR

		$sHTML &= "<FRAMESET rows='80%,20%'>" & @CR
		$sHTML &= " <FRAME NAME=" & $IE_Upper & " SRC=about:blank></FRAME>" & @CR
		$sHTML &= " <FRAME NAME=" & $IE_Lower & " SRC=about:blank></FRAME>" & @CR
		$sHTML &= "</FRAMSET>"
		$sHTML &= "</HTML>"

		_IEDocWriteHTML ($oIE, $sHTML)
		_IEAction ($oIE, "refresh")
	Else
	;-------------
		$oIESearch = _IECreateEmbedded ()

		$a_hTabIDs [ $plng_SearchDef]  = GUICtrlCreateObj($oIESearch,  $aRect[0] , $aRect[1], $aRect[2] ,$aRect[3])
				GUICtrlSetResizing ($a_hTabIDs [ $plng_SearchDef], bitor($GUI_DOCKTOP , $GUI_DOCKBOTTOM , $GUI_DOCKRIGHT , $GUI_DOCKLEFT))

		_IENavigate ($oIESearch, "about:blank")
		;$SinkObject=ObjEvent($oIESearch,"IEEvent_","DWebBrowserEvents2") ; Assign events to UDFs starting with IEEvent_
	EndIf
EndFunc

;--------------------------------------------------------------------------------------------------------
