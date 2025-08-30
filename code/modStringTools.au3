#cs---
$strUni= "ايمن هنرى يونان"
$strASc = Uni2Hex ($strUni)
$strUni2 = Hex2Uni ($strAsc)

if $strUni = $strUni2 Then
	MsgBox (0,"OK", $strUni & "<-->" & $strUni2)
Else
		MsgBox (0,"Error", "O " & $strUni & "<-->" & $strUni2)
EndIf
#ce---

;---------------------------------------------------------------------------------------------------------------------------
Func CleanTxt ( $str )
	;$str = RemCash($str)
	$str = StringReplace ($str, "أ", "ا")
	$str = StringReplace ($str, "إ", "ا")
	$str = StringReplace ($str, "آ", "ا")
	$str = StringReplace ($str, "ا","[" & "آأإا" & "]")

	;This section removed to slove problem looking for ايمن
		;$str = StringReplace ($str, "ئ","ي")
		;$str = StringReplace ($str, "ى","ي")
		;$str = StringReplace ($str, "ي","[" & "ئيى" & "]")

	;----------------------------------------------------------------------------
	; Replaced by this Section
		$str = StringReplace ($str, "ى","ي")
		$str = StringReplace ($str, "ي","[" & "يى" & "]")
		If StringInStr ($str, "ئ ") > 0 then
			$str = StringReplace ($str, "ئ" ,"[" & "يى" & "]")
		EndIf
	;-----------------------------------------------------------------------------

	$str = StringReplace ($str, "ؤ","و")
	$str = StringReplace ($str, "و","[" & "وؤ" & "]")

	$str = $str & " "
	$str = StringReplace ($str,  "ه ", "ة ")
	If StringInStr ($str, "ة ") > 0 then
		$str = StringReplace ($str, "ه","[" & "هة" & "]")
	EndIf

	$str = StringReplace ($str, "'", "''")
	$str = StringTrimRight ($str ,1)

	Return $str
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Replace (Byref $strString, $strSubStr, $strSubStr2)
	While StringInStr($strString, $strSubStr) > 0
		$strString =StringReplace ($strString, $strSubStr, $strSubStr2)
	WEnd
	Return $strString
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Hex2Uni ( $strHex)
	Local $strRet, $lngCnt, $lngAsc

	For $lngCnt =1 to StringLen ($strHex) -1 Step 4
		$lngAsc =  Dec ( StringMid($strHex,$lngCnt,4) )
		$strRet = $strRet & ChrW ($lngAsc)
	Next

	Return $strRet

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Uni2Hex ( $strText) ; -1 Uni2Hex ,  1 Hex2UniCode
	Local $strRet, $lngCnt, $strHex

	For $lngCnt =1 to StringLen ($strText)
		$strHex = Hex ( AscW( StringMid($strText,$lngCnt,1) ) )
		$strHex = StringRight ($strHex, 4)
		$strRet = $strRet & $strHex
	Next

	Return $strRet
EndFunc


;---------------------------------------------------------------------------------------------------------------------------
Func TextComb ($strText, $strTach)
	Local $lngStrLen = StringLen($strTach), $lngCnt
	Local $lngCh, $lngPos, $lngAccPos, $strCH
	Local $lngText = StringLen($strText)

	Local $strString = ""
	$lngAccPos = 0

	For $lngCnt = 1 To $lngStrLen
		$lngCh = Asc (StringMid($strTach,$lngCnt, 1)) - 32

		$lngPos = BitAND ($lngCh, 0x78) / 8 + $lngAccPos
		$lngCh = BitAND ($lngCh, 0x07) + 1

		$strCh = StringMid ($strTachChr, $lngCh, 1)

		$strText = StringLeft ($strText,$lngPos + $lngCnt -1) & $strCh & _
					 StringRight ($strText, $lngText - $lngPos - $lngCnt + 1)

		$lngText = StringLen($strText)
		$lngAccPos = $lngPos
	Next
	Return $strText
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func TextSep ($strString, ByRef $strText, Byref $strTach)

	Local $lngStrLen = StringLen($strString), $lngCnt
	Local $Ch,  $lngPos, $lngAccPos, $lngLen

	Local $lngAsc
	$strText = ""
	$strTach = ""
	$lngAccPos = 0

	For $lngCnt = 1 To $lngStrLen
		$Ch = StringMid($strString,$lngCnt, 1)

		$lngPos = StringInStr ($strTachChr, $Ch)
		;MSgbox (0,"", "chr= " & $Ch  & " hex  " & $hexCh & " pos=" & $lngPos)

		if $lngPos <= 0 Then
			$strText = $strText & $Ch
		else
			$lngLen = StringLen($strText)

			$lngAsc = ($lngPos-1)  + 8 * ($lngLen - $lngAccPos ) + 32

			if $lngAsc >= 127 Then
				MsgBox ($conMirrorR2L + 16, $gconProgName, "modStringTools: Error 02 Tach >=127")
				Return
			EndIf

			if $lngAsc <> 0 then
				$strTach = $strTach & Chr($lngAsc)
				;Msgbox (0,"Tash POs", $lngAccPos & "    res=" & $lngLen - $lngAccPos)
				$lngAccPos = $lngLen ;+ $lngAccPos
			EndIf
		EndIf

	Next

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func RemCach ($StrString)
	Local $iCount
	For $iCount = 1 to StringLen ($strTachChr)
		$strString = StringReplace ( $strString , StringMid ($strTachChr,$iCount,1), "")
	Next

	$strString = StringReplace ( $strString , "أ", "ا")
	$strString = StringReplace ( $strString , "إ", "ا")
	$strString = StringReplace ( $strString , "آ", "ا")
	;$strString = StringReplace ( $strString , "ة ", "ه ")
	$strString = StringReplace ( $strString , "ه ", "ة ")
	$strString = StringReplace ( $strString , "ـ", "")
	;$strString = StringReplace ( $strString , "ي ", "ى ")
	$strString = StringReplace ( $strString, "ى",  "ي")

	Return $strString
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
;Func ConvertNumInd ($strStr)
;	Local $iCount, $iLen = StringLen ($strStr), $data ="", $temp
;	For $iCount = 1 to $iLen
;		$temp = StringMid ($strStr, $iCount, 1)
;
;		If  $temp + 0 = 0 and $temp <> "0" Then
;			$Data &= $temp
;		Else
;			$Data &= Num2India ($temp)
;		EndIf
;	Next
;	Return $Data
;	;MsgBox (0,"", $Data)
;EndFunc
;---------------------------------------------------------------------------------------------------------------------------

Func FixNum ( $str)
	Local $i, $iH, $Ret
	for $i = 0 to 9
		$iH = Num2India ($i)
		;MsgBox ("", $i, $str)

		$Ret = StringReplace ($str, $i & "", $iH)
		if @error <> 1 Then $str = $Ret

	next
	Return $str
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Num2India ( $strNum)
	local $lngCnt, $strHindi
	Local $chr
	For $lngCnt = 1 to StringLen($strNum)
		$chr = StringMid ($strNum, $lngCnt, 1)
		if Asc ($chr) >= Asc ('0') and Asc ($chr) <= Asc ('9') then
			$strHindi = $strHindi & ChrW( $chr + 1632 )
		Else
			$strHindi = $strHindi & $CHR
		EndIf
	Next
	Return $strHindi
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func India2Num ( $strNum)
	local $lngCnt, $strHindi
	For $lngCnt = 1 to StringLen($strNum)
		$strHindi = $strHindi & chr(AscW( StringMid ($strNum, $lngCnt, 1)) - 1632 + 48)
	Next
	Return $strHindi
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
