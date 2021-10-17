;---------------------------------------------------------------------------------------------------------------------------
Func CurBible ( $lngVar = Default)
	Local $temp = 0
	if $lngVar = Default Then Return $a_Settings[3]

	if $lngVar < 1 Then
		$lngVar = $conStartID ;1
		$temp = 1
	EndIf

	if $lngVar > $conItem Then
		$lngVar = $conItem
		$temp = 1
	EndIf

	$a_Settings[3] = $lngVar
	;$lngMaxValue = 0 + StringRight  ( $acBible[$lngVar], 3 )
   
	$lngMaxValue = GetBibleChpts ( $lngVar )
    
	Return $temp; error detected $lngVar
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func CurChptr ( $lngVar = Default)
	Local $temp = 0
	if $lngVar = Default Then Return $a_Settings[4]

	if $lngVar < 1 Then
		$lngVar = 1
		$temp = 1
	EndIf

	If $lngVar > $lngMaxValue Then
		$lngVar = $lngMaxValue 
		$temp = 1
	EndIf

	$a_Settings[4] = $lngVar
	
	$lngMaxAya = CalcMaxAya2Chpt ($a_Settings[3], $a_Settings[4])
	Return $temp; error detected $lngVar
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurAyaFrom ( $lngVar = Default)
	Local $temp = 0
	if $lngVar = Default Then Return $a_Settings[6]

	If $lngVar <= 0  Then
		$lngVar = 1
		$temp = 8
	EndIf
	If $lngVar > $lngMaxAya Then
		$lngVar = $lngMaxAya
		$temp = 8
	EndIf

	$a_Settings[6] = $lngVar
	Return $temp
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurAyaTo ( $lngVar = Default)
	Local $temp = 0
	if $lngVar = Default Then Return $a_Settings[7]

	;If $lngVar < 0 or $lngVar > $lngMaxAya or $lngVar < $a_Settings[6] Then
	;	$lngVar = $lngMaxAya
	;	$temp = 16
	;EndIf

	If $lngVar <= 0 or $lngVar < CurAyaFrom() Then
		$lngVar = CurAyaFrom()
		$temp = 16
	EndIf

	If $lngVar > $lngMaxAya Then
		$lngVar = $lngMaxAya
		$temp = 16
	EndIf

	$a_Settings[7] = $lngVar
	Return $temp
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurAyaChk ( $lngVar = Default  )
	Local $temp = 0

	if $lngVar = Default Then Return $a_Settings[5]
	if $lngVar <= 0 Then Return -1

;	If $lngVar < 0 or $lngVar > $lngMaxAya Then
;		$lngVar = 1
;		$temp = 4
;	EndIf

	If $lngVar <= 0  Then
		$lngVar = 1
		$temp = 4
	EndIf
	If $lngVar > $lngMaxAya Then
		$lngVar = $lngMaxAya
		$temp = 4
	EndIf

	$a_Settings[5] = $lngVar

	CurAyaFrom ($lngVar)
	CurAyaTo($lngVar)

	Return $temp
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurAdd ( $lngVar = Default)
	if $lngVar = Default Then Return $a_Settings[8]
	$a_Settings[8] = BitAND (1,$lngVar)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurCont ( $lngVar = Default)
	if $lngVar = Default Then Return $a_Settings[0]
	$a_Settings[0] = BitAND (1,$lngVar)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CurNum ( $lngVar = Default)
	If $lngVar = Default Then Return $a_Settings[1]
	$a_Settings[1] = BitAND (1,$lngVar)
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func CurTach ( $lngVar = Default)
	if $lngVar = Default Then Return $a_Settings[2]
	$a_Settings[2] = BitAND (1,$lngVar)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func ChkFixAya ()
	Local $isError
    
    ;-- Chk bible    
    $isError = CurBible ($a_Settings [3])   ; value of $a_setting is fixed also
    if $isError <> 0 Then
        CurBible (1) 
        CurChptr (1) ; -100 get defalut, adjust other values
        ;CurAyaChk (-100)
        CurAyaFrom (1) ; -100
        CurAyaTo (1000)

        Return $isError
    EndIf

    ;-- Chk chapter
    $isError =  CurChptr ( $a_Settings[4]) ;Then $isError = 1
    if $isError < 0 Then
        ;CurAyaChk (-100);-100
        CurAyaFrom (1);-100
        CurAyaTo (1000);-100

        Return $isError
    EndIf

	;-- Chk Aya
    If $a_Settings [5] >= 1 then
        $isError = CurAyaChk ($a_Settings [5])
    EndIf

    $isError +=  CurAyaFrom ( $a_Settings[6])
    $isError +=  CurAyaTo ( $a_Settings[7])

    Return $isError

