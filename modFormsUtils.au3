;--========== Formes Handlller ==========
Global $frmAbout
Global $frmBibleMap

Global $frmGetBible
Global $frmSearch

Global $frmSelectFont
Global $frmMainForm

Global $frmListFav
Global $frmAddFav
Global $frmShahed
Global $frmKamos

Global $frmChkProg

Global $lngExtraFormOpen = 0
DIm $conMaxID = 0xFFFF ;65535 ; 2 bytes 256 *2 + 255
; #FUNCTION# ====================================================================================================
; Name...........: FormStyle
; Description ...: Calculate form style
; Syntax.........: FormStyle ( $lngStyle )
; Parameters ....: $str  - [optional] item string to add default ""
;               $lngStyle   - [optional] Style to Or fix a fixed value of styles
; Return values .: Form Stryle as number
; Author ........: Hnry
; Remarks .......:
; Related .......:
; ====================================================================================================
Func FormStyle ( $lngStyle = 0 )
	Return  BitOR ($WS_CAPTION, $WS_POPUPWINDOW, $lngStyle) ;, $WS_POPUP
EndFunc
; #FUNCTION# ====================================================================================================
; Name...........: FormExStyle
; Description ...: Calculate form EX Style
; Syntax.........: FormExStyle ( $lngStyle )
; Parameters ....: $str  - [optional] item string to add default ""
;               $lngStyle   - [optional] Style to Or fix a fixed value of styles
; Return values .: Form Stryle as number
; Author ........: Hnry
; Remarks .......:
; Related .......:
; ====================================================================================================

Func formExStyle ( $lngStyle = 0)
	Return BitOR ( $WS_EX_DLGMODALFRAME, $WS_EX_WINDOWEDGE, $WS_EX_LAYOUTRTL, $lngStyle)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdFacebook_Start ()
	;StartupForm ("cmdChkUpdate_Click", $frmChkProg)
    _IECreate ($conFaceBook, 0,1,0,0)
EndFunc

Func cmdAndroid_Start ()
    _IECreate ($conAndroid, 0,1,0,0)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdSearch_Start ()
	;Local $lngTemp_TapNo = $plng_CurrTabNo
	Local $lngFeedBack = StartupForm ("cmdSearch_Click", $frmSearch)


	if $lngFeedBack = 1  And _
		$plng_SearchDef = $plng_CurrTabNo And _
		 _IEBodyReadHTML($oIESearch) = "" Then; no search doen
		;msgbox (0,0,$lngFeedBack)
		TabSetFous ( $plng_BibleDef + 0)
	EndIf

	;StartupForm ("cmdSearch_Click", $frmSearch)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmbFont_Start ()
	if StartupForm ("cmbFont_Click", $frmSelectFont) = 0 Then
		UpdateTxt ()
	EndIf
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdShahd_Start ()
	StartupForm ( "cmdShahed_Click", $frmShahed)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdSort_Start ()
	StartupForm ( "cmdSort_Click", $frmShahed)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdKamos_Start ()
	StartupForm ( "cmdKamos_Click", $frmKamos)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdBibleMap_Start ()
	StartupForm ( "cmdBibleMap_Click", $frmBibleMap)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdFavAdd_Start ()
	StartupForm ( "cmdFavAdd_Click", $frmAddFav, 1, $nHoverTab )
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdFavManag_Start ()
	local $strItem = StartupForm ( "cmdFavManag_Click", $frmListFav)
	If $strItem = "" Then Return
	ShowBible ( $strItem)
EndFunc

; #FUNCTION# ====================================================================================================
; Name...........: StartupForm
; Description ...: Startup Forms in safe condition
; Syntax.........: StartupForm ( "MyFormName ()" )
; Parameters ....: $strFormName  - Form Name function without ()
; Return values .: NON
; Author ........: Hnry
; Remarks .......:
; Related .......:
; ====================================================================================================

Func StartupForm ( $strFormName, byref $ID_Form, $IsPrarOne =0, $a_Para1 = 0 )
	if $lngExtraFormOpen = 1 Then Return ""

	$lngExtraFormOpen = 1
	IF IsPtr ($ID_Form) = 1  Then
		GUISwitch ( $ID_Form )
		WinActivate ($ID_Form)
		Return
	EndIf

	Local $FeedBack
	;Local $Setting = Opt ("GUIOnEventMode")
	Local $SettingEsc = Opt ('GUICloseOnESC', 1)	;1 = Send the $GUI_EVENT_CLOSE message when ESC is pressed (default).

	GUICtrlSetState ($grp, $GUI_FOCUS)

	;WinSetState ($gconProgNameBigName, "", @SW_DISABLE )
	GUICtrlSetState  ($hTab, $GUI_DISABLE)

	;-------
	if $IsPrarOne = 1 then
		$FeedBack =Call ( $strFormName, $a_Para1)
	Else
		$FeedBack =Call ( $strFormName )
	EndIf
	;ConsoleWrite ("feedback =" & $FeedBack  +0 & @CR)

	If @error = 0xDEAD And @extended = 0xBEEF Then MsgBox(4096, "", "FormsUtils:Error 01-Function does not exist:" & $strFormName ,0, $frmMainForm)

	Opt ('GUICloseOnESC',  $SettingEsc )
	;Opt ("GUIOnEventMode", $Setting)
	;-------

	GUICtrlSetState  ($hTab,@SW_ENABLE )
	;WinSetState ( $gconProgNameBigName, "", @SW_ENABLE  )
	;WinActivate ( $gconProgNameBigName)

	$lngExtraFormOpen = 0
	Return $FeedBack
EndFunc

