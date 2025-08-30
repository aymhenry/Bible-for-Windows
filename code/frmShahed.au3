Global $lstShahed

;---------------------------------------------------------------------------------------------
Func cmdShahed_Click ()
	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf
	$lngExtraFormOpen  = 1
	;------------------

	Local $lngBible  = CurBible()
	Local $lngChptr  = CurChptr ()
	Local $lngChkAya = CurAyaChk()
	Local $conGetFavManagTit = "الشواهد", $strTit

	Const $conLeft =10
	Const $conTop = 10
	Const $GUIWidthFav= 500, $GUIHeightFav = 350

	Local $frmShahed
	Local $cmdOK, $cmdCancel,$cmdOK_New, $msg

	$strTit = $avArray [$lngBible] & " " & Num2India ($lngChptr) ;& " : " & Num2India ($lngNo)
		if $lngChkAya <> 0 then
			$strTit = $strTit & " : " & Num2India ($lngChkAya)
		endif

	$frmShahed = GUICreate($conGetFavManagTit & " " & $strTit, $GUIWidthFav, $GUIHeightFav ,-1,-1, _
								formStyle (), formExStyle (), $frmMainForm )
			GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmShahed)
;---
	$lstShahed = GUICtrlCreateListView ("كود | الاية | الشاهد |نص لشاهد", $conLeft, $conTop + 30, $GUIWidthFav -30, $GUIHeightFav - 100)
			GUICtrlSetFont  ($lstShahed, $pstrMenuFSize + 2)
			_GUICtrlListView_SetColumnWidth($lstShahed, 0, 0)
			_GUICtrlListView_SetColumnWidth($lstShahed, 1, 60)
			_GUICtrlListView_SetColumnWidth($lstShahed, 2, 50)
			_GUICtrlListView_SetColumnWidth($lstShahed, 3, 260)

;---
	$cmdOK	   = GUICtrlCreateButton ( "إذهـب الى",   $conLeft + 000, $GUIHeightFav -50, 100, 30, $BS_DEFPUSHBUTTON )
	$cmdOK_New = GUICtrlCreateButton ( "صفحة جديدة", $conLeft + 110, $GUIHeightFav -50, 100, 30)
	$cmdCancel = GUICtrlCreateButton ( "إلغاء الامر", $conLeft + 220, $GUIHeightFav -50, 100, 30)


		If 0 = FillShahed ( $lstShahed, $lngBible, $lngChptr, $lngChkAya) Then
			GUICtrlSetState ( $cmdOK, $GUI_DISABLE)
			GUICtrlSetState ( $cmdOK_New, $GUI_DISABLE)
		Else
			GUICtrlSetState ( $cmdOK, $GUI_EnABLE)
			GUICtrlSetState ( $cmdOK_New, $GUI_EnABLE)
		EndIf

	GUISetState ()

	Opt("GUIOnEventMode", 0)

	While 1
		$msg = GUIGetMsg(1)

		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return

			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmShahed)
				frmShahed_Close ()
				Return

			Case $msg[0] = $cmdOK_New
				cmdShahd_OK_new ()
				Return

			Case $msg[0] = $cmdOK
				cmdShahd_OK ()
				Return

		EndSelect

	WEnd

EndFunc

;---------------------------------------------------------------------------
Func cmdShahd_OK ()
	Local $strAdd = GUICtrlRead ( GUICtrlRead($lstShahed) )
	Local $lngPos = StringInStr ( $strAdd, "|" )

	;ConsoleWrite ("$lngPos = " & $lngPos & @cr)

	if $lngPos > 1 Then
		$strAdd = StringMid ( $strAdd, 1, $lngPos -1)
		;msgbox (0,"", $strAdd)
		CurBible ( BHex2Adrs ($strAdd, 1) )
		CurChptr ( BHex2Adrs ($strAdd, 2) )

		CurAyaFrom ( BHex2Adrs ($strAdd, 4) )
		CurAyaTo ( BHex2Adrs ($strAdd, 5) )

		if CurAyaChk () <> 0 then
			CurAyaChk ( BHex2Adrs ($strAdd, 4) )
		EndIf
		;ConsoleWrite ("cmdShahd_OK before update" & @cr)
		UpdateTxt()
		;ConsoleWrite ("cmdShahd_OK After  update" & @cr)
	EndIf


	frmShahed_Close ()

EndFunc
;--------------------------------------
Func cmdShahd_OK_new ()
	Local $strAdd = GUICtrlRead ( GUICtrlRead($lstShahed) )
	Local $lngPos = StringInStr ( $strAdd, "|" )

	if $lngPos > 1 Then
		$strAdd = StringMid ( $strAdd, 1, $lngPos -1)

		CurBible ( BHex2Adrs ($strAdd, 1) )
		CurChptr ( BHex2Adrs ($strAdd, 2) )

		CurAyaFrom ( BHex2Adrs ($strAdd, 4) )
		CurAyaTo ( BHex2Adrs ($strAdd, 5) )

		if CurAyaChk () <> 0 then
			CurAyaChk ( BHex2Adrs ($strAdd, 4) )
		EndIf

			Local $nTab = TabCreate ()
			SetTabInfoBible ( $nTab )
			TabSetFous ( $nTab ) ; the new one and write bible in IE
	EndIf

	frmShahed_Close ()

