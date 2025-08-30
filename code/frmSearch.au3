;--==========  Search Form Golbals

Const $conSearchWinTit = "البحث"

Const $conSearchAll = "كل الكتاب"
Const $conSearchOld = "العهد القديم"
Const $conSearchNew = "العهد الجديد"

Dim $recRecSrch

Dim $lngSearcAct = 0

Dim $strSearchClean

;----------------------------------------
Global $strSearch_txt

Dim $bradAnd, $bradOR, $strSrch_txt;, $bchkShowLink

Const $conAnd = "إبحث عن النص المدخل كقطعة واحدة"
Const $conOR_All = "إبحث  عن النص المدخل بصرف النظر عن ترتيب الكمات" ;   "أى كلمة بالاية" & " " & "يعرض الاية التى يتواجد بها كل كلمات النص المدخل"
Const $conOR ="إبحث عن اى كلمة مفردة فى النص المدخل"
;---------------------------------------------------------------------------------------------------------------------------

Func cmdSearch_Click ()
	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return 1; no search done
	EndIf

	Local $strSelect, $lngNoSearchDone = 1 ; 0=No

	Const $conLeftSide3 =10, $conTopSide3 =10
	;Const $strSearchOne = $avArray [$a_Settings[3]] ;GUICtrlRead ($cmbBible)

	Const $conHelpText = ""; "إدخل النص المطلوب البحث عنة"

	Local $strSearchOne = TabList ();$avArray [ CurBible() ] ;GUICtrlRead ($cmbBible)
	Local $radAnd, $radOR_All, $radOR;, $chkShowLink
	Local $cmbTXTSearch, $data

	Local $cmdCancel, $cmbSearch, $strSrchArea
	Local $msg, $cmdSearch
	Local $GUIWidthSearch = 440
	Local $GUIHeightSearch = 240
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
	;Create window
	$frmSearch = GUICreate($conSearchWinTit, $GUIWidthSearch, $GUIHeightSearch, -1,-1, _
			formStyle (), formExStyle (), $frmMainForm )
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmSearch )

	$cmbTxtSearch = GUICtrlCreateCombo("", $conLeftSide3 + 75 ,$conTopSide3 + 00, 220, 25 +00 )
					;BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST), $WS_EX_ACCEPTFILES)

		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "إكتب النص المراد البحث عنة" & @CR & "لا يفرق بين اشكال الألف و التاء والهاء آخر الكلمة","البحث",1, 1)

		GUICtrlSetData($cmbTxtSearch, $strSelect & "|" & $strSearch_txt , $strSelect)

		GUICtrlCreateLabel ("إبحث عن", $conLeftSide3, $conTopSide3 + 00 , 70, 28, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$cmbSearch = GUICtrlCreateCombo ( "", $conLeftSide3 + 75, $conTopSide3 +35 +00, 125, 25 , _
				BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST, $CBS_DROPDOWNLIST) )

		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetData(-1, $conSearchAll & "|" & $conSearchOld & "|" & $conSearchNew & "|" & $strSearchOne  , $conSearchAll) ; add other item snd set a new default
		GUICtrlSetTip ( -1, "حدد نطاق البحث","البحث",1, 1)

		GUICtrlCreateLabel ("نطاق البحث", $conLeftSide3, $conTopSide3 + 40 +00 , 70, 28, BitOR($ES_RIGHT,$ES_AUTOHSCROLL))
		GUICtrlSetResizing (-1, $GUI_DOCKALL)

	;------
	; GROUP WITH RADIO BUTTONS
	GuiCtrlCreateGroup("اسلوب البحث", $conLeftSide3 + 10 -10 , $conTopSide3 +110-20 , 420, 25*5 )
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radAnd = GUICtrlCreateRadio ($conAnd,  $conLeftSide3 + 10 +0 , $conTopSide3 +110  , 400, 25)
		GuiCtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radOR_All = GUICtrlCreateRadio ($conOR_All,  $conLeftSide3 + 10 +0 , $conTopSide3 + 110 +35  , 400, 25)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$radOR = GUICtrlCreateRadio ($conOR,  $conLeftSide3 + 10 +0 , $conTopSide3 + 110 + 35 + 35 , 400, 25)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	GUICtrlCreateGroup ("",-99,-99,1,1)  ;close group
	;GUICtrlSetState($radAnd, $GUI_CHECKED)
	;------