; #FUNCTION# ====================================================================================================
Func cmdCpyWrt_Start ()
	StartupForm ("cmdCpyWrt_Click", $frmAbout)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdGetBible_Start ()
		;If $plng_CurrTabNo = $plng_SearchDef then
		;	TabSetFous ($plng_BibleDef)
		;EndIf

		StartupForm ("cmdGetBible_Click", $frmGetBible)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func ShowBible ( $strItem) ; two char per number
	Local $nAya = BHex2Adrs ($strItem, 3)
	Local $nAllSet, $nAdd, $nCont, $nNum, $nTach ;CurCont () + 2* CurNum () + 4* CurTach () + 8*CurAdd()

	CurBible (BHex2Adrs ($strItem, 1))
	CurChptr (BHex2Adrs ($strItem, 2))

	If (CurAyaChk () <= 0 and $nAya > 0 ) OR _
		(CurAyaChk () > 0 and $nAya <= 0 ) Then
		DispSwapAya ()
	EndIf

	CurAyaChk ( $nAya)

	CurAyaFrom (BHex2Adrs ($strItem, 4))
	CurAyaTo (BHex2Adrs ($strItem, 5) )
;--
	$nAllSet = BHex2Adrs ($strItem, 6)

	$nCont  = BitAND ($nAllSet, 1)
	$nNum   = BitAND ($nAllSet, 2)/2
	$nTach  = BitAND ($nAllSet, 4)/4
	$nAdd   = BitAND ($nAllSet, 8)/8

	;ConsoleWrite ($strItem & "IN Read ---------------- $nTach=" & $nTach & " CurTach=" & CurTach() & @CR)

	if CurAdd() <> $nAdd Then
		;MsgBox (0,$nAdd,"DispSwapAd= " &$nAdd & " " & CurAdd())
		DispSwapAdd (0)
		;CurAdd($nAdd)
	EndIf

	if CurCont() <> $nCont Then
		DispSwapCont (0)
		;CurCont ($nCont)
	EndIf

	if CurNum() <> $nNum Then
		DispSwapNum (0)
		;CurNum($nNum)
	EndIf

	if CurTach() <> $nTach Then
		DispSwapTach (0)
		;CurTach($nTach)
	EndIf

	;ConsoleWrite ($strItem & " Read ================= CurAdd=" & CurAdd() & " CurCont=" & CurCont() & " CurNum=" & CurNum() & " CurTach=" & CurTach() & @CR)
	;ConsoleWrite ($strItem & " Read ----------------- $nAdd=" & $nAdd & " $nCont=" & $nCont & " CurNum=" & $nNum & " $nTach=" & $nTach & @CR)
	;ConsoleWrite ($strItem & " Read ----------------- $nAdd=" & $nAdd & " CurAdd=" & CurAdd() & @CR)
	;------
	UpdateTxt ()

EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdLoadPage_Start ()
	 _IECreate ($conWebDownload , 0,1,0,0)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdLoadKamos_Start ()
	 _IECreate ("http://www.4shared.com/file/99015170/9f10f9ff/___.html", 0,1,0,0)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func cmdOfcPage_Start ()
	 _IECreate ($conWebSite, 0,1,0,0)
EndFunc

;----------------------------------------------------------------------------------------------------------------
Func cmdHelpPage_Start ()
	 ;_IECreate ("http://www.4shared.com/document/_OCNmi__/____.html", 0,1,0,0)
	 _IECreate ($conWebSite, 0,1,0,0)
EndFunc
;----------------------------------------------------------------------------------------------------------------
Func ChkIfValid ( $lngBib,  $lngChp,  $LngAFr, $LngATo)
	Local $lngMaxAy, $lngMaxCh;, $bState = true

	if $lngBib < 1 or $lngBib > $conItem then
		Return False
	EndIf

	$lngMaxCh = GetBibleChpts ( $lngBib )

	if $lngChp < 1 or $lngChp > $lngMaxCh then
					;CurChptr (-100)
		Return False
	EndIf

	$lngMaxAy =  CalcMaxAya2Chpt ($lngBib, $lngChp)
	If ($LngAFr < 1 or $LngAFr > $lngMaxAy) Or _
	   ($LngATo < 1 or $LngATo > $lngMaxAy) Or _
	   ($LngATo < $LngAFr) then Return False ;$bState = False

	Return True ;$bState
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func BAdrs2Hex ($lngN1=0, $lngN2=0, $lngN3=0, $lngN4=0, $lngN5=0, $lngN6=0)
	Local $strPara = 	Hex( $lngN1, 2)	& _
						Hex( $lngN2, 2)	& _
						Hex( $lngN3, 2)	& _
						Hex( $lngN4, 2)	& _
						Hex( $lngN5, 2) & _
						Hex( $lngN6, 2)

	Return $strPara
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func BHex2Adrs ($str, $lngN=1)
	Local $lngPara =  Dec (	StringMid( $str, 2*$lngN-1,2) ) + 0
	Return $lngPara
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func FolderFileName ( $strFileName, $IsForceValue = 0)
	Local $strInFolder = @ScriptDir & "\" & $gconDB_Folder & "\" & $strFileName
	Local $strInLine   = @ScriptDir & "\" & $strFileName

	;ConsoleWrite ($strInFolder & @cr)
	;ConsoleWrite ($strInLine & @cr)

	;ConsoleWrite (FileExists ($strInFolder) & @cr)
	;ConsoleWrite (FileExists ($strInLine)& @cr)

	If $strFileName = "" Then Return ""
	If FileExists ($strInFolder) = 1 Then Return $strInFolder
	If FileExists ($strInLine) = 1 	 Then Return $strInLine

	if $IsForceValue = 1 Then Return $strInFolder;$strInLine

	Return ""

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
