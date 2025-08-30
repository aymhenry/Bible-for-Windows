Global $Data, $cmdSample
Global $PickerTextColor, $PickerBkColor, $PickerFBColor, $hSlider, $txtSlider

; #FUNCTION# ====================================================================================================
; Name...........: _FontSelect
; Description ...:
; Syntax.........: _FontSelect()
; Parameters ....:
; Return values .: Success - An array with an index of 4.
;                  Failure - sets @error to 1
; Author ........: Hnry
; Remarks .......:
; Related .......: None
; ====================================================================================================

Func cmbFont_Click()
	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf

	Local $lblFClr, $lblFBClr, $lblBKClr

	Local $bOneMenuFontYes = 0

	Local $oIEPreview, $GUIActxPreview
	Local $lngChanged = 0 ; 0 no change 1 change
	Local $lngFontID = 0

	Local $regkey, $Slider, $msg,  $av
	Local $nGUImode = Opt("GuiOnEventMode", 0)
	const $conFSeletLeft = 180

    Local $lstFontFamily,$lstSamples, $lstFontStyle, $cmdOK, $cmdCancel, $cmdApply, $chkBk_FColor	;, $cmdSample;$gcFontSize $gcFontWeight
    Local $szString, $nSelect, $i = 1, $s = ""

	Dim $azFontOptions = GetColorData ($lngFontID)

	;---------------------------------------------------------------------------------------------------------------------------
	$oIEPreview = _IECreateEmbedded ()

    $frmSelectFont = GUICreate("أختيار الخط", 640, 400, -1, -1, _
			formStyle (), formExStyle (), $frmMainForm )

			GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmSelectFont )

    GUICtrlCreateLabel("تعديل النموذج", 16, 25, 200, 33)
			$szString = ""
			For $i = 0 to UBound($as_FontDesc)-1
				$szString &= $as_FontDesc [$i] & "|"
			Next

    $lstSamples = GUICtrlCreateList ( "" , 16, 50, 170, 158, _
										BitOR($LBS_NOTIFY, $WS_VSCROLL, $LBS_MULTIPLESEL, $LBS_EXTENDEDSEL, $LBS_NOINTEGRALHEIGHT))
			GUICtrlSetData($lstSamples, $szString)
			 _GUICtrlListBox_SetSel ( $lstSamples, $lngFontID )

	;------------------------
    GUICtrlCreateGroup("الخـط", $conFSeletLeft + 8, 5, 325, 210)

	GUICtrlCreateLabel("اسم الخط", $conFSeletLeft + 16, 25, 80, 33)

	$lstFontFamily = GUICtrlCreateCombo("", $conFSeletLeft + 16, 50, 200, 170, _
				BitOR($CBS_SIMPLE, $WS_VSCROLL, $CBS_SORT, $CBS_AUTOHSCROLL, $CBS_HASSTRINGS))

			If @OSTYPE = "WIN32_NT" Then $regkey = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
			If @OSTYPE = "WIN32_WINDOWS" Then $regkey = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Fonts"
			$szString = ""
			While 1
				$s = RegEnumVal($regkey, $i)
				If @error <> 0 Then ExitLoop
				$s = StringRegExpReplace($s,"\s\(.*?\)(\s*)?","")
				If StringInStr ($s,"ا",2) > 0 Then ExitLoop

				$szString &= $s & "|"
				$i = $i + 1
			WEnd

			GUICtrlSetData($lstFontFamily, $szString)
			$nSelect = _GUICtrlComboBox_SetCurSel($lstFontFamily, _GUICtrlComboBox_FindString($lstFontFamily, $azFontOptions[0]))
			If $nSelect = -1 Then _GUICtrlComboBox_SetCurSel($lstFontFamily, "Arial")

    GUICtrlCreateLabel("تاثيرات", $conFSeletLeft + 223, 25, 70, 33)

	Local $avStyle[5][2] = [['عادى', $conStyleNormal],['ثقيل', $conStyleBold], ['مائل', $conStyleItalic], ['تحتة خط', $conStyleUnder], ['عالى', $conStyleSuper]]
		  $lstFontStyle = GUICtrlCreateList("", $conFSeletLeft + 223, 50, 100, 120, _
										BitOR($LBS_NOTIFY, $WS_VSCROLL, $LBS_MULTIPLESEL, $LBS_EXTENDEDSEL)); $LBS_NOINTEGRALHEIGHT $LBS_DISABLENOSCROLL
			$szString = ""
			For $i = 0 to UBound($avStyle)-1
				$szString &= $avStyle[$i][0] & "|"
			Next

			GUICtrlSetData($lstFontStyle, $szString)
			;=================================
			SetStyleList ( $avStyle, $lstFontStyle, $azFontOptions[4])

    GUICtrlCreateLabel("نموذج", 16, 215 , 70, 20)
			;----------------------------------------------------
			$GUIActxPreview = GUICtrlCreateObj($oIEPreview, 16, 245, 420, 80)
			;----------------------------------------------------

	$PickerTextColor = _GUIColorPicker_Create ('', $conFSeletLeft + 282, 230, 28,28, Dec($azFontOptions[2]) , BitOR($CP_FLAG_CHOOSERBUTTON, $CP_FLAG_MAGNIFICATION, $CP_FLAG_TIP), 0, -1, -1, 'لون الخـط')
			$lblFClr = GUICtrlCreateLabel("لون الخط", $conFSeletLeft + 282 +36, 232, 100, 20)

	$PickerFBColor  = _GUIColorPicker_Create ('', $conFSeletLeft + 282, 230 +43, 28,28, Dec($azFontOptions[3]) , BitOR($CP_FLAG_CHOOSERBUTTON, $CP_FLAG_MAGNIFICATION, $CP_FLAG_TIP), 0, -1, -1, 'لون خلفية الخط')
			$lblFBClr = GUICtrlCreateLabel("لون خلفية الخط", $conFSeletLeft + 282 +36, 232 +43+2, 120, 20)

	$PickerBkColor  = _GUIColorPicker_Create ('', $conFSeletLeft + 282, 230 + 43*2, 28,28, Dec($azFontOptions[5]) , BitOR($CP_FLAG_CHOOSERBUTTON, $CP_FLAG_MAGNIFICATION, $CP_FLAG_TIP), 0, -1, -1, "لون الخلفية")
			$lblBKClr = GUICtrlCreateLabel("لون الخلفية", $conFSeletLeft + 282 +36, 232 + 43*2 + 2, 120, 20)

	$Slider = GUICtrlCreateSlider( 16, 250 + 80, 390  , 26, BitOR($TBS_BOTH, $TBS_NOTICKS, $WS_TABSTOP))
			$hSlider = GUICtrlGetHandle(-1)
			GUICtrlSetLimit($Slider, 72, 4)
			GUICtrlSetData ($hSlider, $azFontOptions[1])

			GUICtrlSetData(-1, $azFontOptions[1])

 	$txtSlider = GUICtrlCreateInput( Num2India ($azFontOptions[1]), $conFSeletLeft + 230 ,  245 + 81  , 28, 28, BitOR($ES_CENTER, $ES_READONLY))
		GUICtrlSetBkColor(-1, _WinAPI_SwitchColor(_WinAPI_GetSysColor($COLOR_WINDOW)))

    $cmdOK     = GUICtrlCreateButton  ("موافق", $conFSeletLeft + 340, 16          , 100, 30, 0)

    $cmdCancel = GUICtrlCreateButton  ("إلغاء الامر", $conFSeletLeft + 340, 16 + 35, 100, 30, 0)

    $cmdApply = GUICtrlCreateButton  ("تطبيق", $conFSeletLeft + 340, 16 + 35*2, 100, 30, 0)
		GUICtrlSetState ( $cmdApply, $GUI_DISABLE )

    $cmdSample = GUICtrlCreateButton  ("موافق", 16+170/2, 245 + 50/2, 100, 30, 0)
		GUICtrlSetState ( $cmdApply, $GUI_DISABLE )
		GuiCtrlSetState(-1, $GUI_HIDE)

	;------
	$chkBk_FColor = GUICtrlCreateCheckbox ("اجعل لون خلفية الصفحة مثل لون خلفية الخط", 16,350,320, 25)
		GuiCtrlSetState(-1, $GUI_CHECKED)

	GUISetState(@SW_SHOW)
	GUICtrlSetState ( $lstFontFamily, $GUI_FOCUS)

	_IENavigate ($oIEPreview, "about:blank")

	AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
						$PickerTextColor, $PickerFBColor, $PickerBkColor)

    While 1
        $msg = GUIGetMsg(1)

        Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return

			;Case $GUI_EVENT_CLOSE,  $cmdCancel
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmSelectFont)

				_GUIColorPicker_Delete ( $PickerFBColor )
				_GUIColorPicker_Delete ( $PickerBkColor )
				_GUIColorPicker_Delete ( $PickerTextColor )

				frmSelectFont_Close ( $nGUImode )
				Return -1

			Case $msg[0] = $cmdApply
				SaveColorData ($azFontOptions, $lngFontID, $lngChanged, 0)
				$lngChanged = 0
				GUICtrlSetState ( $cmdApply, $GUI_DISABLE )
				if $bOneMenuFontYes = 1 Then
					SetButAttr ( $as_SysFont )

					TrayTip ( $gconProgName, "يجب أعادة تشغيل البرنامج لاستخدام الخط الجديد" , 30 , 1)
					;MsgBox($conMirrorR2L + 4128, $gconProgName, "يجب أعادة تشغيل البرنامج لاستخدام الخط الجديد" )
				EndIf

			Case $msg[0] = $cmdOK

				_GUIColorPicker_Delete ( $PickerFBColor )
				_GUIColorPicker_Delete ( $PickerBkColor )
				_GUIColorPicker_Delete ( $PickerTextColor )

                frmSelectFont_Close ( $nGUImode )

				SaveColorData ($azFontOptions, $lngFontID, $lngChanged, 0)
				;msgbox(0,"", $as_SysFont [$lngFontID])
				if $bOneMenuFontYes = 1 and $lngChanged = 1 Then
						SetButAttr ( $as_SysFont )
						;GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmMainForm )
						;_WinAPI_RedrawWindow($frmMainForm,0,0,BitOR($RDW_ERASE,$RDW_INVALIDATE,$RDW_UPDATENOW,$RDW_FRAME,$RDW_ALLCHILDREN))
						TrayTip ( $gconProgName, "يجب أعادة تشغيل البرنامج لاستخدام الخط الجديد" , 30 , 1)
						;MsgBox($conMirrorR2L + 4128, $gconProgName, "يجب أعادة تشغيل البرنامج لاستخدام الخط الجديد" )
				EndIf

				Return 0

			Case $msg[0] = $lstSamples
				if $lngChanged = 1 Then
					SaveColorData ($azFontOptions, $lngFontID, 1, 1)
					$lngChanged = 0
					GUICtrlSetState ( $cmdApply, $GUI_DISABLE )
				EndIf
				;SetSampleFont ($azFontOptions, $lstFontFamily)
				$lngFontID = _GUICtrlListBox_GetCurSel  ( $lstSamples )

				$azFontOptions [0] = ReadDefVal ($as_SysFont [$lngFontID] , $conPosFName)
				GUICtrlSetData ( $lstFontFamily, $azFontOptions [0] )

				$azFontOptions = GetColorData ($lngFontID)

				SetStyleList ( $avStyle, $lstFontStyle, $azFontOptions[4])

				if $lngFontID = $conMunuFont Then
					GuiCtrlSetState($cmdSample, $GUI_SHOW)
					GuiCtrlSetState($GUIActxPreview, $GUI_Hide)
					GuiCtrlSetState($chkBk_FColor, $GUI_Hide)

					GUICtrlSetLimit($Slider, 14, 4)
					$bOneMenuFontYes = 1
					SetColorButton (  $PickerTextColor, $PickerFBColor, $PickerBkColor, _
										$lblFClr, $lblFBClr, $lblBKClr, False)
					;GUICtrlSetFont ( $cmdSample, $azFontOptions[1] , 200* BitAND (1, $azFontOptions[4] ) +400 , BitAND (6, $azFontOptions[4] ) , $azFontOptions[0] )
				Else

					GuiCtrlSetState($cmdSample, $GUI_HIDE)
					GuiCtrlSetState($GUIActxPreview, $GUI_SHOW)
					GuiCtrlSetState($chkBk_FColor, $GUI_SHOW)

					GUICtrlSetLimit($Slider, 72, 4)
					$bOneMenuFontYes = 0
					SetColorButton (  $PickerTextColor, $PickerFBColor, $PickerBkColor, _
										$lblFClr, $lblFBClr, $lblBKClr, True)
				EndIf
					AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
									$PickerTextColor, $PickerFBColor, $PickerBkColor)


			Case $msg[0] = $lstFontFamily
				$lngChanged = 1
				GUICtrlSetState ( $cmdApply, $GUI_ENABLE )
				$azFontOptions[0] = _GUICtrlComboBox_GetEditText($lstFontFamily)    ;Font Family
				AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
						$PickerTextColor, $PickerFBColor, $PickerBkColor)

			Case $msg[0] = $Slider
				$lngChanged = 1
				GUICtrlSetState ( $cmdApply, $GUI_ENABLE )
				$Data = GUICtrlRead($Slider)
				GUICtrlSetData($txtSlider, Num2India ( $Data ) )
				$azFontOptions[1] = $Data ;  ;Font Size

				AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
						$PickerTextColor, $PickerFBColor, $PickerBkColor)

			Case $msg[0] = $lstFontStyle
				$lngChanged = 1
				GUICtrlSetState ( $cmdApply, $GUI_ENABLE )
				$Data = 0
                For $i = 0 to UBound($avStyle)-1
                    $av = _GUICtrlListBox_GetSelItemsText ( $lstFontStyle )
                    For $y  = 0 To $av[0]
                        If $av[$y] = $avStyle[$i][0] Then
                            $Data += $avStyle[$i][1]		; Font Style
                        EndIf
                    Next
                Next
				;msgbox (0,"",$azFontOptions[4] )

				if ($bOneMenuFontYes = 1)  and (BitAND ($Data, $conStyleSuper) <> 0 ) Then
					$lngChanged = 0
					SetStyleList ( $avStyle, $lstFontStyle, $azFontOptions[4])
					;MsgBox($conMirrorR2L + 4128, $gconProgName, "غير مسموح بتاثير عالى على خط النماذج" )
					TrayTip ( $gconProgName, "غير مسموح بتاثير عالى على خط النماذج"  , 30 , 3)
				else
					$azFontOptions[4] = $Data
					AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
							$PickerTextColor, $PickerFBColor, $PickerBkColor)
				EndIf

			Case $msg[0] = $PickerTextColor
				$Data = _GUIColorPicker_GetColor($PickerTextColor)

				If ($Data > -1)  Then
					if $bOneMenuFontYes = 1 Then
						_GUIColorPicker_SetColor ( $PickerTextColor,  dec($azFontOptions[2]))
						$lngChanged = 0
						MsgBox($conMirrorR2L + 4128, $gconProgName, "غير مسموح بتغيير اللون" ); not used
					else
						$lngChanged = 1
						GUICtrlSetState ( $cmdApply, $GUI_ENABLE )

						$azFontOptions[2] = Hex($Data, 6)       ;Font Color

						AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
								$PickerTextColor, $PickerFBColor, $PickerBkColor)

					EndIf
				EndIf


			Case $msg[0] = $PickerFBColor
				$Data = _GUIColorPicker_GetColor ( $PickerFBColor )
				If ($Data > -1)  Then
					if $bOneMenuFontYes = 1 Then
						_GUIColorPicker_SetColor ( $PickerFBColor,  dec( $azFontOptions[3]))
						$lngChanged = 0
						MsgBox($conMirrorR2L + 4128, $gconProgName, "غير مسموح بتغيير اللون" ); not used
					Else
						$lngChanged = 1
						GUICtrlSetState ( $cmdApply, $GUI_ENABLE )

						$azFontOptions[3] = Hex($Data, 6)       ;back Font Color
						if GUICtrlRead ($chkBk_FColor) =  $GUI_CHECKED Then
							$azFontOptions[5] = $azFontOptions[3]
							_GUIColorPicker_SetColor ( $PickerBkColor, $Data)
						EndIf

						AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
								$PickerTextColor, $PickerFBColor, $PickerBkColor)

					EndIf
				EndIf

			Case $msg[0] = $PickerBkColor
				$Data = _GUIColorPicker_GetColor( $PickerBkColor )
				If ($Data > -1)  Then

					if $bOneMenuFontYes = 1 Then
						GUICtrlSetState ( $PickerBkColor, $GUI_DISABLE)
						_GUIColorPicker_SetColor ( $PickerBkColor,  dec($azFontOptions[5]))
						$lngChanged = 0
						MsgBox($conMirrorR2L + 4128, $gconProgName, "غير مسموح بتغيير اللون" ) ; not used
					Else

						$lngChanged = 1
						GUICtrlSetState ( $cmdApply, $GUI_ENABLE )

						$azFontOptions[5] = Hex($Data, 6)       ;page back Color

						if GUICtrlRead ($chkBk_FColor) = $GUI_CHECKED Then
							$azFontOptions[3] = $azFontOptions[5]
							_GUIColorPicker_SetColor ( $PickerFBColor, $Data)
						EndIf
						AdjPreview ($azFontOptions, $lngFontID, $oIEPreview, $Slider, $txtSlider, _
								$PickerTextColor, $PickerFBColor, $PickerBkColor)


					EndIf
				EndIf

        EndSelect
    WEnd
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func frmSelectFont_Close ( $lngGUImode )
;	$lngExtraFormOpen = BitAND (255-$lngFrmSelectFontID, $lngExtraFormOpen); make the second bit 1

	IF IsPtr ( $frmSelectFont ) Then
		GUIDelete($frmSelectFont)
		$frmSelectFont = 0
	EndIf