;	$ChkShowlink = GUICtrlCreateCheckbox ("إعرض رابط لنص الانجيل مع نتائج البحث", $conLeftSide3 + 15 + 0 , $conTopSide3 + 110 + 35 + 35 + 40 , 420, 25)
;		GuiCtrlSetState(-1, $GUI_CHECKED)
;		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$cmdSearch = GUICtrlCreateButton ("إبـدأ البحـث",  $conLeftSide3 +100 + 200 + 15, $conTopSide3 + 00, 100, 30, _
			BitOr($GUI_SS_DEFAULT_BUTTON, $BS_DEFPUSHBUTTON) ); $BS_NOTIFY bitor ($WS_TABSTOP,  $BS_DEFPUSHBUTTON )

		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetTip ( -1, "إضغط لبدأ البحث","البحث",1, 1)

 	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $conLeftSide3 + 100 + 200 + 15, $conTopSide3  + 40 , 100, 30 )
		GUICtrlSetResizing (-1, $GUI_DOCKALL)

;--
	GUISetState(@SW_SHOW)
	GUICtrlSetState ($cmbTxtSearch, $GUI_FOCUS)

	;----

	;	Send ("ا")
	;	MsgBox (0,"testr", ">>>>" & GUICtrlRead ($cmbTxtSearch) & "<<<")
	;	If GUICtrlRead ($cmbTxtSearch) <> "ا" Then
	;		MsgBox (0,0, ">>>>" & GUICtrlRead ($cmbTxtSearch) & "<<<")
	;		Send ( "!{RSHIFT}")
	;	EndIf
	;	GUICtrlSetData ($cmbTxtSearch, "")

	Opt("GUIOnEventMode", 0)

	While 1
		$msg = GUIGetMsg(1)
		Select
;			Case $msg[0] = $cmbTxtSearch
;				ConsoleWrite ("test " & $cmbTxtSearch & "<<<" & @cr)

			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return $lngNoSearchDone
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmSearch)
				;TabSetFous ( $plng_BibleDef )
				frmSearch_Close ()
				Return $lngNoSearchDone

			Case $msg[0] = $cmdSearch
				If GUICtrlRead ( $radAnd ) =  $GUI_CHECKED   Then
					$bradAnd = True
				Else
					$bradAnd = False
				EndIf

				If GUICtrlRead ( $radOR ) =  $GUI_CHECKED  Then
					$bradOR = True
				Else
					$bradOR = False
				EndIf

				$strSrch_txt = GuiCtrlRead ($cmbTxtSearch)
				$strSrchArea = GUICtrlRead ($cmbSearch)
