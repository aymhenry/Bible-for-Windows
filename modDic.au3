;---------------------------------------------------------------------------------------------------------------------------
Func GetShAya ($lngBible, $lngChptr, $lngNo, $lngAyaTo = Default, $lngShort= Default, $strSep = " ")
	If $lngAyaTo = Default then $lngAyaTo = $lngNo
	If $lngShort = Default then $lngShort = 120

	; sh2 will work on bible IDs
	Local $strAya, $strAdd, $strRest = ""
	Local $StrSQL = "SELECT tblBible.* FROM tblBible " & _
					" WHERE (bibBibleCode = " & $lngBible  & ")" & _
					" And (bibChptrNo = " & $lngChptr  & ")" & _
					" And (bibSectionNo >= " & $lngNo  & ") " & _
					" And (bibSectionNo <= " & $lngAyaTo  & ") " & _
					" Order by bibSectionNo, bibSectionSubNo;"

	;Local $recRecAya =  $objMyDB.OpenRecordset ($strSQL)
	Local $recRecAya
	If False =  OpenRecordSet ($objMyDB, _
							  $recRecAya, _
							  $strSQL, _
							  "modDic: Error 01-Open Rec. set", _
							  $frmMainForm)  Then Return ""


		if $recRecAya.RecordCount = 0 Then

			$recRecAya.Close
			Return ""
		EndIf


		$strAdd = $acShort [$lngBible] & " " & Num2India ($lngChptr) & " : " & Num2India ($lngNo)
		if $lngAyaTo <> $lngNo then $strAdd = $strADD & "-" & Num2India ($lngAyaTo)

		While $recRecAya.Eof <> -1
			$strAya = $strAya & " " & TextComb ($recRecAya.Fields("bibText").Value,  $recRecAya.Fields("bibTach").Value)
			if $lngShort <> 0 Then
				ExitLoop
			else
				$recRecAya.MoveNext
			EndIf
		WEnd

	$recRecAya.Close

	if StringLen ($strAya) > $lngShort  And $lngShort <> 0 then $strRest = " ..."
	$strAya = StringMid ($strAya,1, $lngShort) & $strRest

	If $strSep = " " Then Return $strAya

	$strAya = StringLeft($strAdd & "                    ", 15) & $strSep & $strAya

	Return $strAya
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func GetShahd ($lngBible, $lngChptr, $lngNo)
	Local $objMyDB2
	Local $lngB, $LngCh, $lngAyF, $LngAyT
	const $conTit2 = "الشواهد:"
	Local $strAya
	Local $strDB_App
	Local $strAyaHTML, $OneAya
;MsgBox (0,"", $lngBible)
	$lngBible = ConvKat2Dic ($lngBible, $lngChptr, $lngNo)