;	if $lngExtraFormOpen =0 then Opt("GUIOnEventMode", $lngGUImode) ; 1

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func AdjPreview ($a_FontSetting, $lngID, ByRef $IE_Prev, ByRef $Slid, ByRef $txtSlid, byref $btnColor, $btnBColor, $btnBack )
	Const $strStyleTxt = "Fstyle"
	Const $strCustmTxt = "Custm"

	Local $iCount
	Local $strDeco
;	Local $oBody
	;$a_FontSetting[0] =  ReadDefVal (  ,$conPosFName)

	GUICtrlSetFont ( $cmdSample, $a_FontSetting[1] , 200* BitAND (1, $a_FontSetting[4] ) +400 , BitAND (6, $a_FontSetting[4] ) , $a_FontSetting[0] )
	;_ArrayDisplay ($a_FontSetting)

	_GUIColorPicker_SetColor ( $btnColor, Dec ($a_FontSetting [2] ))
	_GUIColorPicker_SetColor ( $btnBColor, Dec ($a_FontSetting [3]))
    _GUIColorPicker_SetColor ( $btnBack, Dec ($a_FontSetting [5]))

	GUICtrlSetData ($Slid, $a_FontSetting[1])
	GUICtrlSetData ($txtSlid,Num2India ($a_FontSetting[1]) )

	$strDeco =""
	if BitAND ($a_FontSetting[4], $conStyleItalic) > 0 then $strDeco &= "font-style:italic;"
	if BitAND ($a_FontSetting[4], $conStyleBold) > 0  then $strDeco &= "font-weight:bold;"
	if BitAND ($a_FontSetting[4], $conStyleUnder) > 0  then $strDeco &= "text-decoration:underline;"
	if BitAND ($a_FontSetting[4], $conStyleSuper) > 0  then $strDeco &= "vertical-align:super;"

	Local $strHTMLSTyle =	'span.'  &  $strCustmTxt & '{' & _
							'color:#' & StringRight("000000" &  $a_FontSetting[2] ,6)  & ';' & _
							'background-color:#' & StringRight("000000" &  $a_FontSetting[3] ,6)  & ';' & _
							'font-size: '  & $a_FontSetting[1]  & 'pt;' & _
							'font-family:' & $a_FontSetting[0] & ';' & _
							$strDeco & _
							'}'

	For $iCount = 0 to UBound ($as_SysFont) - 1
		 $strHTMLSTyle &=	'span.' & $strStyleTxt & $iCount & '{' & _
							GetHTML_Style ( $as_SysFont [ $iCount ]) & _
							'}'
	Next

	$strHTMLSTyle = '<html><head>' & _
					'<style type="text/css">' & _
					$strHTMLSTyle & _
					'</style></head>' & _
                    '<body dir="rtl" bgcolor="#' & StringRight("000000" & $a_FontSetting[5],6)  & '"' & _
					' style="text-align: justify; direction:rtl;  margin-right: 2; margin-left: 2; margin-top: 0; margin-bottom: 0"' & _
					'>'
	;Local $sStyleEnd = '</body></html>'

	_IEDocWriteHTML ($IE_Prev, $strHTMLSTyle & _
                                     SetSample ($lngID, $strStyleTxt, $strCustmTxt ) & _
                                    $conEndHTML)
	_IEAction ($IE_Prev, "refresh")