;----
				if 0 = StringCompare ($strSrch_txt, $conHelpText)  Or _
				   3 > StringLen ( $strSrch_txt ) Then
					$lngSearcAct = 0
					;TrayTip ( $gconProgName, "ادخل النص المطلوب البحث عنة", 30 , 2 )
					WrtStatus ( "إدخل النص المطلوب البحث عنة", $pconStatusInfo)

				Else
					If  $plng_SearchDef <> _GUICtrlTab_GetCurFocus ($hTab) Then
						TabSetFous ( $plng_SearchDef )
					EndIf

					;ConsoleWrite ("Progree : " & @HOUR & ":"  & @MIN & ":" & @SEC & ":" & @MSEC & @CR )
					GUIDelete ($frmSearch)
					$frmSearch = 0

					Local $frmProg = cmdProgress_Click ()

					GUISetCursor (15, 1, $frmMainForm); wait hour glass
					GUISetState(@SW_DISABLE, $frmMainForm )
					;TraySetState  ( 2 ); Cansel SLOOOW the search
					;ConsoleWrite ("Search Start : " & @HOUR & ":"  & @MIN & ":" & @SEC & ":" & @MSEC & @CR )

						$strSearch_txt = GetPrevSearch  ( $strSrch_txt )
						$data = SearchInBible ( $strSrch_txt, $strSrchArea, _
							"</span><span class='num'>", "</span><span class='aya'>", "<span class='aya'>", '</span>')

					;ConsoleWrite ("Search Done : " & @HOUR & ":"  & @MIN & ":" & @SEC & ":" & @MSEC & @CR )
					;TraySetState (); show

					GUISetCursor (2, 0, $frmMainForm); ARROW
					GUISetState(@SW_ENABLE, $frmMainForm )

					GUIDelete ($frmProg)
					frmSearch_CLose ()

					$lngNoSearchDone  = 0
					If $data = False Then
							;TrayTip ( $gconProgName,"النص غير موجود فى نطاق البحث المحدد", 30 , 3 )
							Msgbox($conMirrorR2L + 32,$gconProgName, "النص غير موجود فى نطاق البحث المحدد")
							;MsgBox (0,0,$plng_CurrTabNo)
							if  _IEBodyReadHTML($oIESearch) = ""  And $plng_CurrTabNo = $plng_SearchDef Then
								TabSetFous ( $plng_BibleDef )
							EndIf
					EndIf
					$lngUpdateFlag = 1; if the search form is current and prev search is kamos
					Return $lngNoSearchDone
				EndIf

		EndSelect
	WEnd

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SearchInBible ($strSearch, $strSrchArea, _
					$strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 ="" )
	Const $conSQL ="SELECT tblBible.* FROM tblBible  "
	Const $conGateAnd =" And"
	Const $conGateOR =" OR"
	;ConsoleWrite ("Start : " & @HOUR & ":" & @MIN & ":" & @SEC &  ":" & @MSEC & @CR )

	Local $strGate

	Local $lngPos, $strTxtWhere

	Local $strWhere
	Local $strOrderBy = " ORDER BY bibBibleCode, bibChptrNo, bibSectionNo, bibSectionSubNo;"

	$strSearchClean = RemCach ($strSearch)

	Select
		Case $strSrchArea = $conSearchAll
			$strWhere = ""

		Case $strSrchArea = $conSearchOld
			$strWhere = " bibBibleCode < 47  And "

		Case $strSrchArea = $conSearchNew
			$strWhere = " bibBibleCode >= 47 And "

		Case Else
			$strWhere = _ArraySearch($avArray, $strSrchArea, 0, 0, 0, 1) + 0
			;ConsoleWrite ("Bible no." & $strWhere & @CR)
			;$strWhere = CurBible () + 0
			$strWhere = " bibBibleCode = " & $strWhere & " And "
	EndSelect

	; this was cancleed - give user more control
	;$strSearch = StringStripWS ($strSearch, 3); Trim right and left 1+2
	$strSearch = StringStripWS ($strSearch, 4)  ; "  " to " "
	;---
	$strSearch = CleanTxt ($strSearch)

	If $bradAnd = False  Then

		If  $bradOR = True Then
			$strGate = $conGateOR
		Else ; i.e $conOR_All
			$strGate = $conGateAnd
		EndIf

		$strSearch = $strSearch & " "
		$strTxtWhere = ""
		$lngPos = StringInStr ($strSearch, " ")

		While $lngPos > 0
		;   $strTxtWhere = $strTxtWhere & "  OR bibText Like '*" & StringMid ($strSearch, 1, $lngPos -1) & "*' "
			$strTxtWhere = $strTxtWhere & $strGate & " bibText Like '*" & StringMid ($strSearch, 1, $lngPos -1) & "*' "
			;$strSearch = StringTrimLeft ($strSearch, $lngPos)
			$strSearch = StringMid ($strSearch, $lngPos +1, StringLen($strSearch))

			$lngPos = StringInStr ($strSearch, " ")
		WEnd

		$strTxtWhere = StringTrimLeft ($strTxtWhere, StringLen ($strGate)); remove 1st "  OR" "  AND"
	Else
		$strTxtWhere = " bibText Like '*" & $strSearch & "*' "
	EndIf

	$strWhere = " Where " & $strWhere & $strTxtWhere

	;MsgBox (0,"SQL Final" ,$conSQL & $strWhere & $strOrderBy)
	;ConsoleWrite ("SQL-Done : " & @HOUR & ":"  & @MIN & ":" & @SEC & ":" & @MSEC & @CR )
	;$recRecSrch;	=  $objMyDB.OpenRecordset ($conSQL & $strWhere & $strOrderBy)
	If False =  OpenRecordSet ($objMyDB, _
							  $recRecSrch, _
							  $conSQL & $strWhere & $strOrderBy, _
							  "frmSearch: Error 01-Open Rec. set", _
							  $frmSearch)  Then Return ""


	if $recRecSrch.Eof = -1 and $recRecSrch.Bof =-1 Then
		;$recRecSrch.Close
		$lngSearcAct = -1
		Return False
	EndIf
	;ConsoleWrite ("Rec-Read : " & @HOUR & ":" & @MIN & ":" & @SEC & ":" & @MSEC & @CR )

	$recRecSrch.MoveFirst
	UpdateLst ($recRecSrch, $strSrchArea, $strHTML_Num1, $strHTML_Num2, $strHTML_aya1, $strHTML_aya2 )
	Return True
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func UpdateLst (ByRef $recRecSrch, $strSrchArea, _
				$strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 ="" )
	;local $strStyleSup = BitXOR( 0xFFFFFF, dec(StringRight("000000" & hex($pstrDispColorbk),6)))
	Local $lngPos, $strTxtWhere
	Local $lngBible, $msg
	local $lngSerial = 0, $lngOldBible = 0

	Local  $sStyle = '<html><head>' & _
					'<style type="text/css">' & _
					'span.aya {' & _
							GetHTML_Style ( $as_SysFont [ $conFSrchAya ]) & _
							'line-height: 2;' & _
							'text-indent: -80;' & _
						'}' & _
						'span.title {' & _
							GetHTML_Style ( $as_SysFont [ $conFSrchTitle ]) & _
							'line-height: 2;' & _
							'text-indent: 1;' & _
						'}' & _
						'span.FoundAya {' & _
							GetHTML_Style ( $as_SysFont [ $conFSrchFoundAya ]) & _
							'line-height: 1.0;' & _
							'text-indent: 1;' & _
						'}' & _
						'span.adrs {' & _
							GetHTML_Style ( $as_SysFont [ $conFSrchAdrs ]) & _
							'text-indent: -80;' & _
							'Cursor:Pointer;' & _
						'}' & _
					'</style></head>'

	;Local $sStyle2 = '</body></html>'
	Local $sBody = '<body  dir="rtl" bgcolor="#' & StringRight("000000" & hex($as_BKColor[2] + 0 ),6) & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 120; margin-left: 30; margin-top: 10; margin-bottom: 10"' & _
					'; oncontextmenu="return false" >' & _   ; oncontextmenu="return false"
					'<Input type="hidden" Name="' & $conSrchHTML_Txt & '">'

	Local $oBody
	Local $AllWord

	Local $iDone, $iAll_Rec, $lngProg, $lngTemp

	if $bradAnd = True  Then
		$AllWord = 1
	Else
		$AllWord = 0
	EndIf

	_IEDocWriteHTML ($oIESearch, $sStyle & $sBody & $conEndHTML)
	_IEAction ($oIESearch, "refresh")

	$oBody = _IETagNameGetCollection($oIESearch, "body", 0)

    if $recRecSrch.Eof = -1 and $recRecSrch.Bof =-1 Then
		_IEDocInsertHTML($oBody, $conEndHTML)
		Return ""
	EndIf

