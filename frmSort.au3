;#include <modInclude.au3>
Global $frmSort, $strTabIDs
;cmdSort_Click ()
;---------------------------------------------------------------------------------------------
Func cmdSort_Click ()
	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf
	$lngExtraFormOpen  = 1
	;------------------

	Const $conLeft =10
	Const $conTop = 10
	Const $GUIWidthFav= 350, $GUIHeightFav = 320

	Local $frmSort
	Local $cmdOK, $cmdCancel, $msg, $cmdAutoSort
	Local $cmdUP, $cmdDown, $cmdFirst, $cmdLast
	Local $lstShort
	Local $strCur_TabID = $a_hTabObject [$plng_CurrTabNo]

	$frmSort = GUICreate("ترتيب الشرائط", $GUIWidthFav, $GUIHeightFav ,-1,-1, _
								formStyle (), formExStyle (), $frmMainForm )
			GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmSort)
;---
	$lstShort = GUICtrlCreateListView ( "الشريط", $conLeft, $conTop , $GUIWidthFav -140, $GUIHeightFav - 2*$conTop)
		GUICtrlSetFont  ($lstShort, $pstrMenuFSize + 2)
			_GUICtrlListView_SetColumnWidth($lstShort, 0, 200)
			;_GUICtrlListView_SetColumnWidth($lstShort, 1, 150)

;---
	$cmdFirst  = GUICtrlCreateButton ( "الاول",      $GUIWidthFav - $conLeft - 100, $conTop + 00, 100, 30 )
	$cmdUP     = GUICtrlCreateButton ( "الى أعلى",   $GUIWidthFav - $conLeft - 100, $conTop + 40, 100, 30 )
	$cmdDown   = GUICtrlCreateButton ( "الى اسفل",   $GUIWidthFav - $conLeft - 100, $conTop + 80, 100, 30 )
	$cmdLast   = GUICtrlCreateButton ( "الاخـير",     $GUIWidthFav - $conLeft - 100, $conTop + 120, 100, 30 )

	$cmdAutoSort = GUICtrlCreateButton( "ترتيب آلى", $GUIWidthFav - $conLeft - 100, $GUIHeightFav -120, 100, 30 )

	$cmdOK	   = GUICtrlCreateButton ( "موافق",      $GUIWidthFav - $conLeft - 100, $GUIHeightFav -80, 100, 30, $BS_DEFPUSHBUTTON )
	$cmdCancel = GUICtrlCreateButton ( "إلغاء الامر", $GUIWidthFav - $conLeft - 100, $GUIHeightFav -40, 100, 30)

	$strTabIDs = FillSort ( $lstShort )

	GUISetState ()
	_GUICtrlListView_SetUnicodeFormat($lstShort, True)
	_GUICtrlListView_SetItemSelected($lstShort, 0, True, True)
	Opt("GUIOnEventMode", 0)

	While 1
		$msg = GUIGetMsg(1)

		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return

			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmSort)
				frmSort_Close ()
				Return

			Case $msg[0] = $cmdFirst
				cmdFirst ( $lstShort, $strTabIDs )

			Case $msg[0] = $cmdUP
				cmdUP ( $lstShort, $strTabIDs )

			Case $msg[0] = $cmdDown
				cmdDown ( $lstShort, $strTabIDs )

			Case $msg[0] = $cmdLast
				cmdLast ( $lstShort, $strTabIDs )

			Case $msg[0] = $cmdAutoSort
				AutoSort ($lstShort, $strTabIDs)

			Case $msg[0] = $cmdOK
				cmdOK ($strTabIDs, $strCur_TabID)
				frmSort_Close ()
				Return

		EndSelect

	WEnd

EndFunc

;---------------------------------------------------------------------------
;Func GetItem (ByRef $aCTRL, $lstCtrl)
;	Local $ctrl = _GUICtrlListView_GetItemText ($lstCtrl)
;	Local $lng, $lngLen = UBound ($aCtrls)
;	For $lng = 0 To $lngLen -1
;		if $ctrl = $aCTRL [0] then Return $lng
;	Next
;
;	Return 0
;EndFunc
;---------------------------------------------------------------------------
Func AutoSort (Byref $lst, ByRef $aTab)
	Local $lng
	Local $lngLen = UBound ($aTab)
	Local $lngBib, $lngChp, $LngFlg, $LngAFr, $LngATo, $strText
	_ArraySort ($aTab)
		;_ArrayDisplay ($aTab)
	_ArrayPush($aTab, "" )
		;_ArrayDisplay ($aTab)

	;$lngLen = UBound ($aTab)

	For $lng = 0 To $lngLen - 1-1
		$strText = StringTrimLeft ($aTab[$lng],1)
		$lngBib = BHex2Adrs ($strText,1)
		$lngChp = BHex2Adrs ($strText,2)
		$LngFlg = BHex2Adrs ($strText,3)
		$LngAFr = BHex2Adrs ($strText,4)
		$LngATo = BHex2Adrs ($strText,5)

		$strText = CreateAdd ($lngBib, $lngChp, $LngAFr, $LngATo, $LngFlg)

		;MsgBox (0, $aTab[$lng], $strText)
		_GUICtrlListView_SetItemText ($lst, $lng, $strText )
	Next