;		$oBody = _IETagNameGetCollection($IE_Prev, "body", 0)
;	_IEDocInsertHTML  ($oBody, SetSample ($lngID, $strStyleTxt, $strCustmTxt ) )
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SetSample ( $lngFontID, $strStyleTxt, $strCustmTxt )
	Local $strSample

	    Switch $lngFontID

			Case $conFBibleAya, $conFBibleNum
				$strSample = "<span class='" & $strStyleTxt & $conFBibleNum & "'>" & $RlE & Num2India("1") &  "</span>"  & _
							 "<span class='" & $strStyleTxt & $conFBibleAya & "'>" & "فِي الْبَدْءِ خَلَقَ اللهُ السَّمَاوَاتِ وَالأَرْضَ."  & "</span>"

			Case $conFBibleWrdHead, $conFBibleWrd, $conFBibleWrdNum
				$strSample = "<span class='" & $strStyleTxt & $conFBibleWrdNum  & "'>" &  $RlE & Num2India("1") &  "</span>"  & _
							 "<span class='" & $strStyleTxt & $conFBibleWrdHead & "'>" &  "خلق "  & "</span>" & _
							 "<span class='" & $strStyleTxt & $conFBibleWrd  & "'>" & ":" & "أوجد من العدم، كون من لا شئ"  & "</span>"

			Case $conFBibleAdd1