EndFunc

;---------------------------------------------------------------------------
Func frmShahed_Close ()
	;msgbox (0,"","close shahd")
	;IF IsPtr ( $frmShahed ) Then
		GUIDelete($frmShahed)
		$frmShahed = 0
		$lngExtraFormOpen = 0
;	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func FillShahed (BYREF $lstFav, $lngBible, $lngChptr, $lngNo = 0)

	_GUICtrlListView_DeleteAllItems ($lstFav)
	;=======================
	Local $objMyDB2
	Local $lngB, $LngCh, $lngAyF, $LngAyT
	const $conTit2 = "الشواهد:"
	Local $strAya, $strAdd, $lngPos, $strTXTAdd, $strSQL_SUB, $lngA
	Local $strDB_App

	$lngBible = ConvKat2Dic ($lngBible, $lngChptr, $lngNo)

	$strDB_App = FolderFileName ($gconDB_App)
	;if FileExists (@ScriptDir & "\" & $gconDB_App) = 0 Then
	If $strDB_App = "" Then
		WrtStatus ("ملف غير موجود :" & $gconDB_App, $pconStatusInfo )
		Return ""
	EndIf

	_OnError(True)
		$objMyDB2 = $objDBS.OpenDatabase ($strDB_App, True, True, ";pwd=" & $conSysPassWord)
	_OnError(False)

	If _Error() Then
		WrtStatus ("خطأ فى قراءة ملف :" & $gconDB_App, $pconStatusInfo )
		Return 0
	EndIf

	If $lngNo = 0 Then
		$strSQL_SUB = ""
	Else
		$strSQL_SUB = " And (dicStart = " & $lngNo  & ") "; & _	; no need gfor = dicEnd =on Shahed I think
	Endif

	Local $StrSQL = "SELECT dicBible, dicChapter, dicStart, dicEnd, sh2Bible, sh2Chptr, sh2AddFrom, sh2AddTo " & _
					"FROM tblShahd2 INNER JOIN tblMainBook ON tblShahd2.sh2VersID = tblMainBook.dicShahed " & _
					" WHERE (dicBible = " & $lngBible  & ")" & _
					" And (dicChapter = " & $lngChptr  & ")" & _
					$strSQL_SUB & _
					" Order by dicStart,sh2Bible, sh2Chptr, sh2AddFrom;"

	Local $recRecAya;=  $objMyDB2.OpenRecordset ($strSQL)
	If False =  OpenRecordSet ($objMyDB2, _
							  $recRecAya, _
							  $strSQL, _
							  "frmShahed: Error 01-Open Rec. set", _
							  $frmShahed)  Then Return ""

	if $recRecAya.RecordCount = 0 Then
		$recRecAya.Close
		Return ""
	EndIf

	$strAya = ""

	With $recRecAya
		.MoveLast
		.MoveFirst
		While .Eof <> -1

			$lngB   =  .Fields("sh2Bible").Value
			$LngCh  =  .Fields("sh2Chptr").Value
			$lngAyF =  .Fields("sh2AddFrom").Value
			$LngAyT =  .Fields("sh2AddTo").Value

			$lngA =  .Fields("dicStart").Value

						;						GetOneAya ($lngBible, $lngChptr, $lngNo, _
						;								$bNumbers = 0,    $bTach = 0,       $strHiWords = "", $AllWords=0, _
						;									$strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 ="")
						;msgbox (0,"bible", $lngB)
			if $lngB +0 >0 then
				$strAya =  GetShAya ($lngB, $LngCh, $lngAyF, $LngAyT, 70, "$")
				if $strAya <> "" then
					$strAdd = BAdrs2Hex ($lngB, $LngCh, CurAyaChk(), $lngAyF, $LngAyT)
					$lngPos = StringInStr ( $strAya, "$", 2)
					$strTXTAdd =  StringStripWS (StringMid ($strAya, 1, $lngPos-1 ), 1+2)
					$strAya    =  StringMid ($strAya,  $lngPos+1, StringLen ($strAya) )

					GUICtrlCreateListViewItem  ($strAdd & "|" & Num2India ($lngA) & "|"  & $strTXTAdd & "|" & $strAya , $lstFav)
				Endif
			EndIf
			.MoveNext
		WEnd
	EndWith

	$recRecAya.Close

	_GUICtrlListView_SetItemSelected ( $lstFav, 0)
	Return 1

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
