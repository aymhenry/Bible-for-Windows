;==-------------------------------------------------------------------------------------------------------------------------------------------
;Global constants

Global Const $conMax = 5020

;--	Global Vars
Global $pconTblStart = "<tbl"
Global $pconTblEnd = "<end>"

Global $objDB_Kamos, $objKamosDB, $recKamos, $recKRecSrch
Global $oIE_Kamos, $GUI_Kamos
Global $strFolder;, $strLast
Global $lstKamos, $cmbTxtSearch
Local $conMark = "$#$#$#$#"
Local $conMark2 = ' oncontextmenu="return false"'
;---------------------------------------------------------------------------------------------------------------------------
Func cmdKamos_Click  ()
	if 0 =Setting () then
		Return
	EndIf

	Const $conKamosTit = "قاموس الكتاب"
	Const $conLeftSide =15
	Const $conTopSide =15
	;const $conHeading = "|" & "الكلمة"
	const $conHeading = "|" & "نتيجة البحث"

	Local $GUIHeight = 400
	Local $GUIWidth = 700
	local $cmdOK, $cmdSearch, $msg, $strSrch_txt, $cmdCancel
	Local $strCurVal = "", $strOldVal = ""
	Local $strSelect, $lngWidthPart1 = 170, $radOne, $radAll

	Local $strSelectClip
	$strSelectClip = StringLeft (ClipGet (),60)
	if @error <> 0 then $strSelectClip = ""

	$strSelect = Copy2BibleText ()
	$strSelect = RemCach ($strSelect)
	$strSelect = RemUniCode ($strSelect)
	;$strSearch_txt = GetPrevSearch ( $strSelect)

	If $strSelect = "" Then
		$strSelect = StringStripWS ($strSelectClip, 2)
		$strSelect = RemCach ($strSelect)
		$strSelect = RemUniCode ($strSelect)
		$strSelectClip = ""; clean
	EndIf
;-----
	$frmKamos = GUICreate($conKamosTit, $GUIWidth, $GUIHeight,-1,-1, _
				formStyle (), formExStyle (), $frmMainForm )
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmKamos )

;-----
	GUICtrlCreateGroup ("الكلمة",  $conLeftSide , $conTopSide, $lngWidthPart1, 73+30 )

	$cmbTxtSearch = GUICtrlCreateCombo( "", $conLeftSide +5, $conTopSide + 30 , $lngWidthPart1-20, 25)
		GUICtrlSetState ($cmbTxtSearch, $GUI_FOCUS)
		GUICtrlSetData($cmbTxtSearch, $strSelect & "|" & $strSearch_txt , $strSelect)

    $cmdSearch = GUICtrlCreateButton ("إبحـث",$conLeftSide+30,  $conTopSide +60, 100, 30, $BS_DEFPUSHBUTTON)

		GUICtrlSetTip ( -1, "أكتب الكلمه المراد البحث عنة" & @CR & "لا يفرق بين اشكال الألف و التاء والهاء آخر الكلمة","البحث",1, 1)
;
;---

	$lstKamos = GUICtrlCreateListView ($conHeading, $conLeftSide, $conTopSide + 80+40, _
			$lngWidthPart1, ($GUIHeight - 4*$conTopSide -180) ) ;$GUIWidth - 2*$conLeftSide, ($GUIHeight - $conTopSide - 70)/2
		;GUICtrlSetBkColor($lstKamos, $GUI_BKCOLOR_LV_ALTERNATE)
		_GUICtrlListView_SetColumnWidth($lstKamos, 0, 0)
		_GUICtrlListView_SetColumnWidth($lstKamos, 1, 170)
		;ReSizeing ()

	$oIE_Kamos = _IECreateEmbedded ()
	$GUI_Kamos = GUICtrlCreateObj($oIE_Kamos, 2*$conLeftSide + $lngWidthPart1, $conTopSide  , _
			$GUIWidth - 3*$conLeftSide - $lngWidthPart1, ($GUIHeight - 3*$conTopSide -73))
		_IENavigate ($oIE_Kamos, "about:blank")