EndFunc
;---------------------------------------------------------------------------
Func cmdOK (ByRef $aTab, $strCurID)
	Local $lng, $lngShift = 0
	;Local $lngLen = UBound($a_hTabIDs) -1

	For $lng = 0 To $plng_CreatedTabs -1; plng_CreatedTabs
		if $lng = $plng_SearchDef Then $lngShift = 1
		$a_hTabObject [$lng + $lngShift] = $aTab [$lng]
		WrtBibleAdd ( $lng + $lngShift )
		;msgbox (0,0, GetBibibleADD ( $lng + $lngShift ) )
	Next
	$lng = _ArraySearch ($a_hTabObject, $strCurID)
	if $lng <= $plng_CreatedTabs Then $plng_CurrTabNo = $lng ; for safety

	TabSetFous ($plng_CurrTabNo)
EndFunc
;---------------------------------------------------------------------------------------------------------------
Func FillSort (ByRef $lst)
	Local $lng, $lngShift = 0
	;Local $lngLen = UBound($a_hTabObject); -1
	Local $strTabs [$plng_CreatedTabs+1]

	For $lng = 0 To $plng_CreatedTabs; plng_CreatedTabs
		if $lng <> $plng_SearchDef Then
			GUICtrlCreateListViewItem ( GetBibibleADD($lng), $lst )
		EndIf
	Next

	For $lng = 0 To $plng_CreatedTabs; plng_CreatedTabs
		If $lng = $plng_SearchDef Then $lngShift = 1
		$strTabs [$lng] = $a_hTabObject [$lng + $lngShift]
	Next

	Return $strTabs
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func cmdDown (ByRef $lst, ByRef $aTab)
	Local $lngLen = _GUICtrlListView_GetItemCount ($lst)
	Local $lngSlct =  _GUICtrlListView_GetSelectionMark ($lst)
	Local $strName, $strID

	if $lngLen -1 = $lngSlct Then Return

	$strID = $aTab [$lngSlct + 1]
	$strName = _GUICtrlListView_GetItemText($lst, $lngSlct + 1)

	$aTab [$lngSlct + 1] = $aTab [$lngSlct]
	$aTab [$lngSlct] = $strID

	_GUICtrlListView_SetItemText ($lst, $lngSlct + 1, _GUICtrlListView_GetItemText($lst, $lngSlct ) )
	_GUICtrlListView_SetItemText ($lst,  $lngSlct, $strName  )
	_GUICtrlListView_SetSelectionMark ($lst, $lngSlct + 1)
	_GUICtrlListView_SetItemSelected ($lst, $lngSlct + 1)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func cmdUp (ByRef $lst, ByRef $aTab)
	Local $lngSlct =  _GUICtrlListView_GetSelectionMark ($lst)
	Local $strName, $strID

	if $lngSlct = 0 Then Return

	$strID = $aTab [$lngSlct - 1]
	$strName = _GUICtrlListView_GetItemText($lst, $lngSlct - 1)
;ConsoleWrite ($strName  & @cr)
	$aTab [$lngSlct - 1] = $aTab [$lngSlct]
	$aTab [$lngSlct] = $strID

	_GUICtrlListView_SetItemText ($lst, $lngSlct - 1, _GUICtrlListView_GetItemText($lst, $lngSlct ) )
	_GUICtrlListView_SetItemText ($lst, $lngSlct, $strName  )
	_GUICtrlListView_SetSelectionMark ($lst, $lngSlct - 1)
	_GUICtrlListView_SetItemSelected ($lst, $lngSlct - 1)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func cmdFirst (byRef $lst, ByRef $aTab)
	;Local $lngSlct = _GUICtrlListView_GetItemText ($lst, _GUICtrlListView_GetSelectionMark($lst))
	Local $lngSlct =  _GUICtrlListView_GetSelectionMark($lst)
	Local $strName, $lng, $strID
;_GUICtrlListView_GetHotItem

	if $lngSlct = 0  Then Return

	$strID = $aTab [$lngSlct ]
	$strName = _GUICtrlListView_GetItemText($lst, $lngSlct)

;ConsoleWrite ($strName  & @cr)
;ConsoleWrite (_GUICtrlListView_GetSelectionMark($lst) & @CR)

	for $lng = $lngSlct to 1 step -1
		_GUICtrlListView_SetItemText ($lst, $lng, _GUICtrlListView_GetItemText($lst, $lng-1  ) )
		$aTab [$lng] = $aTab [$lng-1]
	Next

	$aTab [0] = $strID
;MsgBox (0,0, "tsd")
	_GUICtrlListView_SetItemText ($lst, 0, $strName )
	_GUICtrlListView_SetSelectionMark ($lst, 0 )
	_GUICtrlListView_SetItemSelected ($lst, 0 )
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func cmdLast (ByRef $lst, ByRef $aTab)
	Local $strName, $lng, $strID
	Local $lngLen = _GUICtrlListView_GetItemCount ($lst)-1
	Local $lngSlct =  _GUICtrlListView_GetSelectionMark($lst)

	if $lngSlct = $lngLen  Then Return
	$strName = _GUICtrlListView_GetItemText($lst, $lngSlct)
	$strID = $aTab [$lngSlct]

	for $lng = $lngSlct to $lngLen -1
		_GUICtrlListView_SetItemText ($lst, $lng, _GUICtrlListView_GetItemText($lst, $lng +1 ))
		$aTab [$lng] = $aTab [$lng+1]
	Next

	$aTab [$lngLen] = $strID
	_GUICtrlListView_SetItemText ($lst, $lngLen, $strName)
	_GUICtrlListView_SetSelectionMark ($lst, $lngLen )
	_GUICtrlListView_SetItemSelected ($lst, $lngLen )

EndFunc
;---------------------------------------------------------------------------

Func frmSort_Close ()
	;IF IsPtr ( $frmShahed ) Then
		GUIDelete($frmSort)
		$frmSort = 0
		$lngExtraFormOpen = 0
;	EndIf
EndFunc
;------------