;MsgBox (0,0, $conFBibleAdd1)
				$strSample =  "<span class='" & $strStyleTxt & $conFBibleAdd1 & "'>" & "العنوان الرئيسى:"  & "</span>"

			Case $conFBibleAdd2
;MsgBox (0,0, $conFBibleAdd2)
				$strSample =  "<span class='" & $strStyleTxt & $conFBibleAdd2 & "'>" & "العنوان الفرعى:"  & "</span>"

			Case $conFBibleDicTit
				$strSample =  "<span class='" & $strStyleTxt & $conFBibleDicTit & "'>" & "التفسير:"  & "</span><br>"	& _
							  "<span class='" & $strStyleTxt & $conFBibleDicTit & "'>" & "الشواهد:"  & "</span>"

			Case $conFBibleDicTxt
				$strSample =  "<span class='" & $strStyleTxt & $conFBibleDicTxt & "'>" & "تك 1 : 1"  & "</span><br>"	& _
							  "<span class='" & $strStyleTxt & $conFBibleDicTxt & "'>" & 'تعد هذه العبارة البسيطة: خلق الله السموات والأرض ...'  & "</span>"

			Case $conFBibleDicTxt2
				$strSample =  "<span class='" & $strStyleTxt & $conFBibleDicTxt2 & "'>" & "إش 42 : 5 هَذَا مَا يَقُولُهُ اللهُ، الرَّبُّ خَالِقُ السَّمَاوَاتِ وَبَاسِطُهَا، وَنَاشِرُ الأَرْضِ و ... "  & "</span>"


			Case $conFSrchAya, $conFSrchFoundAya
				$strSample =  "<span class='" & $strStyleTxt & $conFSrchAya & "'>" & " كِتَابُ مِيلاَدِ يَسُوعَ"  & "</span>"	& _
							  "<span class='" & $strStyleTxt & $conFSrchFoundAya & "'>" & " الْمَسِيح "  & "</span>" & _
							  "<span class='" & $strStyleTxt & $conFSrchAya & "'>" & "ابْنِ دَاوُدَ ابْنِ إِبْراهِيمَ"  & "</span>"

			Case $conFSrchTitle
				$strSample =  "<span class='" & $strStyleTxt & $conFSrchTitle & "'>" & "البحث عن النـص: المسيح"  & "</span><br>"	& _
							  "<span class='" & $strStyleTxt & $conFSrchTitle & "'>" & 'نطــاق البحــث: كل الكتاب'  & "</span>"

			Case $conFSrchAdrs
				$strSample =  "<span class='" & $strStyleTxt & $conFSrchAdrs & "'>" & "متى 1:‏1"  & "</span>"

			Case $conKamosFontTit
				$strSample =  "<span class='" & $strStyleTxt & $conKamosFontTit & "'>" & "العنوان بالقاموس"  & "</span>"

			Case $conKamosFont
				$strSample =  "<span class='" & $strStyleTxt & $conKamosFont & "'>" & "شرح القاموس"  & "</span>"

		Case Else ;$conMunuFont
				$strSample =  "<span class='" & $strStyleTxt & $conMunuFont & "'>" & "موافق"  & "<br>" &  "إلغاء الامر" & "</span>"
		EndSwitch

		Return StringReplace ($strSample, $strStyleTxt & $lngFontID, $strCustmTxt)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SaveColorData ($a_FontSetting, $lngID, $lngChanged, $lngAskToSave = 1 )
	if $lngChanged = 0 Then Return ; if no

	Local $vAns
	if $lngChanged = 1 and $lngAskToSave = 1 Then ; yes changed
		$vAns = MsgBox ( $conMirrorR2L + 32 + 4, $gconProgName, "هل تريد حفظ التعديلات فى صفات الخط؟" ,0, $frmSelectFont)
		if $vAns = 7 Then Return ; if no
	EndIf