;---
	; GROUP WITH RADIO BUTTONS
	GuiCtrlCreateGroup("خيارات العرض فى صفحة البحث", $conLeftSide, $conTopSide +($GUIHeight - 2*$conTopSide -75)  , 320, 80 ) ;$GUIWidthBible - 2*$conLeftSide2
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radOne = GUICtrlCreateRadio ("عرض فقط العنصر المحدد فى نتيجة البحث",  $conLeftSide *2, $conTopSide +($GUIHeight - 2*$conTopSide -58)  , 300, 25)
		;GuiCtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radAll = GUICtrlCreateRadio ("عرض كل نتيجة البحث.",  $conLeftSide*2, $conTopSide +($GUIHeight - 2*$conTopSide -30), 300, 25)
		GuiCtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
;---
	$cmdOK = GUICtrlCreateButton ("موافق", $GUIWidth - $conLeftSide - 100, _
				$GUIHeight -30 - 2*$conTopSide - 25 , 100, 30)
		GUICtrlSetState ($cmdOK, $gui_disable)

	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $GUIWidth - $conLeftSide - 100, _
				$GUIHeight -30 - $conTopSide  ,100, 30 )
;---
	GUISetState(@SW_SHOW)
	GUICtrlSetState ($cmbTxtSearch, $GUI_FOCUS); do not move before IE

	Opt("GUIOnEventMode", 0)

	While 1
		$msg = GUIGetMsg(1)
		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmKamos)
				frmKamos_CLose ()
				Return

			Case $msg[0] = $cmdSearch
				$strSrch_txt = GUICtrlRead ($cmbTxtSearch)
				If $strSrch_txt = "" Then
					WrtStatus ( "إدخل الكلمة المطلوب البحث عنها" )
				Else
					GUICtrlSetState ($cmdSearch, $gui_disable)
					GUICtrlSetState ($cmdOK, $gui_disable)

					if 1 = TxtWord_Change($strSrch_txt) Then
						GUICtrlSetState ($cmdOK, $gui_Enable); $cmdOK
					Else
						GUICtrlSetState ($cmdOK, $gui_disable)
					EndIf

					GUICtrlSetState ($cmdSearch, $gui_Enable)
				EndIf

			Case $msg[0] = $cmdOK
				$strSrch_txt = GuiCtrlRead ($cmbTxtSearch)
					If  $plng_SearchDef <> _GUICtrlTab_GetCurFocus ($hTab) Then
						TabSetFous ( $plng_SearchDef )
						;$lngUpdateFlag = 0 ; disa
					EndIf

					Local $frmProg = cmdProgress_Click ()

					GUISetState (@SW_HIDE, $frmKamos )

					GUISetCursor (15, 1, $frmMainForm); wait
					GUISetState(@SW_DISABLE, $frmMainForm )

                    If GUICtrlRead ( $radAll ) =  $GUI_CHECKED Then
                        ShowInMain  ($recKRecSrch, $strSrch_txt )
                    Else
                        ShowInMainOneItem ()
                    EndIf

					frmKamos_CLose ()

					GUIDelete ($frmProg)

					GUISwitch ( $frmMainForm )
					WinActivate ($frmMainForm)

					GUISetCursor (2, 0, $frmMainForm); ARROW
					GUISetState(@SW_ENABLE, $frmMainForm )

					Return
	EndSelect

		$strOldVal = GUICtrlRead ( GUICtrlRead($lstKamos) )
		if $strCurVal <> $strOldVal Then
			$strCurVal = $strOldVal

			;$strSearch_txt = GetPrevSearch  ( $strCurVal )

			GUICtrlSetState ($lstKamos, $GUI_FOCUS)
			ShowTip ()

		EndIf

		;Sleep(100)
	WEnd