EndFunc
;---------------------------------------------------------------------------------------------------------
Func ReadBible ($iBible = Default, $ichpt = Default, $iFrom = 1, $iTo = 1000)
		If $iBible = Default Then $iBible = CurBible ()
		If $ichpt = Default Then $ichpt = CurChptr ()

		CurBible ($iBible) 	;$a_Settings [3] = $iBible
		CurChptr ($ichpt) 	;$a_Settings [4] = $ichpt
		CurAyaFrom($iFrom)
		CurAyaTo($iTo)

		if CurAyaChk () <> 0 Then; no need call CurAyaChk is ignored
			CurAyaChk (1)
		EndIf

		;GUICtrlSetData ( $cmbBible, $avArray[$iBible])
		UpdateTxt()
EndFunc

;---frmMain------------------------------------------------------------------------------------------------------
Func UpdateTxt ()
	If  _GUICtrlTab_GetCurFocus($hTab) = $plng_SearchDef then Return

	Local $strChars	, $strWords
	Local $oIE_Top, $oIE_Bottom
	Local $isError
	Local $lngFrom, $LngTO

	; safety steps
	; safety steps

	$isError = ChkFixAya () ; fix any error
	;if $isError <> 0 Then
		;MsgBox($conMirrorR2L + 16, $gconProgName, "Update.UpdateTxt: Error 01-setting on ChkFixAya value =" & $isError, 0, $frmMainForm)
	;EndIf

	if CurAyaChk () > 0 Then
		$strChars = GetAya (CurBible(), CurChptr(), CurAyaChk(), CurNum () , CurTach(), _ 							; $a_Settings[1], $a_Settings[2]
							"</span><span class='num'>", "</span><span class='aya'>", "<span class='aya'>", '</span>')

		$strWords = WordsRead (CurBible(), CurChptr(), CurAyaChk(), 1, 9999 , _
								"<span class='wrdhead'>", "<span class='wrd'>", "<span class='num'>" )
	Else
   
		$strChars = ChptrRead (CurBible(), CurChptr(), CurAyaFrom(), CurAyaTo(), CurAdd(), _
							   "<span class='num'>",  "<span class='aya'>", _
							   "<span class='add1'>", "<span class='add2'>")

		$strWords = WordsRead (CurBible(), CurChptr(), -1, CurAyaFrom(), CurAyaTo(), _
								 "<span class='wrdhead'>", "<span class='wrd'>", "<span class='num'>" )
	EndIf

	If $strChars = "" Then
		MsgBox($conMirrorR2L + 16, $gconProgName, "UpdateTxt: Error 02-Unable to read Bible" & CurBible() & " Chapter " & CurChptr(), 0, $frmMainForm)
		;$strChars = 1
		Return
	EndIf

	;WrtBibleAdd ($plng_CurrTabNo)

	;$oIE_Top, $oIE_Bottom
	$oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	$oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)


	_IEDocWriteHTML ( $oIE_Top,  ApplyFormatTop ()  & _
								 "<span class='DicTit'>" &  GetBibibleADD ()  & "<br><hr></span>" & _
								 $strChars  & _
								 $conEndHTML )

	_IEdocWriteHTML ( $oIE_Bottom, ApplyFormatBottom () & "" & $strWords & "" & $conEndHTML )

	SetTabInfoBible ( $plng_CurrTabNo)
	UpdateMenuItem ($plng_CurrTabNo)

	WrtBibleAdd ($plng_CurrTabNo)

EndFunc

;---------------------------------------------------------------------------------------------------------

Func cmdPrevAya_Click ()
	Local $curAya

	IF $pstrPgDnUp = "Y" then Return
	$pstrPgDnUp = "Y"

	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf

	if CurAyaChk () <= 0 then
			ChngChpAya (-1)
	Else
		$curAya = CurAyaChk () - 1
		if $curAya  < 1 Then
			ChapterChange (-1)
			CurAyaChk ($lngMaxAya)
			CurAyaFrom ($lngMaxAya)
			CurAyaTo ($lngMaxAya)
		Else
			CurAyaChk ($curAya)
		EndIf

		UpdateTxt ()
	endif

	$pstrPgDnUp = "N"
