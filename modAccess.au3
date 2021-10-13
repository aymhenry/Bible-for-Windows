;---------------------------------------------------------------------------------------------------------
;		MS-Access Modules
;====================================================
; Author:         "Ayman Henry"

;---------------------------------------------------------------------------------------------------------
Func OpenDBSystem ()
	;---- Access Data Base
	;OpenDatabase (dbname, options, read-only, connect)
_OnError (True)
    $objDBS = ObjCreate("DAO.DBEngine.36")
	;$objMyDB = $objDBS.OpenDatabase (@ScriptDir & "\" & $gconDB_Main,True, True, ";pwd=" & $conSysPassWord)
	$objMyDB = $objDBS.OpenDatabase ( FolderFileName ($gconDB_Main),True, True, ";pwd=" & $conSysPassWord)
_OnError (False)
	If _Error() Then
		MsgBox (16 + 0x40000 , $gconProgName, "modAccess: Error 09-Open main file :"  & $gconDB_Main, 0, $frmMainForm)
		Return
	EndIf

EndFunc
;---------------------------------------------------------------------------------------------------------
Func Shutdwn ()
	;$recRecset.Close
	$objMyDB.Close
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ChptrRead ($strBibleNumber, $lngChptrNo, $lngAyaFrom, $lngAyaTo, $lngAdd, _
				$strHTML_Num="", $strHTML_aya="", _
				$strHtmlAdd1="", $strHtmlAdd2="" )
	const $conSpanClose ="</span>"
	Local $strSQL
			If (0 + $strBibleNumber = 0)  or (0+$lngChptrNo=0)  or $strBibleNumber > $conItem then
					MsgBox ( 16 + 0x40000 , $gconProgName,"modAccess: Error 01-Access Bible " & $strBibleNumber & "- chptr " & $lngChptrNo )
					$strBibleNumber = $conStartID
					$lngChptrNo = 1
			endif
		;SELECT tblBible.*, tblHeaders.hedHeaderMain, tblHeaders.hedHeaderSub
		;FROM tblBible LEFT JOIN tblHeaders ON (tblBible.bibSectionNo = tblHeaders.hedSectionNo) AND (tblBible.bibChptrNo = tblHeaders.hedChptrNo) AND (tblBible.bibBibleCode = tblHeaders.hedBibleCode);
	if CurAdd() = 0 then ; without add
			$strSQL ="Select * From tblBible "  ; & $conTable
	Else
			$strSQL ="SELECT tblBible.*, hedHeaderMain, hedHeaderSub FROM tblBible " & _
						   "LEFT JOIN tblHeaders ON (tblBible.bibSectionNo = tblHeaders.hedSectionNo) AND (tblBible.bibChptrNo = tblHeaders.hedChptrNo) AND (tblBible.bibBibleCode = tblHeaders.hedBibleCode) "
	EndIf

	Local $strWhree =  " Where (bibBibleCode =" & $strBibleNumber & " And bibChptrNo = " & $lngChptrNo & ") " & _
						"And (bibSectionNo>=" & $lngAyaFrom  & ") " & _
						"And ((bibSectionNo-"  & $lngAyaTo & ")<=0) "
						;"And (bibSectionNo<="  & $lngAyaTo & ")"

	Local $strOrderBy = " ORDER BY bibSectionNo, bibSectionSubNo;"

	Local $strChptrText
	Local $strSectionSubNo, $strSectionNo
	Local $strCont, $strStart
	Local $strSym_Start
	Local $strHeaderMain, $StrHeaderSub, $strHeader, $bHeaderFound = 0

	Local $strTach, $strText
	;msgbox (0,"", $conSQL & $strWhree & $strOrderBy)

	;$recRecset	=  $objMyDB.OpenRecordset ($conSQL & $strWhree & $strOrderBy)
	If False =  OpenRecordSet ($objMyDB, _
							  $recRecset, _
							  $strSQL & $strWhree & $strOrderBy, _
							  "modAccess: Error 05-Open Rec. set", _
							  $frmMainForm)  Then Return ""

	if $recRecset.Eof = -1 and $recRecset.Bof =-1 Then
		$recRecset.Close
		Return ""
	EndIf

	$strChptrText = ""

	With $recRecset
		.MoveLast
		.MoveFirst

		if CurCont ()= 0 	then ; sep pharagraphs $a_Settings [0]; Cont = NO=0
			$strSym_Start =   $RlE
			$strCont =  "<br>" & $PDF
		Else
			$strSym_Start = "" ;$strHTML_aya
			$strCont = $R2L & "";$conSpanClose
		endif

		While .Eof <> -1
			if CurAdd() =1 Then ; with header
				$strHeaderSub = .Fields("hedHeaderSub").Value
				if $strHeaderSub = "" Then
					$bHeaderFound = 0
				Else
					$strHeaderMain = .Fields("hedHeaderMain").Value
					$bHeaderFound = 1
				EndIf
			Else
				$bHeaderFound =0
			EndIf

			$strSectionSubNo = .Fields("bibSectionSubNo").Value + 0
			if $strSectionSubNo = 1 Then
				if $bHeaderFound = 1 Then
					$strHeader =  "<br>" & $strHtmlAdd2 & Num2India ($strHeaderSub) & $conSpanClose & "<br>"
					if $strHeaderMain <> "" Then
						$strHeader =  "<br>" &  $strHtmlAdd1 & Num2India ($strHeaderMain) & $conSpanClose &  $strHeader
					endif
				Else
					$strHeader = ""
				EndIf

				if CurNum () = 1	then ; num $a_Settings [1] ; with num
					$strSectionNo = .Fields("bibSectionNo").Value
					;$strStart = $strSym_Start &  "<sup>"  & Num2India($strSectionNo) & "</sup>"
					$strStart = $strHeader & $strSym_Start & $conSpanClose & $strHTML_Num  & Num2India ( $strSectionNo ) & $conSpanClose & $strHTML_aya
				Else
					$strStart = $strHeader
				endif
			Else
				$strStart = ""
				$strChptrText = StringTrimRight ( $strChptrText, StringLen($strCont)); REMOVE @lf and $pdf OR " " & $pdf
			EndIf

			$strTach = .Fields("bibTach").Value
			$strText = .Fields("bibText").Value

			if CurTach () = 0 	then ; without tach $a_Settings [2]
				$strChptrText =  $strChptrText & $strStart & $strText & $strCont
			Else
				$strChptrText = $strChptrText  &  $strStart & TextComb ($strText, $strTach) & $strCont ;& $PDF
			EndIf

			.MoveNext
		WEnd
		WrtStatus ("", $pconStatusInfo)

	;	if CurTach ()= 1 And  $strTach = "" then ; without tach  $a_Settings [2]
	;		WrtStatus ($conSatusTash, $pconStatusInfo)
	;	EndIf

	EndWith

	$recRecset.Close
	if StringLower (StringLeft($strChptrText, 4)) ="<br>" Then
		$strChptrText = Stringmid ($strChptrText,5)
	EndIf

	Return  $strHTML_aya & $strChptrText & $conSpanClose
EndFunc
;---------------------------------------------------------------------------------------------------------
Func WordsRead($strBibleNumber, $lngChptrNo, $bNumbers, $lngAyaFrom, $lngAyaTo, _
			   $strHTML_wrdhead="", $strHTML_wrd="", $strHTML_num="" )
	Const $conTable2 = "tblWords"
	Const $conSQL ="Select * From " & $conTable2

	Local $strWhree =  " Where (wrdBibleCode =" & $strBibleNumber & " And wrdChptrNo = " & $lngChptrNo & ") "
	Local $strOrderBy = " ORDER BY wrdSectionNo;"
	Local $strWords = ""

	;Local $strColor = "#" & StringRight(Hex(BitXOR(0xFFFFFF, $pstrDispColorBk)),6)
	;Local $strSyle = '<Div style ="font-family:' &$conDefDispFontName & ';color:' & $strColor & ';font-size:18pt;">'

	if $bNumbers <> -1 Then
		$strWhree &= " And wrdSectionNo =" & $bNumbers
	Else
		$strWhree &= " And (wrdSectionNo >=" & $lngAyaFrom  & ") And (wrdSectionNo <="  & $lngAyaTo & ") "
	EndIf

	;$recRecset	=  $objMyDB.OpenRecordset ($conSQL & $strWhree & $strOrderBy)
	If False =  OpenRecordSet ($objMyDB, _
							  $recRecset, _
							  $conSQL & $strWhree & $strOrderBy, _
							  "modAccess: Error 06-Open Rec. set", _
							  $frmMainForm)  Then Return ""



	If $recRecset.Eof = -1 and $recRecset.Bof =-1 Then
		$recRecset.Close
		Return ""
	EndIf


    $strWords = "" ;$strHTML_wrd1

	With $recRecset
		.MoveLast
		.MoveFirst
		While not .Eof = -1

			$strWords &= $strHTML_num & Num2India(.Fields("wrdSectionNo").Value) & "</span>" & " "   & _
						 $strHTML_wrdhead & Num2India(.Fields("wrdWord").Value)  & "</span>"
			$strWords &= $strHTML_wrd & " : " & ConvNum (.Fields("wrdText").Value ) & "<br>" & "</span>"

			.MoveNext
		WEnd
	EndWith
	;$strWords &= "</div>"

	$recRecset.Close
	$recRecset = 0
	Return $strWords
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ConvNum ( $str)
	Local $lngCnt
	For $lngCnt =0 to 9
		$str = StringReplace ( $str, $lngCnt & "" , Num2India($lngCnt) )
		;MsgBox (0, $lngCnt, 		$str)
	next
	Return $str

EndFunc
;---------------------------------------------------------------------------------------------------------
Func GetOneAya ($lngBible, $lngChptr, $lngNo, _
				$bNumbers = 0,    $bTach = 0,       $strHiWords = "", $AllWords=0, _
				$strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 ="", $lngAyaTo = Default)

	If $lngAyaTo = Default then $lngAyaTo = $lngNo

	Local $strAya, $strTach
	Local $StrSQL = "SELECT tblBible.* FROM tblBible " & _
					" WHERE (bibBibleCode = " & $lngBible  & ")" & _
					" And (bibChptrNo = " & $lngChptr  & ")" & _
					" And (bibSectionNo <= " & $lngNo  & ") " & _
					" And (bibSectionNo >= " & $lngAyaTo  & ") " & _
					" Order by tblBible.bibSectionSubNo;"

	;Local $recRecAya =  $objMyDB.OpenRecordset ($strSQL)
	Local $recRecAya
	If False =  OpenRecordSet ($objMyDB, _
							  $recRecAya, _
							  $strSQL, _
							  "modAccess: Error 07-Open Rec. set", _
							  $frmMainForm)  Then Return ""

	if $recRecAya.RecordCount = 0 Then
		$recRecAya.Close
		if $lngNo = 1 Then
			MsgBox ( 16 +0x40000 , $gconProgName,"modAccess: Error 03- Internal Error GetAya")
		Else
			Return GetAya ($lngBible, $lngChptr, 1, $bNumbers , $bTach,  _
						   $strHTML_Num1, $strHTML_Num2, $strHTML_aya1, $strHTML_aya2 )
		EndIf
		;Return ""
	EndIf

	if $bTach = 1 then ; if Tach
		$strTach = $recRecAya.Fields("bibTach").Value
		if $strHiWords = "" then
			$strAya = TextComb ($recRecAya.Fields("bibText").Value, $strTach)
		Else
			$strAya = WordClr ($recRecAya.Fields("bibText").Value, $strTach, $strHiWords, $AllWords)
		EndIf
	Else
		if $strHiWords = "" then
			$strAya = $recRecAya.Fields("bibText").Value
		Else
			$strAya = WordClr ($recRecAya.Fields("bibText").Value, "", $strHiWords)
		EndIf
	EndIf

	$recRecAya.MoveNext

	If $recRecAya.EOF <> -1 Then
		;$strAya = $strAya & TextComb (ASc2UNi($recRecAya.Fields(4).Value), $recRecAya.Fields(5).Value)
		if $bTach = 0 then
			$strAya = $strAya & TextComb ($recRecAya.Fields("bibText").Value, $recRecAya.Fields("bibTach").Value)
		Else
			$strAya = $strAya & $recRecAya.Fields("bibText").Value
		EndIf
	EndIf

	$recRecAya.Close
		WrtStatus ("",$pconStatusInfo)

		;if CurTach () = 1 	then ; with tach  $a_Settings [2]
		;if $bTach = 1 	then ; with tach  $a_Settings [2]
		;	WrtStatus ("",$pconStatusInfo)
		;Else
		;	if $plng_CurrTabNo <> $plng_SearchDef And $strTach = "" then
		;		WrtStatus ($conSatusTash, $pconStatusInfo)
		;	Else
		;		 WrtStatus ("",$pconStatusInfo)
		;	EndIf
		;EndIf

	If $bNumbers = 0	then ; num
		$strAya =  $strHTML_Num1  & Num2India($lngNo) & $strHTML_Num2  & $R2L & $strAya
	endif
	Return $strHTML_aya1 & $strAya & $strHTML_aya2
EndFunc
;---------------------------------------------------------------------------------------------------------
Func WordClr ($strText, $strTach, $Words, $AllWords = 0)
	Const $conZWJ = ChrW (0x200D)
	Const $conFlag = "#"
	Local $lngLen
	Local $strFlag = "", $lngPos, $strCH, $lngPos2
	Local $a_Words
	Local $lngMax
	Local $lngCnt
	Local $strTextClean  = RemCach ($strText)
	Local $strWordsClean = RemCach ($Words &  " ")
	Local $strCH_After

	Const $conTagStart = '</span><span class="FoundAya">' ;'<b><u>'
	Const $conTagEnd = '</span><span class="Aya">' ;'</u></b>'

	;MsgBox (0,"", $strText & " "  & "  " &  $Words & "  " &  $AllWords )

	$Words = StringStripWS ( $Words ,3)
	$strWordsClean = StringStripWS ( $strWordsClean ,3)

	If $AllWords = 0 Then
		$a_Words = StringSplit ($strWordsClean, " ",1)
		$lngMax = UBound ($a_Words) - 1
		;_ArrayDisplay ($a_Words)
	Else
		$a_Words = StringSplit ($strWordsClean, $conFlag,1); any non exist char ! one word
		$lngMax = 1
	EndIf

	;MsgBox (0,$lngMax, $strWordsClean & " " & $strWordsClean & @crlf & $strTextClean &  @CRLF & " " & $strText)
	;_ArrayDisplay ($a_Words)

	for $lngCnt = 1 to $lngMax ; no of words
		$lngPos = StringInStr ($strTextClean, $a_Words[$lngCnt]) ; pos
		while $lngPos > 0
			$lngLen = StringLen ($a_Words[$lngCnt])
			if $lngLen  > 1 Then
				$strFlag = $strFlag & StringRight ("000" & $lngPos,3) & StringMid ($strText, $lngPos,1) & StringMid ($strText, $lngLen + $lngPos -1,1) & " "

				$strTextClean = StringMid ($strTextClean, 1, $lngPos -1)  & $conFlag & StringMid ($strTextClean, $lngPos +1, StringLen ($strTextClean) )
				$strTextClean = StringMid ($strTextClean, 1, $lngLen + $lngPos -2)  & $conFlag & StringMid ($strTextClean, $lngLen + $lngPos , StringLen ($strTextClean) )

				$strText = StringMid ($strText, 1, $lngPos -1)  & $conFlag & StringMid ($strText, $lngPos +1, StringLen ($strText) )
				$strText = StringMid ($strText, 1, $lngLen + $lngPos -2)  & $conFlag & StringMid ($strText, $lngLen + $lngPos , StringLen ($strText) )

			EndIf
			$lngPos = StringInStr ($strTextClean, $a_Words[$lngCnt], 2, 1, $lngLen + $lngPos + 2 ) ; pos
		wend

	Next

	$strText = TextComb ($strText, $strTach)
	;== fix text

	;MsgBox (0,"", $strFlag)

	$a_Words = StringSplit ($strFlag, " ",1)

	 _ArraySort ($a_Words)
	;_ArrayDisplay ($a_Words)

	$lngPos = StringInStr ($strText, $conFlag) ; pos

	$lngCnt = 1
	While $lngCnt < UBound ($a_Words) -1
		$strCH  = $conZWJ & $conTagStart & StringMid ($a_Words[$lngCnt], 4, 1)
		;MsgBox (0, "inner", StringMid ($a_Words[$lngCnt], 4, 1))

		$strText = StringMid ($strText, 1, $lngPos -1)  & $strCH & StringMid ($strText, $lngPos +1, StringLen ($strText) )
		$lngPos2 = StringInStr ($strText, $conFlag, 2, 1, $lngPos + StringLen($strCH)) ; pos
		;MsgBox (0,1, $strText)

		$strCH_After = StringMid ($strText,  $lngPos2 +1, 1)

		If (Ascw ($strCH_After) = Asc ($strCH_After))  or (AScw($strCH_After) < 0x0620) or (AScw($strCH_After) > 0x064A) Then
			$strCH_After = $conTagEnd
		Else
			$strCH_After = $conZWJ & $conTagEnd
		EndIf

		If $lngPos2 = 0 then
			$strText &= $strText &  $conTagEnd
		Else
			$strText = StringMid ($strText, 1, $lngPos2 -1)  &  _
				StringRight ($a_Words[$lngCnt], 1) & _
				$strCH_After & _
				StringMid ($strText, $lngPos2 +1, StringLen ($strText) )
		EndIf

		$lngPos = StringInStr ($strText, $conFlag, 2, 1, $lngPos + 1) ; pos
		$lngCnt = $lngCnt + 1
		;MsgBox (0,2, $strText)
	WEnd
	;msgbox ($conMirrorR2L,"", $strTextClean & @CR & @CR & $strText)

	Return $strText
EndFunc
;---------------------------------------------------------------------------------------------------------
Func CalcMaxAya2Chpt ($lngBible = 1, $lngChapter = 1)
	Local $lngNumber, $recRecset, $strSQL
	$lngBible =	$lngBible + 0
	$lngChapter = $lngChapter + 0

	$strSQL = "SELECT Max(bibSectionNo) AS MaxOfbibSectionNo FROM tblBible " & _
					"GROUP BY bibBibleCode, bibChptrNo " & _
					"HAVING ((bibBibleCode=" & $lngBible & ") AND (bibChptrNo)=" & $lngChapter & ");"

	if $lngBible = 0 or $lngChapter = 0 Then
			MsgBox ($conMirrorR2L + 16, $gconProgName,"modAccess: Error 04-Call Bad parameters " & $lngBible & "-" & $lngChapter  )
			Return 0
	EndIf

	;	$recRecset =  $objMyDB.OpenRecordset ($strSQL)
	If False =  OpenRecordSet ($objMyDB, _
						  $recRecset, _
						  $strSQL, _
						  "modAccess: Error 08-Max Aya", _
						  $frmMainForm)  Then Return ""

	if $recRecset.Eof = -1 and $recRecset.Bof =-1 Then
		MsgBox (0x40000 + 16, $gconProgName,"modAccess: Error 02 -Access-MaxAya " & $lngBible & "- chptr " & $lngChapter )
		$lngNumber = 0
	Else
		$lngNumber = $recRecset.Fields(0).Value + 0
	EndIf

	$recRecset.Close
	$recRecset = 0
	Return $lngNumber
EndFunc
;---------------------------------------------------------------------------------------------------------
Func OpenRecordSet ( Byref $objDB, ByRef $recR, $strSQL, $strErrMsg, ByRef $myForm )

	_OnError(True)
		$recR = $objDB.OpenRecordset ($strSQL)
	_OnError(False)

	If _Error() Then
		MsgBox (16 + 0x40000 + 0x80000, $gconProgName, $strErrMsg , 0, $myForm)
		Return False
	Else
		Return True
	EndIf
EndFunc