EndFunc   ;==>_Main
;---------------------------------------------------------------------------------------------------------------------------
Func Upd_Kamos ()
	Local $strRec
	Local $lngPos
	if $recKRecSrch.Eof = -1 and $recKRecSrch.Bof =-1 Then
		Msgbox ($conMirrorR2L + 32,$gconProgName, "النص غير موجود",0, $frmKamos)
		Return 0
	EndIf
;MsgBox (0,"test", "Enter")
	$lngPos = 0
	With $recKRecSrch

		_GUICtrlListView_DeleteAllItems($lstKamos)

		While .EOF() <>-1 And .BOF() <>-1

			$strRec = .Fields("dicSer").Value & "|" & _
					StringStripWS (TextComb (.Fields("dic2Name").Value, .Fields("dic2Tach").Value ),1+2)

			GUICtrlCreateListViewItem ($strRec, $lstKamos)
			.MoveNext

			$lngPos = $lngPos + 1
			if .EOF =-1 or $lngPos >= $conMax Then
				ExitLoop
			EndIf
		Wend

	EndWith

	_GUICtrlListView_SetItemSelected($lstKamos, 0)
;MsgBox (0,"test", "goto Explain")
	Explain ( GUICtrlRead(GUICtrlRead($lstKamos)) )

	Return 1
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func TxtWord_Change ($strWord)
	Local $lngFeedBack
	$strWord = RemCach ($strWord)
	$strSearch_txt = GetPrevSearch  ( $strWord )

	AppFlter ($strWord)
	$lngFeedBack = Upd_Kamos ()

	_GUICtrlListView_SetItemSelected ( $lstKamos, 0)
	Return $lngFeedBack
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Setting ()
	Const $conKamosPass = "PleaseUseDoNotChange"
	Local $strDB_Kamos = FolderFileName ($gconDB_Kamos)

	;If Not FileExists (@ScriptDir & "\" & $gconDB_Kamos) Then
	If $strDB_Kamos = "" Then
		WrtStatus ("ملف غير موجود :" & $gconDB_Kamos, $pconStatusInfo )
		Msgbox($conMirrorR2L + 16,$gconProgName, _
				"ملف مفقود من الملفات الرئيسية :" & $gconDB_Kamos _
				,0, $frmMainForm)

		Return 0
	EndIf

	$strFolder = @ScriptDir
    $objDB_Kamos = ObjCreate("DAO.DBEngine.36")
;--
	_OnError()
	$objKamosDB = $objDB_Kamos.OpenDatabase ($strDB_Kamos, False, false, ";pwd=" & $conKamosPass)
	_OnError(False)

	If _Error() Then
		WrtStatus ("خطأ فى قراءة ملف :" & $gconDB_Kamos, $pconStatusInfo )
		Return ""
	EndIf
;--

	Return 1
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func AppFlter ( $strSearch)

	Local $lngPos, $strGate = " OR "
	Local $strTxtWhere = ""

	if $strSearch = "" Then
		WrtStatus ( "إدخل الكلمة المطلوب البحث عنها" )
		Return
	EndIf
	$strSearch = CleanTxt ($strSearch)
		;$strSearch = RemCach ( $strSearch)
		;$strSearch = StringReplace ($strSearch, "أ", "ا")
		;$strSearch = StringReplace ($strSearch, "إ", "ا")
		;$strSearch = StringReplace ($strSearch, "آ", "ا")
		;$strSearch = StringReplace ($strSearch, "ا","[" & "آأإا" & "]")

		;$strSearch = StringReplace ($strSearch, "ئ","ي")
		;$strSearch = StringReplace ($strSearch, "ى","ي")
		;$strSearch = StringReplace ($strSearch, "ي","[" & "ئيى" & "]")

		;$strSearch = StringReplace ($strSearch, "ؤ","و")
		;$strSearch = StringReplace ($strSearch, "و","[" & "وؤ" & "]")

		;$strSearch = $strSearch & " "
		;$strSearch = StringReplace ($strSearch, "ة ", "ه ")
		;if StringInStr ($strSearch, "ه ") > 0 then
			;$strSearch = StringReplace ($strSearch, "ه","[" & "هة" & "]")
		;EndIf

		;$strSearch = StringReplace ($strSearch, "'", "''")
	;--
	$strSearch = $strSearch & " "
	$lngPos = StringInStr ($strSearch, " ")

		While $lngPos > 0
			$strTxtWhere = $strTxtWhere & $strGate & " dic2Name Like '*" & StringMid ($strSearch, 1, $lngPos -1) & "*' "
			$strSearch = StringTrimLeft ($strSearch, $lngPos + 1)

			$lngPos = StringInStr ($strSearch, " ")
		WEnd
		$strTxtWhere = StringTrimLeft ($strTxtWhere, StringLen ($strGate)); remove 1st "  OR" "  AND"
	;--
	Local $strSQL
	if $strTxtWhere <> "" Then
		$strSQL = "SELECT * FROM tblDic2 " & "Where " & $strTxtWhere & " Order by dicSer "
	else
		$strSQL = "SELECT * FROM tblDic2 Order by dicSer "
	EndIf

	;MsgBox (0,"SQL", $strSQL)

	If False =  OpenRecordSet ($objKamosDB, _
							  $recKRecSrch, _
							  $strSQL, _
							  "frmKamos: Error 01-Open Rec. set", _
							  $frmKamos)  Then Return ""

	if $recKRecSrch.BOF = -1 And $recKRecSrch.EOF = -1 Then
		Return 0
	EndIf

	$recKRecSrch.MoveFirst

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Explain ($strSelect)
	Local $strSQL, $lngSep

		$lngSep = StringInStr ($strSelect, "|")
		if $lngSep <= 1 Then
			;MsgBox (0,"test", $lngSep)
			Return 0
		EndIf
		;if $strLast = $strSelect then return 1
		;$strLast = $strSelect
	$strSQL = "SELECT * FROM tblDic2 Where dicSer = " & StringLeft ($strSelect, $lngSep -1)
		;MsgBox (0,"test", $strSQL)

	If False =  OpenRecordSet ($objKamosDB, _
							  $recKamos, _
							  $strSQL, _
							  "frmKamos: Error 02-Open Rec. set", _
							  $frmKamos)  Then
		;MsgBox (0,"text","exit 01")
		Return ""
	EndIf


	if $recKamos.BOF = -1 And $recKamos.EOF = -1 Then
;MsgBox (0,0,"exit 02")
		Return 0
	EndIf

	$recKamos.MoveFirst

	SetDataFormat ( StringStripWS (TextComb ($recKamos.Fields("dic2Name").Value, $recKamos.Fields("dic2Tach").Value ),1+2), _
					$recKamos.Fields("dic2Txt").Value  )

	$recKamos.Close
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func ShowTip ()
	Local $strSelect = GUICtrlRead(GUICtrlRead($lstKamos))
	Explain ( $strSelect)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func frmKamos_CLose ()
	IF IsPtr ( $frmKamos ) Then
		GUIDelete($frmKamos)
		$frmKamos = 0
	EndIf

	if IsObj($recKRecSrch) then
		$recKRecSrch.Close
		$recKRecSrch = 0
	EndIf

EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func SetDataFormat ( $strTitle, $strText )
	Local $strFixedText

	Local  $sStyle = '<html><head>' & _
					'<style type="text/css">' & _
					'span.titleKamos {' & _
						GetHTML_Style ( $as_SysFont [ $conKamosFontTit ]) & _
						'line-height: 2;' & _
						'text-indent: 0;' & _
					'}' & _
					'span.Kamos {' & _
						GetHTML_Style ( $as_SysFont [ $conKamosFont ]) & _
						'line-height: 2;' & _
						'text-indent: 20;' & _
					'}' & _
					'</style></head>'

	Local $sBody = '<body  dir="rtl" bgcolor="#' & StringRight("000000" & hex($as_BKColor[2] + 0 ),6) & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 20; margin-left: 30; margin-top: 10; margin-bottom: 10" ' & _
					$conMark & _
					'>' & _
					'<Input type="hidden" Name="' & $conSrchHTML_Txt & '">;'	;oncontextmenu="return false'

	$strFixedText = FixNum ($strText)
	$strFixedText = TxtFormat ($strFixedText)

	$strText = "<span class='titleKamos'>" & $strTitle  & "</span>" & _
			   "<br><hr>" & _
			   "<span class='kamos'>" & $strFixedText   & "</span>"   ; TxtFormat

	_IEDocWriteHTML ($oIE_Kamos, $sStyle & $sBody & $strText & $conEndHTML)
	_IEAction ($oIE_Kamos, "refresh")

	GUICtrlSetState ($lstKamos ,$GUI_FOCUS)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------

Func ShowInMain (ByRef $recKam, $strSrch_txt, $lngID = 0)
	Local $strFixedText
	Local $lngTemp, $lngProg, $iDone, $iAll_Rec, $strTextDic, $strText, $lngPos, $lngSerial
	Local  $sStyle = '<html><head>' & _
					'<style type="text/css">' & _
					'span.titleKamos {' & _
						GetHTML_Style ( $as_SysFont [ $conKamosFontTit ]) & _
						'line-height: 2;' & _
						'text-indent: 0;' & _
					'}' & _
					'span.Kamos {' & _
						GetHTML_Style ( $as_SysFont [ $conKamosFont ]) & _
						'line-height: 2;' & _
						'text-indent: 20;' & _
					'}' & _
					'span.title {' & _
						GetHTML_Style ( $as_SysFont [ $conFSrchTitle ]) & _
						'line-height: 2;' & _
						'text-indent: 1;' & _
					'}' & _
					'</style></head>'

	Local $sBody = '<body  dir="rtl" bgcolor="#' & StringRight("000000" & hex($as_BKColor[2] + 0 ),6) & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 20; margin-left: 30; margin-top: 10; margin-bottom: 10" ' & _
					$conMark2 & _
					' >' & _
					'<Input type="hidden" Name="' & $conSrchHTML_Txt & '">' ; to prevent error
					; oncontextmenu="return false"

	_IEDocWriteHTML ($oIESearch, $sStyle & $sBody & $conEndHTML)
	_IEAction ($oIESearch, "refresh")

	Local $oBody = _IETagNameGetCollection($oIESearch, "body", 0)

    if $recKam.Eof = -1 and $recKam.Bof =-1 Then
		_IEDocInsertHTML($oBody, $conEndHTML)
		Return ""
	EndIf

	GUICtrlSetData ($hProg, 0)
	GUICtrlSetState ($hProg, $GUI_SHOW)
	;----
	_IEDocInsertHTML ($oBody, "<hr><pre>" )
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "البحث عن النـص" & ": " & $strSrch_txt  & "<span><br>")
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "نطــاق البحــث" & ": " & "قاموس الكتاب المقدس"  & "<span><br>")
	_IEDocInsertHTML ($oBody, "<pre>" ) ; <hr>
	;--------------

		With $recKam
			.MoveLast
			.MoveFirst
			$iAll_Rec = .RecordCount ()

		While .Eof <> -1
				$lngSerial = $lngSerial + 1
				$strTextDic =  .Fields("dic2Txt").Value
				$strFixedText = FixNum ($strTextDic)
				$strFixedText = TxtFormat ($strFixedText)

				$strText = "<span class='titleKamos'>" & _
							StringStripWS (TextComb (.Fields("dic2Name").Value, .Fields("dic2Tach").Value ),1+2) & "</span>" & _
							   "<br><hr>" & _
							   "<span class='kamos'>" & $strFixedText  & "</span>"  & _
							   "<br><br>"

				_IEDocInsertHTML($oBody, $strText)

			;---
			$lngPos = $lngPos + 1

			$lngTemp = Int($iDone / $iAll_Rec *100)

			if  $cmdOK_Stop = GUIGetMsg () Then
				$lngTemp = 200
			EndIf

			If $lngTemp <> $lngProg Then
				$lngProg = $lngTemp
				GUICtrlSetData ($hProg, $lngProg)
				If $lngtemp >= 100 Then ExitLoop
			EndIf
			;---
			$recKam.MoveNext
		WEnd
		EndWith
	;--------------
	if $lngtemp > 100 Then
		WrtStatus ( "ايقاف البحث، تم سرد " & "  " & Num2India($lngSerial) & " من " & Num2India ($iAll_Rec) & " عنصر")
		_IEDocInsertHTML ($oBody, "<hr><br><span class='title'>" &  "تم إيقاف عملية البحث - تم سرد عدد " & "  " & Num2India($lngSerial) & "   من إجمالى  " & Num2India ($iAll_Rec) & " خرج نتائج البحث" & "<span>")
	Else
		_IEDocInsertHTML ($oBody, "<hr><br><span class='title'>" &  "إجمالى نتائج البحث: " & Num2India ($iAll_Rec) & " عنصر تم إيجادة" & "<span>")
	EndIf

	_IEDocInsertHTML($oBody, $conEndHTML)
	;_IEAction ($oIESearch, "refresh")
	;=========
	GUICtrlSetData ($hProg, 100)
	GUICtrlSetState ($hProg, $GUI_HIDE)
	GUICtrlSetState ($cmdOK_Stop, $GUI_HIDE)