;----
	GUICtrlSetData ($hProg, 0)
	GUICtrlSetState ($hProg, $GUI_SHOW)
;----

	_IEDocInsertHTML ($oBody, "<hr><pre>" )
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "البحث عن النـص" & ": ('" & $strSrch_txt  & "')<span><br>")
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "نطــاق البحــث" & ": " & $strSrchArea  & "<span><br>")

	if $bradAnd = True  then
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "اسلـوب البحــث" & ": " & $conAND  & "<span><br>")
	ElseIf  $bradOR = False then
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "اسلـوب البحــث" & ": " & $conOR_All  & "<span><br>")
	Else
		_IEDocInsertHTML ($oBody, "<span class='title'>" & "اسلـوب البحــث" & ": " & $conOR  & "<span><br>")
	EndIf

	_IEDocInsertHTML ($oBody, "<pre>" ) ; <hr>


	$strTxtWhere = ""

	With $recRecSrch
		$iAll_Rec = .RecordCount ()

		$iDone = -1
		;.MoveFirst
		While 1
			$lngSerial = $lngSerial + 1
			$iDone = $iDone + 1
			$lngBible =	.Fields("bibBibleCode").Value
			if $lngBible < 0 and $lngBible >= UBound($avArray)  Then
					Msgbox ($conMirrorR2L + 16, $gconProgName, "frmSearch: Error 01-No data file, no bible with the given code",0, $frmSearch)
				_IEDocInsertHTML($oBody, $conEndHTML)
				Return ""
			EndIf

			$strTxtWhere = _
				GetAyaSearch ($lngBible, .Fields('bibChptrNo').Value + 0, .Fields('bibSectionNo').Value + 0, $AllWord, _
							  $strHTML_Num1, $strHTML_Num2, $strHTML_aya1, $strHTML_aya2, $lngSerial )

			if $lngOldBible <> $lngBible Then
					_IEDocInsertHTML($oBody, "<hr>")
					$lngOldBible = $lngBible
			EndIf

			_IEDocInsertHTML($oBody,  $strTxtWhere)

				;ConsoleWrite ($strTxtWhere & @CR)
			.MoveNext
			$lngPos = $lngPos + 1
			if  .Eof <> -1 Then
				$lngSearcAct =1
			EndIf

			if (.Eof = -1)  Then
				ExitLoop
			EndIf
			$lngTemp = Int($iDone / $iAll_Rec *100)

			$msg = GUIGetMsg ()
			if  $msg = $cmdOK_Stop or $msg = $GUI_EVENT_CLOSE Then
				$lngTemp = 200
			EndIf

			If $lngTemp <> $lngProg Then
				$lngProg = $lngTemp

				GUICtrlSetData ($hProg, $lngProg)
				If $lngtemp >= 100 Then ExitLoop

				;ProgressSet( $lngProg, $lngProg & " % أنتهى")
			EndIf

		WEnd

	EndWith
	if $lngtemp > 100 Then
		;TrayTip ( $gconProgName, "تم إيقاف البحث", 30 , 1 )
		WrtStatus ( "إيقاف البحث، تم سرد " & "  " & Num2India($lngSerial) & " من " & Num2India ($iAll_Rec) & " أية", $pconStatusInfo)

		_IEDocInsertHTML ($oBody, "<hr><br><span class='title'>" &  "تم إيقاف عملية البحث - تم سرد عدد " & "  " & Num2India($lngSerial) & "   من إجمالى  " & Num2India ($iAll_Rec) & " أية" & "<span>")
	Else
		_IEDocInsertHTML ($oBody, "<hr><br><span class='title'>" &  "إجمالى عدد الايات المسردة: " & Num2India ($iAll_Rec) & " أية" & "<span>")
	EndIf

	_IEDocInsertHTML($oBody, $conEndHTML)
