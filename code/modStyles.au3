

;--=========== Func to read data----------------------------------------------------------
	; example ReadDefVal ( $conDefBible1Font, $conPosFColor)
	Func ReadDefVal ( $strDef, $lngPos)
		Local $lngSPC = StringInStr ($strDef & "-", "-", 2, 1, $lngPos)
		Local $strVal = StringMid ($strDef, $lngPos, $lngSpc -$lngPos)
		Return $strVal
	EndFunc
;--=========== Func to combine it back to string ----------------------------------------------------------
	; Return   "018-0000FF-FFFFFF-0000-Traditional Arabic"
	Func SetDefVal ( $strFName, $strSize, $strFColor, $strFBColor, $strStyle)
		Local $strFont
		$strFont  = StringRight ("000000" & $strSize, $conPosFColor - $conPosSize -1 ) & "-"
		$strFont &= StringRight ("000000" & $strFColor, $conPosBColor - $conPosFColor -1 ) & "-"
		$strFont &= StringRight ("000000" & $strFBColor, $conPosAttr - $conPosBColor -1) & "-"
		$strFont &= StringRight ("000000" & $strStyle, $conPosFName - $conPosAttr -1) & "-"
		$strFont &= $strFName

		Return $strFont
	EndFunc

;--=========== Creat HTML Style----------------------------------------------------------
	;						'color:#' & $myColor  & ';' & _
	;						'font-family:' & $$myFont & ';' & _
	;						'line-height: 1.5;' & _
	;						'font-size: ' &  $myFontSize& 'pt;' & _
	;
	;	"018 0000FF 0000 " & "Traditional Arabic"

	Func GetHTML_Style ( $strTextStyle )
		Local $strHTMLSTyle
		Local $strDeco = ""

		Local $strSize =   ReadDefVal ($strTextStyle, $conPosSize) 		+ 0
		Local $strBColor = ReadDefVal ($strTextStyle, $conPosBColor)
		Local $strFColor = ReadDefVal ($strTextStyle, $conPosFColor)
		Local $strAttr =   ReadDefVal ($strTextStyle, $conPosAttr)		+ 0
		Local $strFName =  ReadDefVal ($strTextStyle, $conPosFName)

		;msgbox (0,"Siez", $strSize & " " & $strTextStyle )
		;msgbox (0,"Color", $strFColor & " " & $strTextStyle )
		;msgbox (0,"Attr", $strAttr & " " & $strTextStyle )
		;msgbox (0,"Fname", $strFName & " " & $strTextStyle )

		if BitAND ($strAttr,  $conStyleBold) > 0  then  $strDeco &= "font-weight:bold;"
		if BitAND ($strAttr,  $conStyleItalic) > 0 then  $strDeco &= "font-style:italic;"
		if BitAND ($strAttr,  $conStyleUnder) > 0  then  $strDeco &= "text-decoration:underline;"
		if BitAND ($strAttr,  $conStyleSuper) > 0  then  $strDeco &= "vertical-align:super;"


		$strHTMLSTyle =	'color:#' & StringRight("000000" &  $strFColor ,6)  & ';' & _
						'font-size:'  & $strSize  & 'pt;' & _
						'background-color:#'  & $strBColor  & ';' & _
						'font-family:' & $strFName & ';' & _
						 $strDeco

		;msgbox (0,"", $strHTMLSTyle	)
		Return $strHTMLSTyle
	EndFunc