EndFunc
;--------------------------------------------------------------------------------------------------
Func ShowInMainOneItem ()
    Local $strHTML = _IEDocReadHTML ($oIE_Kamos)
	$strHTML = StringReplace ( $strHTML, $conMark, $conMark2)
    _IEDocWriteHTML ($oIESearch, $strHTML)
	_IEAction ($oIESearch, "refresh")
EndFunc
;--------------------------------------------------------------------------------------------------
Func ExtraTbl ($strData)

	Const $conHTML_Tbl_Start = "<table border='1' width='90%' dir='rtl' lang='ar' cellspacing=0 cellpadding=0 " & _
			"style ='" & GetHTML_Style ( $as_SysFont [ $conKamosFont ]) & "'>"; style='kamos'
	Const $conHTML_Tbl_End = "</table>"
	Const $conHTML_hd_Start = "<th>"
	Const $conHTML_hd_End = "</th>"
	Const $conHTML_col_Start = "<td>"
	Const $conHTML_col_End = "</td>"
	Const $conHTML_rw_Start = "<tr>"
	Const $conHTML_rw_End = "</tr>"

	Local $strTbl, $strHtml_Start, $strHTML_End
	Local $arData, $lngRow, $lngCol, $lngCnt, $lngCells
	Local $lngCols = India2Num (StringMid ( $strData, Stringlen ($pconTblStart)+1, 2) ) + 0
	;Local $lngCols = StringMid ( $strData, Stringlen ($pconTblStart)+1, 2); + 0
	;MsgBox 	(0,0, StringMid ( $strData, Stringlen ($pconTblStart)+1, 2))

	Local $lngStart = StringInStr ( $strData, $pconTblStart)
	Local $lngEnd = StringInStr ( $strData, $pconTblEnd)
	;msgbox (0, $lngStart,  $lngEnd)

	$strData = StringMid ($strData, $lngStart, $lngEnd + StringLen ($pconTblEnd) - $lngStart)

	;$lngEnd + StringLen($pconTblEnd)-1 <> stringlen ($strData) Or _
	If $lngStart <> 1 Or _
		   $lngCols <= 1 Or _
		   $lngEnd - $lngStart - Stringlen ($pconTblStart) < 15 Then Return ""


	$strData = StringMid ( $strData, StringLen ($pconTblStart)+4, $lngEnd - $lngStart - StringLen ($pconTblStart) )
	$strData = StringStripWS  ($strData, 4); remove double spc between words

	$strData = StringReplace ($strData, @CRLF, @CR)
	$strData = StringReplace ($strData, @LF, "")
	$strData = StringReplace ($strData, @CR & @CR, @CR)

	If StringLeft ($strData,1) = @CR Then
		$strData = StringTrimLeft ($strData,1)
	EndIf

	$arData  = StringSplit  ($strData, @CR, 1)
	$lngCells = $arData[0]
	$lngRow = $lngCols * Int ($lngCells / $lngCols )