;=========
	GUICtrlSetData ($hProg, 100)
	;Sleep(500)
	GUICtrlSetState ($hProg, $GUI_HIDE)
	GUICtrlSetState ($cmdOK_Stop, $GUI_HIDE)
EndFunc

;--=========== Func to combine it back to string ----------------------------------------------------------
Func GetAyaSearch ($lngBible, $lngChptr, $lngNo,  $AllWords=0, _
				  $strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 ="", $lngNu = 0)

	Local $Aya = GetOneAya ($lngBible, $lngChptr, $lngNo, 1, 1, $strSearchClean,  $AllWords, _
							$strHTML_Num1, $strHTML_Num2, $strHTML_aya1, $strHTML_aya2 )
	Local $strAdd = _
			$avArray[$lngBible] & " " & _
			Num2India($lngChptr) & ":" & _
			$R2L & Num2India($lngNo)
	Local $strFeedBack

	;$Aya = WordClr ($Aya, RemCash($Aya),
	;Global const $conSrchHTML_OnClick = "OnClick="  vbscript:" & $conSrchHTML_Txt & "."
	; xxYYYzzzz
	; xx Bible No. YYY Chptr zzzz Aya No.
	if $lngNu > 0 then $strFeedBack = Num2India ($lngNu) & ") "

	$strFeedBack = '<p> ' & _
			'<span class="adrs" ' & _
				$conSrchHTML_OnClick & 'vbscript:' & $conSrchHTML_Txt & '.Value="' & $conSrchFlag & BAdrs2Hex ($lngBible, $lngChptr, $lngNo, $lngNo, $lngNo) & '"' & _
				'>' & _
				$strFeedBack & $strAdd & _
			'</span>' & " "  & _
			'<span class="aya">'  & $Aya   & '</span>' & _
			'</p>'

	Return 	$strFeedBack

EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func frmSearch_Close ()
	;	$lngExtraFormOpen = BitAND (255-$lngFrmSearchID, $lngExtraFormOpen); make the second bit 1
	IF IsPtr ( $frmSearch ) Then
		GUIDelete($frmSearch)
		$frmSearch = 0
	EndIf

	if IsObj($recRecSrch) then
		$recRecSrch.Close
		$recRecSrch = 0
	EndIf

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
; #FUNCTION# ====================================================================================================
; Name...........: GetPrevSearch
; Description ...: Adds a search item to array max 250 char only
; Syntax.........: GetPrevSearch ( $str = "")
; Parameters ....: $str  - str to add
;
; Return values .: if str ="" retrun the list
;                 if str = some value, add to Array
; Author ........: Hnry
; Remarks .......:
; Related .......: _IniWriteEx
; ====================================================================================================
Func GetPrevSearch ( $str = "")
	Local $nPos, $strSearch_temp, $nPos2
	if $str = "" Then Return $strSearch_txt

	$nPos =  StringInStr ($strSearch_txt, $str, 2)
;ConsoleWrite ("nPos=" & $nPos & @cr)

	if $nPos <> 0  Then
		$strSearch_temp = StringMid ($strSearch_txt, $nPos , Stringlen($strSearch_txt) )
;ConsoleWrite ("$strSearch_temp =" & $strSearch_temp & @CR)

		$nPos2 = StringInStr ($strSearch_temp, "|" , 2  )
;ConsoleWrite ("nPos2=" & $nPos2 & @cr)

		if $nPos2 >  0 then
			$strSearch_temp = StringMid ( $strSearch_temp, $nPos2 +1, Stringlen($strSearch_temp) )
;ConsoleWrite ("$strSearch_temp =" & $strSearch_temp & @CR)
		Else
			$strSearch_temp = ""
		EndIf
;MsgBox (0,"", $strSearch_temp)
		$strSearch_txt = StringMid ( $strSearch_txt, 1, $nPos -1) &  $strSearch_temp
		if $nPos = 1 then $strSearch_txt = $strSearch_temp
		;Return $strSearch_txt
	EndIf
;msgbox (0,"", $strSearch_txt & "<   >" & $str )

	$strSearch_temp = $str & "|" & $strSearch_txt
	if stringlen($strSearch_temp) > 250 Then
		$strSearch_temp = StringLeft ( $strSearch_temp, 250)
		$nPos = StringInStr ( $strSearch_temp, "|", 2, -1)
		$strSearch_temp = StringLeft ($strSearch_temp, $nPos -1)
	EndIf

;	if StringRight ($strSearch_temp,1 ) = "|" Then
;		$strSearch_temp = StringTrimRight ($strSearch_temp,1)
;	EndIf
	Return $strSearch_temp
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func cmdProgress_Click ()
	Local $frmProg
	Local $conProgWinTit = "تقدم البحث"
	Local $GUIWidthProg = 500, $GUIHeightProg =90

	$frmProg = GUICreate($conProgWinTit, $GUIWidthProg, $GUIHeightProg, -1,-1, _
			$WS_EX_DLGMODALFRAME, formExStyle () , $frmMainForm)

		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmProg )

	$hProg = GUICtrlCreateProgress ( 5, 13, $GUIWidthProg  -120, 15, $PBS_SMOOTH)

		;GUICtrlSetState ($hProg, $GUI_FOCUS) ; to give ability to use key  Esc etc...
		;GUICtrlSetState ($hProg, $GUI_HIDE)
		;GUICtrlSetState ($hProg, $GUI_SHow)
		GUICtrlSetData ($hProg, 0)

	$cmdOK_Stop = GUICtrlCreateButton("إيقاف البحث",$GUIWidthProg -105 , 10 , 100, 30 )
		GUICtrlSetState ($cmdOK_Stop, $GUI_DEFBUTTON)

	GUISetState(@SW_SHOW)

	Return $frmProg
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func RemUniCode ($str)
	Local  $strClean , $ch,$iCount
	$str = StringReplace ($str, "،","")
	$str = StringReplace ($str, "؟","")
	$str = StringReplace ($str, ":","")
	$str = StringReplace ($str, ".","")
	$str = StringReplace ($str, '"','')

	For  $iCount=1 to StringLen ($str)
		$ch = StringMid ($str, $iCount, 1)

		if (Asc($ch) <> AscW($ch)) or (Asc ($ch) = 32)  Then
;MsgBox (0,$ch, 	Asc ($ch))
			$strClean &= $ch
		Endif
	Next

	Return $strClean
EndFunc