;MsgBox (0,"", $lngBible)

	;If FileExists (@ScriptDir & "\" & $gconDB_App) = 0 Then
	$strDB_App = FolderFileName ($gconDB_App)

	If $strDB_App = "" Then
		WrtStatus ("ملف غير موجود :" & $gconDB_App, $pconStatusInfo )
		Return ""
	EndIf

	_OnError(True)
		;$objMyDB2 = $objDBS.OpenDatabase (@ScriptDir & "\" & $gconDB_App, True, True, ";pwd=" & $conSysPassWord)
		$objMyDB2 = $objDBS.OpenDatabase ($strDB_App , True, True, ";pwd=" & $conSysPassWord)
	_OnError(False)

	If _Error() Then
		WrtStatus ("خطأ فى قراءة ملف :" & $gconDB_App, $pconStatusInfo )
		Return ""
	EndIf

	;SELECT dicBible, dicChapter, dicStart, dicEnd, sh2Bible, sh2Chptr, sh2AddFrom, sh2AddTo
	;FROM tblShahd2 INNER JOIN tblMainBook ON tblShahd2.sh2VersID = tblMainBook.dicShahed;

	Local $StrSQL = "SELECT dicBible, dicChapter, dicStart, dicEnd, sh2Bible, sh2Chptr, sh2AddFrom, sh2AddTo " & _
					"FROM tblShahd2 INNER JOIN tblMainBook ON tblShahd2.sh2VersID = tblMainBook.dicShahed " & _
					" WHERE (dicBible = " & $lngBible  & ")" & _
					" And (dicChapter = " & $lngChptr  & ")" & _
					" And (dicStart >= " & $lngNo  & ") " & _
					" And (dicEnd <= " & $lngNo  & ") "

	Local $recRecAya; =  $objMyDB2.OpenRecordset ($strSQL)
	If False =  OpenRecordSet ($objMyDB2, _
							  $recRecAya, _
							  $strSQL, _
							  "modDic: Error 02-Open Rec. set", _
							  $frmMainForm)  Then Return ""

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

			if $lngB +0 >0 then
				if $lngAyF	= $lngAyT then
					$OneAya = $lngAyF
				Else
					$OneAya = 0
				EndIf

				$strAyaHTML ='<span class="adrs" ' & _
								$conSrchHTML_OnClick & 'vbscript:' & $conSrchHTML_Txt & '.Value="' & $conSrchFlag & BAdrs2Hex ($lngB, $lngCh, $OneAya, $lngAyF, $lngAyT) & '"' & _
								'>' & _
								CreateAdd ($lngB, $lngCh, $lngAyF, $lngAyT, $OneAya) & _
						'</span>'

				$strAya = $strAya & "<br>" & $strAyaHTML & " " &  GetShAya ($lngB, $LngCh, $lngAyF, $LngAyT)
			EndIf
			.MoveNext
		WEnd
	EndWith
	$recRecAya.Close

	Return StringTrimLeft  ($strAya,4)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func GetComments ($lngBible, $lngChptr, $lngNo)
	Local $objMyDB2, $strSyle
	Local $strAya
	Local $strDB_App
	$lngBible = ConvKat2Dic ($lngBible, $lngChptr, $lngNo)

	$strDB_App = FolderFileName ($gconDB_App)
	;if FileExists (@ScriptDir & "\" & $gconDB_App) = 0 Then

	if $strDB_App = "" Then
		;Msgbox($conMirrorR2L + 16,$gconProgName, "الملف " & $gconDB_App & " غير موجود - يجب أعادة الاعداد للبرنامج")
		;ConsoleWrite( $gconDB_App & " File is not exist")
		WrtStatus ("ملف غير موجود :" & $gconDB_App, $pconStatusInfo )

		Return ""
	EndIf

	_OnError(True)
		$objMyDB2 = $objDBS.OpenDatabase ($strDB_App, True, True, ";pwd=" & $conSysPassWord)
	_OnError(False)

	If _Error() Then
		WrtStatus ("خطأ فى قراءة ملف :" & $gconDB_App, $pconStatusInfo )
		;ConsoleWrite( $gconDB_App & " File has bad file format")
		Return ""
	EndIf

;SELECT dicVersID, dicShahed, dicBible, dicChapter, dicStart, dicEnd, dicComment
;FROM tblMainBook INNER JOIN tblComment ON tblMainBook.dicVersID = tblComment.dicVersID
;WHERE (((tblMainBook.dicBible)=1) AND ((tblMainBook.dicChapter)=1));

	Local $StrSQL = "SELECT  dicShahed, dicBible, dicChapter, dicStart, dicEnd, dicComment " & _
					"FROM tblMainBook INNER JOIN tblComment ON tblMainBook.dicVersID = tblComment.dicVersID " & _
					" WHERE (dicBible = " & $lngBible  & ")" & _
					" And (dicChapter = " & $lngChptr  & ")" & _
					" And (dicStart <= " & $lngNo  & ") " & _
					" And (dicEnd >= " & $lngNo  & ") "


	Local $recRecAya ;=  $objMyDB2.OpenRecordset ($strSQL)
	If False =  OpenRecordSet ($objMyDB2, _
							  $recRecAya, _
							  $strSQL, _
							  "modDic: Error 03-Open Rec. set", _
							  $frmMainForm)  Then Return ""


	if $recRecAya.RecordCount = 0 Then
		$recRecAya.Close
		Return ""
	EndIf

	$strAya = Stringreplace ($recRecAya.Fields("dicComment").Value , @cr, "<br>")

	$recRecAya.Close
	Return $strAya
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func GetDic ($lngBible, $lngChptr, $lngNo)

	const $conTit1 = "التفسير التطبيقى للكتاب:"
	const $conTit2 = "الشواهد:"
	Local $strAya

	$strAya = "" & _
			  "<span class='DicTit'>" & $conTit1 & "</span>" & _
			  "<br><span class='DicTxt'>"  & GetComments ($lngBible, $lngChptr, $lngNo) & "</span>" &  _
			  "<hr>" & _
			  "<span class='DicTit'>" & $conTit2 & "</span>" & _
			  "<br><span class='DicTxt2'>"  & GetShahd ($lngBible, $lngChptr, $lngNo)  & "</span>"
	Return $strAya
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func GetAya ($lngBible, $lngChptr, $lngNo, $bNumbers = 0, $bTach = 1, _
			$strHTML_Num1="", $strHTML_Num2="", $strHTML_aya1="", $strHTML_aya2 =""	)

;MsgBox (0, "Dic", $strHTML_aya1 & " "  & $strHTML_aya2 )

	Local $Aya = GetOneAya ($lngBible, $lngChptr, $lngNo, _
							$bNumbers, $bTach, "", 0, _
							$strHTML_Num1, $strHTML_Num2, $strHTML_aya1, $strHTML_aya2 )
	Local $Dic = GetDic ($lngBible, $lngChptr, $lngNo)



	Return $Aya & "</p>" & $Dic
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func ConvKat2Dic ( $lngBible, Byref $lngBook , Byref $lngNo)
	; from Kat Number to Dic Num
	If $lngBible <= 16 then Return $lngBible
	If $lngBible >= 47 then Return $lngBible - 7

	If $lngBible = 32 then
		if $lngBook = 4  Then
			$lngNo = $lngNo + 3
		Elseif $lngBook = 3 and  $lngNo >= 24 And $lngNo <= 90 Then
			$lngBook = -1
			$lngNo = -1
		Elseif $lngBook = 3 and  $lngNo >= 91  And $lngNo <= 97 Then
			$lngNo = $lngNo - 67
		ElseIf $lngBook = 3 and  $lngNo > 97 Then
			$lngBook = 4
			$lngNo = $lngNo - 97
		EndIf
		Return 27
	EndIf

	If $lngBible >= 45 And $lngBible <= 46 then Return  -1

	If $lngBible >= 31 then Return $lngBible - 5
	If $lngBible >= 27 And $lngBible <= 29 then Return $lngBible - 4 ; 30 is Barook is missed
	If $lngBible >= 19 ANd $lngBible <= 24 then Return $lngBible - 2 ; 25-Wisdom 26-Sirach

	Return -1 ; all others 17-Tobit 18-Judith
EndFunc