;MsgBox (0,0, $arData[1])
;MsgBox (0,0, $arData[2])
;MsgBox (0,0, $arData[3])
;MsgBox (0,0, $arData[4])

	if $lngRow < $lngCells Then $lngCells = $lngRow
	$lngRow = 0
	$strTbl = $conHTML_Tbl_Start

	While $lngRow < $lngCells
		if $lngRow = 0 Then
			$strHtml_Start = $conHTML_hd_Start
			$strHtml_End   = $conHTML_hd_End
		Else
			$strHtml_Start = $conHTML_col_Start
			$strHtml_End   = $conHTML_col_End
		EndIf

		$strTbl = $strTbl & $conHTML_rw_Start
		For $lngCnt = 1 To $lngCols
			$lngRow = $lngRow + 1
			$strTbl = $strTbl & $strHtml_Start & $arData [$lngRow] & $strHtml_End
		Next
		$strTbl = $strTbl & $conHTML_rw_End
	WEnd
	$strTbl = $strTbl & $conHTML_Tbl_End
	Return $strTbl
EndFunc
;--------------------------------------------------------------------------------------------------
Func TxtFormat (ByRef $txt)
	Local $lngPos, $lngEnd;, $lngOcur = 1
	Local $strTbl
	$lngPos = StringInStr ($txt, $pconTblStart, 0, 1)

	While $lngPos <> 0
		$lngEnd = StringInStr ($txt, $pconTblEnd, 0)
		If $lngEnd = 0 Then ExitLoop

		$lngEnd = $lngEnd + StringLen($lngEnd) + 1
		$strTbl = StringMid ($txt, $lngPos, $lngEnd - $lngPos )
		;ConsoleWrite ($strTbl  & @CR)
		;MsgBox 	(0,0, "$lngEnd=" & $lngEnd & " $lngPos=" & $lngPos & StringMid ( $strTbl, Stringlen ($pconTblStart)+1, 2))
		;MsgBox (0,0, StringLeft ($strTbl, 10))
		;MsgBox (0,0, StringRight ($strTbl, 10))
		$strTbl = ExtraTbl ($strTbl)
		;ConsoleWrite ("lngPos=" & $lngPos & " $lngEnd=" & $lngEnd & " len($strTbl)=" & StringLen($strTbl) & @Cr)
			if StringLen ($strTbl) <> 0 Then
				$txt = StringMid ($txt, 1, $lngPos -1) & _
					   $strTbl & _
					   StringMid ($txt, $lngEnd +1, StringLen($txt))
			EndIf

		;---- Reapte
		;$lngOcur = $lngOcur + 1
		;$lngPos = StringInStr ($txt, $pconTblStart, 0, $lngOcur)
		$lngPos = StringInStr ($txt, $pconTblStart, 0, 1, $lngPos +1 )
	WEnd

	$txt = StringReplace ($txt, @LF, @CR)
	$txt = StringReplace ($txt, @CR & @CR, @CR)
	$txt = StringReplace ($txt, @CR, "<br>")
	Return $txt
EndFunc
;----------------------------------------------------------------------------------------------------