;MsgBox (0,$vAns, "saving")

	Local $lngBk_ID
	$as_SysFont [$lngID] = SetDefVal ( $a_FontSetting[0], $a_FontSetting[1], $a_FontSetting[2], $a_FontSetting[3], $a_FontSetting[4])

	Switch  $lngID
		Case $conFBibleAya, $conFBibleNum
			$lngBk_ID = 0
		Case $conFBibleWrdHead, $conFBibleWrd, $conFBibleWrdNum
			$lngBk_ID = 1
		Case Else
			$lngBk_ID = 2
	EndSwitch
	$as_BKColor [$lngBk_ID ] = "0x" & $a_FontSetting [5]
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func GetColorData ( $lngID )

	Local $nzSize = ReadDefVal ($as_SysFont[$lngID], $conPosSize) + 0
	Local $nzFontColor = ReadDefVal ($as_SysFont[$lngID], $conPosFColor)
	Local $lngFBColor = ReadDefVal ($as_SysFont[$lngID], $conPosBColor)
	Local $nzStyle = ReadDefVal ($as_SysFont[$lngID], $conPosAttr) + 0
	Local $szName = ReadDefVal ($as_SysFont[$lngID], $conPosFName)

	Local $lngBk_ID
	Switch  $lngID
		Case $conFBibleAya, $conFBibleNum
			$lngBk_ID = 0
		Case $conFBibleWrdHead, $conFBibleWrd, $conFBibleWrdNum
			$lngBk_ID = 1
		Case Else
			$lngBk_ID = 2
	EndSwitch

	Local $nzBKColor =  Hex($as_BKColor[$lngBk_ID], 6)

	Local $azFontData[6] = [$szName, $nzSize, $nzFontColor, $lngFBColor, $nzStyle, $nzBKColor]
	Return $azFontData
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func SetStyleList ( $a_SylSett, $lstCtrl, $lngStyle)
	Local	$nSelect = -1
	Local $i, $y
			For $y = 0 to _GUICtrlListBox_GetCount($lstCtrl) - 1
				 _GUICtrlListBox_SetSel($lstCtrl, $y, 0)
			Next

			For $i = 0 to UBound($a_SylSett)-1
				If BitAND( $lngStyle, $a_SylSett[$i][1]) Then
					For $y = 0 to _GUICtrlListBox_GetCount($lstCtrl) - 1
						If $a_SylSett[$i][0] = _GUICtrlListBox_GetText($lstCtrl, $y) Then
							$nSelect = _GUICtrlListBox_SetSel($lstCtrl, $y, -1)
						EndIf
						;MsgBox (0, $lngStyle,  _GUICtrlListBox_getSel($lstCtrl, $y)  & " y=" & $y)
					Next
				EndIf
			Next
	if 	$lngStyle = 0 then _GUICtrlListBox_SetSel($lstCtrl, 0)

EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func SetColorButton ( $Ctrl1, $ctrl2, $ctrl3, _
						$lbl1, $Lbl2, $Lbl3, $bStatus )
		local $bStat2 = $GUI_SHOW


		_GUICtrlButton_Show( $Ctrl1, $bStatus)
		_GUICtrlButton_Show( $Ctrl2, $bStatus)
		_GUICtrlButton_Show( $Ctrl3, $bStatus)

		if $bStatus = False then $bStatus = $GUI_Hide
		GUICtrlSetState ( $lbl1, $bStatus)
		GUICtrlSetState ( $lbl2, $bStatus)
		GUICtrlSetState ( $lbl3, $bStatus)

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