EndFunc
;---------------------------------------------------------------------------------------------------------
Func cmdNextAya_Click ()
	Local $curAya

	IF $pstrPgDnUp = "Y" then
		Return
	EndIf

	$pstrPgDnUp = "Y"

	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf

	if CurAyaChk () <= 0 then
		ChngChpAya (1)
	else	; one Aya and Tafsir
		$curAya = CurAyaChk () + 1
		if $curAya  > $lngMaxAya Then
			ChapterChange (1)
		Else
			CurAyaChk ($curAya)
		EndIf

		UpdateTxt ()
	endif

	$pstrPgDnUp = "N"
	;ConsoleWrite ("Exit---------cmdNextAya_Click= $pstrPgDnUp=" & $pstrPgDnUp & @cr)
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ChngChpAya ($lngAct)
	if (CurAyaFrom () = 1 And CurAyaTo () = $lngMaxAya )  Or _
	   (CurAyaFrom () = 1 And $lngAct <0 ) Or _
	   ($lngAct >0 And CurAyaTo () = $lngMaxAya  ) Then

	    ChapterChange ( $lngAct )
		Return
	EndIf

	;----
	Local $nTemp
	If $lngact < 0 Then
		$nTemp = CurAyaFrom() -1 ; do not use same as in Eles code
		CurAyaFrom(1)
		CurAyaTo($nTemp)
	Else
		CurAyaFrom(CurAyaTo() + 1)
		CurAyaTo(1000); put max
	EndIf

	UpdateTxt ()
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ChapterChange ( $lngAct )
Local $curChpt = CurChptr () + $lngAct
Local $curBible
	if $curChpt < 1  Then
			$curBible = CurBible () -1

			if $curBible  < 1 Then
				CurBible (1) ; all adjuted
			Else
				CurBible ( $curBible ) ; all adjuted
			Endif
			CurChptr (1);  -100 make it from the first chapter
	ElseIf $curChpt > $lngMaxValue Then
			$curBible = CurBible () + 1

			if $curBible  > $conItem Then
				CurBible ( $conItem )
			Else
				CurBible ( $curBible )
			Endif
			CurChptr (1);-100
	Else
		CurChptr ( $curChpt )
	EndIf

	CurAyaFrom (-100)
	CurAyaTo (1000)

	if CurAyaChk () > 0 then CurAyaChk (1)

	UpdateTxt ()
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ApplyFormatTop ()
	;Local $Shahed_AyaStle = "018-0000FF-FFFFFF-0005-" & "Arial"

	Local $sHead = '<html><head>' & _
				'<style type="text/css">' & _
								'span.adrs {' & _
									GetHTML_Style ( $as_SysFont [ $conFSrchAdrs ]) & _
									'line-height: 1.5;' & _
									'text-indent: 40;' & _
									'Cursor:Pointer;' & _
								'}' & _
					'span.add1{' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleAdd1 ]) & _
						'line-height: 2;' & _
						'text-indent:40;' & _
					'}' & _
					'span.add2 {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleAdd2 ]) & _
						'line-height: 2;' & _
						'text-indent:40;' & _
					'}' & _
					'span.aya {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleAya ]) & _
						'line-height: 2;' & _
					'}' & _
					'span.num {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleNum ]) & _
						'line-height: 1.5;' & _
					'}' & _
					'span.DicTit {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleDicTit ]) & _
						'line-height: 1.5;' & _
						'text-indent:40;' & _
					'}' & _
					'span.DicTxt {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleDicTxt ]) & _
						'line-height: 1.5;' & _
						'text-indent:40;' & _
					'}' & _
					'span.DicTxt2 {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleDicTxt2 ]) & _
						'line-height: 2;' & _
						'text-indent:40;' & _
					'}' & _
					'span.Wrd {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrd ]) & _
						'line-height: 1.5;' & _
					'}' & _
					'span.Wrdhead {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrdHead ]) & _
						'line-height: 2;' & _
					'}' & _
					'span.num {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrdNum ]) & _
						'line-height: 2;' & _
					'}' & _
					'</style></head>'
;oncontextmenu="return false"

	Local $sBody = '<body dir="rtl" bgcolor="#' & Hex ($as_BKColor[0] + 0 ,6)  & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 30; margin-left: 30; margin-top: 10; margin-bottom: 10" ' & _
					' oncontextmenu="return false">' & _ ; oncontextmenu="return false"
					' <Input type="hidden" Name="' & $conSrchHTML_Txt & '">'

	Return $sHead & $sBody
EndFunc
;---------------------------------------------------------------------------------------------------------
Func ApplyFormatBottom ()
	Local $sHead = '<html><head>' & _
				'<style type="text/css">' & _
					'span.Wrd {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrd ]) & _
					'}' & _
					'span.Wrdhead {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrdHead ]) & _
					'}' & _
					'span.num {' & _
						GetHTML_Style ( $as_SysFont [ $conFBibleWrdNum ]) & _
					'}' & _
					'</style></head>'


	Local $sBody = '<body dir="rtl" bgcolor="#' & Hex ($as_BKColor[1] + 0, 6)  & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 30; margin-left: 30; margin-top: 10; margin-bottom: 10 "' & _
					' oncontextmenu="return false">' ; oncontextmenu="return false"

	Return $sHead & $sBody
EndFunc
