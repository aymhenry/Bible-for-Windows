#Region Header


; Modificatio made see by Aym

#cs

	Title:			Color Picker Control UDF Library for AutoIt3
	Filename:		ColorPicker.au3
	Description:	Creates and manages an Color Picker control for the GUI
	Author:			Yashied
	Version:		1.3
	Requirements:	AutoIt v3.3 +, Developed/Tested on WindowsXP Pro Service Pack 2
	Uses:			GUIButton.au3, GUIImageList.au3, SendMessage.au3, StaticConstants.au3, WinAPI.au3, WindowsConstants.au3
	Notes:			The library registers (permanently) the following window message:

					WM_ACTIVATE
					WM_COMMAND
					WM_MOUSEWHEEL

	Available functions:

	_GUIColorPicker_Create
	_GUIColorPicker_Delete
	_GUIColorPicker_GetColor
	_GUIColorPicker_SetColor
	_GUIColorPicker_GetPalette
	_GUIColorPicker_SetPalette

	Example:

		#Include <ColorPicker.au3>

		Opt('MustDeclareVars', 1)

		Global $Form, $Label, $Msg, $Data, $Picker1, $Picker2, $Picker3

		$Form = GUICreate('Color Picker', 300, 200)

		; Create Picker1
		$Picker1 = _GUIColorPicker_Create('', 100, 50, 44, 44, 0xFF6600, BitOR($CP_FLAG_DEFAULT, $CP_FLAG_CHOOSERBUTTON, $CP_FLAG_TIP), 0, -1, -1, 'Simple Text')

		; Create custom (4 x 5) color palette
		Dim $aPalette[20] = _
			[0xFFFFFF, 0x000000, 0xC0C0C0, 0x808080, _
			 0xFF0000, 0x800000, 0xFFFF00, 0x808000, _
			 0x00FF00, 0x008000, 0x00FFFF, 0x008080, _
			 0x0000FF, 0x000080, 0xFF00FF, 0x800080, _
			 0xC0DCC0, 0xA6CAF0, 0xFFFBF0, 0xA0A0A4]

		; Create Picker2 with custom color palette
		$Picker2 = _GUIColorPicker_Create('', 7, 170, 50, 23, 0xFF00FF, BitOR($CP_FLAG_CHOOSERBUTTON, $CP_FLAG_ARROWSTYLE, $CP_FLAG_MOUSEWHEEL), $aPalette, 4, 5, '', 'More...')

		; Create custom (8 x 8) color palette
		Dim $aPalette[64]
		For $i = 0 To UBound($aPalette) - 1
			$aPalette[$i] = BitOR($i, BitShift($i * 4, -8), BitShift($i, -16))
		Next

		; Create Picker3 with custom color palette
		$Picker3 = _GUIColorPicker_Create('Color...', 223, 170, 70, 23, 0x2DB42D, BitOR($CP_FLAG_TIP, $CP_FLAG_MAGNIFICATION, $CP_FLAG_HANDCURSOR), $aPalette, 8, 8)
		$Label = GUICtrlCreateLabel('', 194, 171, 22, 22, 0x1000)
		GUICtrlSetBkColor(-1, 0x2DB42D)
		GUICtrlSetTip(-1, '2DB42D')

		GUISetState()

		While 1
			$Msg = GUIGetMsg()
			Switch $Msg ; Color Picker sends the message that the color is selected
				Case - 3
					ExitLoop
				Case $Picker1
					$Data = _GUIColorPicker_GetColor($Picker1, 1)
					If $Data[1] = '' Then
						$Data[1] = 'Custom'
					EndIf
					ConsoleWrite('Picker1: 0x' & Hex($Data[0], 6) & ' (' & $Data[1] &')' & @CR)
				Case $Picker2
					ConsoleWrite('Picker2: 0x' & Hex(_GUIColorPicker_GetColor($Picker2), 6) & @CR)
				Case $Picker3
					$Data = _GUIColorPicker_GetColor($Picker3)
					ConsoleWrite('Picker3: 0x' & Hex($Data, 6) & @CR)
					GUICtrlSetBkColor($Label, $Data)
					GUICtrlSetTip($Label, Hex($Data, 6))
			EndSwitch
		WEnd

#ce

#Include-once

#Include <GUIButton.au3>
#Include <GUIImageList.au3>
#Include <SendMessage.au3>
#Include <StaticConstants.au3>
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>

#EndRegion Header

#Region Global Variables and Constants

Global Const $CP_FLAG_CHOOSERBUTTON = 0x01
Global Const $CP_FLAG_TIP = 0x02
Global Const $CP_FLAG_MAGNIFICATION = 0x04
Global Const $CP_FLAG_ARROWSTYLE = 0x08
Global Const $CP_FLAG_HANDCURSOR = 0x10
Global Const $CP_FLAG_MOUSEWHEEL = 0x20
Global Const $CP_FLAG_DEFAULT = BitOR($CP_FLAG_MAGNIFICATION, $CP_FLAG_MOUSEWHEEL)

#EndRegion Global Variables and Constants

#Region Local Variables and Constants

Global Const $CP_WM_ACTIVATE = 0x0006
Global Const $CP_WM_COMMAND = 0x0111
Global Const $CP_WM_MOUSEWHEEL = 0x020A

Global Const $cpWidth = 8
Global Const $cpHeight = 5

Dim $cpPalette[$cpWidth * $cpHeight][2] = _
   [[0x000000, 'Black'   ], [0x993300, 'Brown'       ], [0x333300, 'Olive Green' ], [0x003300, 'Dark Green'  ], [0x003366, 'Dark Teal'      ], [0x000080, 'Dark Blue' ], [0x333399, 'Indigo'   ], [0x333333, 'Gray-80%'], _
	[0x800000, 'Dark Red'], [0xFF6600, 'Orange'      ], [0x808000, 'Dark Yellow' ], [0x008000, 'Green'       ], [0x008080, 'Teal'           ], [0x0000FF, 'Blue'      ], [0x666699, 'Blue-Gray'], [0x808080, 'Gray-50%'], _
	[0xFF0000, 'Red'     ], [0xFF9900, 'Light Orange'], [0x99CC00, 'Lime'        ], [0x339966, 'Sea Green'   ], [0x33CCCC, 'Aqua'           ], [0x3366FF, 'Light Blue'], [0x800080, 'Violet'   ], [0x999999, 'Gray-40%'], _
	[0xFF00FF, 'Pink'    ], [0xFFCC00, 'Gold'        ], [0xFFFF00, 'Yellow'      ], [0x00FF00, 'Bright Green'], [0x00FFFF, 'Turquoise'      ], [0x00CCFF, 'Sky Blue'  ], [0x993366, 'Plum'     ], [0xC0C0C0, 'Gray-25%'], _
	[0xFF99CC, 'Rose'    ], [0xFFCC99, 'Tan'         ], [0xFFFF99, 'Light Yellow'], [0xCCFFCC, 'Light Green' ], [0xCCFFFF, 'Light Turquoise'], [0x99CCFF, 'Pale Blue' ], [0xCC99FF, 'Lavender' ], [0xFFFFFF, 'White'   ]]

Dim $cpId[1][13] = [[0, 0, 0, 0]]

#cs

DO NOT USE THIS ARRAY IN THE SCRIPT, INTERNAL USE ONLY!

$cpId[0][0 ]   - Count item of array
	 [0][1 ]   - Reserved
	 [0][2 ]   - Handle to the "Color Picker" window
	 [0][3 ]   - Dummy control (controlID)
	 [0][4-12] - Don`t used

$cpId[i][0 ]   - The control identifier (controlID) as returned by GUICtrlCreateButton()
	 [i][1 ]   - Handle to the control (GUICtrlGetHandle($cpId[i][0]))
	 [i][2 ]   - Handle to the ImageList for further release
	 [i][3 ]   - Last selected color (in RGB)
	 [i][4 ]   - Custom palette
	 [i][5 ]   - Text of the button control
	 [i][6 ]   - Title of the "Color Picker" dialog box
	 [i][7 ]   - Flags
	 [i][8 ]   - Text of the button for the "Color Chooser" dialog box
	 [i][9 ]   - Width of the palette (in color items)
	 [i][10]   - Height of the palette (in color items)
	 [i][11]   - Width of the control
	 [i][12]   - Height of the control

#ce

#EndRegion Local Variables and Constants

#Region Initialization

; IMPORTANT! If you register the following window messages in your code, you should call handlers from this library until
; you return from your handlers, otherwise the Clor Picker controls will not work properly. For example:
;
; Func MY_WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
;   CP_WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
;   WM_MenuCOMMAND($hWnd, $iMsg, $wParam, $lParam)
;   ...
; EndFunc   ;==>MY_WM_COMMAND

GUIRegisterMsg($CP_WM_ACTIVATE, 'CP_WM_ACTIVATE')
GUIRegisterMsg($CP_WM_COMMAND, 'CP_WM_COMMAND')
GUIRegisterMsg($CP_WM_MOUSEWHEEL, 'CP_WM_MOUSEWHEEL')

#EndRegion Initialization

#Region Public Functions

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_Create
; Description....: Creates a Color Picker control for the GUI.
; Syntax.........: _GUIColorPicker_Create ( $sText, $iLeft, $iTop, $iWidth, $iHeight [, $iRGB [, $iFlags [, $aPalette [, $iWidthPalette [, $iHeightPalette [, $sTitle [, $sButton]]]]]]] )
; Parameters.....: $sText          - The text of the button control. If the value of this parameter is "" then the button will display the
;                                    rectangle with filled of current ($iRGB) color.
;                  $iLeft          - The left side of the control.
;                  $iTop           - The top of the control.
;                  $iWidth         - The width of the control.
;                  $iHeight        - The height of the control.
;                  $iRGB           - Default selected color (in RGB). Default is 0 (Black).
;                  $iFlags         - Defines the style of the dialog box. This parameter can be a combination of the following values.
;
;                                    $CP_FLAG_CHOOSERBUTTON
;                                    $CP_FLAG_TIP
;                                    $CP_FLAG_MAGNIFICATION
;                                    $CP_FLAG_ARROWSTYLE
;                                    $CP_FLAG_HANDCURSOR
;                                    $CP_FLAG_MOUSEWHEEL
;
;                                    (See constants section in this library)
;
;                  $aPalette       - Custom color palette. This parameter should be an array of Width x Height (see more) items containing the
;                                    values of colors for each label (in RGB). Default is 0 - uses a default palette.
;                  $iWidthPalette  - Width of the palette (in color items). Minimum value of - 4. Default is (-1) - uses a default width.
;                  $iHeightPalette - Height of the palette (in color items). Minimum value of - 4. Default is (-1) - uses a default height.
;                  $sTitle         - Title of the "Color Picker" dialog box. If the value of this parameter is "" then the title
;                                    will not be displayed. Default is "".
;                  $sButton        - The text of the button for the "Color Chooser" dialog box. Default is "Custom...".
; Return values..: Success         - 1
;                  Failure         - 0
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_Create($sText, $iLeft, $iTop, $iWidth, $iHeight, $iRGB = 0, $iFlags = -1, $aPalette = 0, _
		$iWidthPalette = -1, $iHeightPalette = -1, $sTitle = '', $sButton = '??????????') ; by Aym

	If $iFlags < 0 Then
		$iFlags = $CP_FLAG_DEFAULT
	EndIf

	$sText = StringStripWS($sText, 3)
	$sTitle = StringStripWS($sTitle, 3)
	$sButton = StringStripWS($sButton, 3)
	$iFlags = BitOR($iFlags, 0x0080 * (StringLen($sText) = 0), 0x0100 * (StringLen($sTitle) > 0))

	Local $ID = GUICtrlCreateButton($sText, $iLeft, $iTop, $iWidth, $iHeight)

	If $ID = 0 Then
		Return 0
	EndIf

	Local $aData, $hPrev, $hImageList, $hID = GUICtrlGetHandle($ID)

	If BitAND($iFlags, 0x0080) Then
		If BitAND($iFlags, $CP_FLAG_ARROWSTYLE) Then
			$aData = CP_CreateArrowBitmap($iRGB, $iWidth - 10, $iHeight - 10)
		Else
			$aData = CP_CreateSolidBitmap($iRGB, $iWidth - 10, $iHeight - 10)
		EndIf
		$hImageList = _GUIImageList_Create($iWidth - 10, $iHeight - 10, 5, 1)
		_GUIImageList_Add($hImageList, $aData[0], $aData[1])
		_GUICtrlButton_SetImageList($hID, $hImageList, 4)
		_WinAPI_DeleteObject($aData[0])
		_WinAPI_DeleteObject($aData[1])
	EndIf
	If $iWidthPalette < 4 Then
		$iWidthPalette = $cpWidth
	EndIf
	If $iHeightPalette < 4 Then
		$iHeightPalette = $cpHeight
	EndIf
	ReDim $cpId[$cpId[0][0] + 2][UBound($cpId, 2)]
	$cpId[0][0] += 1
	$cpId[$cpId[0][0]][0 ] = $ID
	$cpId[$cpId[0][0]][1 ] = $hID
	$cpId[$cpId[0][0]][2 ] = $hImageList
	$cpId[$cpId[0][0]][3 ] = $iRGB
	$cpId[$cpId[0][0]][4 ] = CP_ValidatePalette($aPalette, $iWidthPalette * $iHeightPalette, 0xFFFFFF)
	$cpId[$cpId[0][0]][5 ] = $sText
	$cpId[$cpId[0][0]][6 ] = $sTitle
	$cpId[$cpId[0][0]][7 ] = $iFlags
	$cpId[$cpId[0][0]][8 ] = $sButton
	$cpId[$cpId[0][0]][9 ] = $iWidthPalette
	$cpId[$cpId[0][0]][10] = $iHeightPalette
	$cpId[$cpId[0][0]][11] = $iWidth
	$cpId[$cpId[0][0]][12] = $iHeight
	Return $ID
EndFunc   ;==>_GUIColorPicker_Create

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_Delete
; Description....: Deletes a Color Picker control.
; Syntax.........: _GUIColorPicker_Delete ( $controlID )
; Parameters.....: $controlID - The control identifier (controlID) as returned by a _GUIColorPicker_Create() function.
; Return values..: Success    - 1
;                  Failure    - 0
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_Delete($controlID)
	For $i = 1 To $cpId[0][0]
		If $cpId[$i][0] = $controlID Then
			If Not GUICtrlDelete($cpId[$i][0]) Then
				Return 0
			EndIf
			If BitAND($cpId[$i][7], 0x0080) Then
				$cpId[$i][3] = -1
				CP_SetColor($i)
			EndIf
			For $j = $i To $cpId[0][0] - 1
				For $k = 0 To UBound($cpId, 2) - 1
					$cpId[$j][$k] = $cpId[$j + 1][$k]
				Next
			Next
			$cpId[0][0] -= 1
			ReDim $cpId[$cpId[0][0] + 1][UBound($cpId, 2)]
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>_GUIColorPicker_Delete

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_GetColor
; Description....: Retrieves the selected color of the Color Picker control.
; Syntax.........: _GUIColorPicker_GetColor ( $controlID )
; Parameters.....: $controlID - The control identifier (controlID) as returned by a _GUIColorPicker_Create() function.
;                  $iFlag     - Determines return type, valid values:
;                  |0 - Returns value (in RGB) of the selected color (Default)
;                  |1 - Returns array of two elements ([0] - RGB color, [1] - name of color)
; Return values..: Success    - Value depending on the $iFlag flag.
;                  Failure    - (-1)
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_GetColor($controlID, $iFlag = 0)

	Local $Data, $Palette, $Name = ''

	For $i = 1 To $cpId[0][0]
		If $cpId[$i][0] = $controlID Then
			If $iFlag Then
				$Palette = $cpId[$i][4]
				For $j = 0 To UBound($Palette) - 1
					If $cpId[$i][3] = $Palette[$j][0] Then
						$Name = $Palette[$j][1]
						ExitLoop
					EndIf
				Next
				Dim $Data[2] = [$cpId[$i][3], $Name]
				Return $Data
			Else
				Return $cpId[$i][3]
			EndIf
		EndIf
	Next
	Return -1
EndFunc   ;==>_GUIColorPicker_GetColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_SetColor
; Description....: Sets the color for the Color Picker control.
; Syntax.........: _GUIColorPicker_SetColor ( $controlID, $iRGB )
; Parameters.....: $controlID - The control identifier (controlID) as returned by a _GUIColorPicker_Create() function.
;                  $iRGB      - The RGB color to use.
; Return values..: Success    - 1
;                  Failure    - 0
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_SetColor($controlID, $iRGB)
	For $i = 1 To $cpId[0][0]
		If $cpId[$i][0] = $controlID Then
			$cpId[$i][3] = $iRGB
			If BitAND($cpId[$i][7], 0x0080) Then
				CP_SetColor($i)
			EndIf
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>_GUIColorPicker_SetColor

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_GetPalette
; Description....: Retrieves the current palette of the Color Picker control.
; Syntax.........: _GUIColorPicker_GetPalette ( $controlID [, $iFlag])
; Parameters.....: $controlID - The control identifier (controlID) as returned by a _GUIColorPicker_Create() function.
;                  $iFlag     - Determines return type, valid values:
;                  |0 - Returns 1D array consisting of the values of color only (Default)
;                  |1 - Returns 2D array consisting of the values of color and its name
; Return values..: Success    - Array of RGB colors for the current palette.
;                  Failure    - 0
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_GetPalette($controlID, $iFlag = 0)

	Local $Data, $Palette

	For $i = 1 To $cpId[0][0]
		If $cpId[$i][0] = $controlID Then
			If $iFlag Then
				Return $cpId[$i][4]
			Else
				$Palette = $cpId[$i][4]
				Dim $Data[UBound($Palette)]
				For $i = 0 To UBound($Palette) - 1
					$Data[$i] = $Palette[$i][0]
				Next
				Return $Data
			EndIf
		EndIf
	Next
	Return 0
EndFunc   ;==>_GUIColorPicker_GetPalette

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIColorPicker_SetPalette
; Description....: Sets the palette for the Color Picker control.
; Syntax.........: _GUIColorPicker_SetPalette ( $controlID, $aPalette )
; Parameters.....: $controlID - The control identifier (controlID) as returned by a _GUIColorPicker_Create() function.
;                  $aPalette  - Array of RGB colors for the palette to use. Dimension of the array should be Width x Height (See _GUIColorPicker_Create()).
; Return values..: Success    - 1
;                  Failure    - 0
; Author.........: Yashied
; Modified.......:
; Remarks........:
; Related........:
; Link...........:
; Example........: Yes
; ===============================================================================================================================

Func _GUIColorPicker_SetPalette($controlID, $aPalette)
	For $i = 1 To $cpId[0][0]
		If $cpId[$i][0] = $controlID Then
			$cpId[$i][4] = CP_ValidatePalette($aPalette, $cpId[$i][9] * $cpId[$i][10], 0xFFFFFF)
			Return 1
		EndIf
	Next
	Return 0
EndFunc   ;==>_GUIColorPicker_SetPalette

#EndRegion Public Functions

#Region Internal Functions

Func CP_CreateArrowBitmap($iRGB, $iWidth, $iHeight)

	Local $hDC, $hBackDC, $hFrontDC, $hFront, $hBack, $hPen
	Local $aData[2]

	$hDC = _WinAPI_GetDC(0)
	$hBackDC = _WinAPI_CreateCompatibleDC($hDC)
	$hBack = _WinAPI_CreateSolidBitmap(0, 0x000000, $iWidth, $iHeight)
	_WinAPI_SelectObject($hBackDC, $hBack)
	$hFrontDC = _WinAPI_CreateCompatibleDC($hDC)
	$hFront = _WinAPI_CreateSolidBitmap(0, 0xFFFFFF, $iWidth - 11, $iHeight)
	_WinAPI_SelectObject($hFrontDC, $hFront)
	_WinAPI_BitBlt($hBackDC, 0, 0, $iWidth - 11, $iHeight, $hFrontDC, 0, 0, $SRCCOPY)
	_WinAPI_DeleteObject($hFront)
	$hFront = _WinAPI_CreateSolidBitmap(0, $iRGB, $iWidth - 11 - 2, $iHeight - 2)
	_WinAPI_SelectObject($hFrontDC, $hFront)
	_WinAPI_BitBlt($hBackDC, 1, 1, $iWidth - 11 - 2, $iHeight - 2, $hFrontDC, 0, 0, $SRCCOPY)
	$aData[0] = $hBack
	_WinAPI_DeleteObject($hFront)
	$hBack = _WinAPI_CreateSolidBitmap(0, 0xFFFFFF, $iWidth, $iHeight)
	_WinAPI_SelectObject($hBackDC, $hBack)
	$hFront = _WinAPI_CreateSolidBitmap(0, 0x000000, $iWidth - 11, $iHeight)
	_WinAPI_SelectObject($hFrontDC, $hFront)
	_WinAPI_BitBlt($hBackDC, 0, 0, $iWidth - 11, $iHeight, $hFrontDC, 0, 0, $SRCCOPY)
	_WinAPI_DeleteObject($hFront)
	$hPen = _WinAPI_CreatePen($PS_SOLID, 1, 0x000000)
	_WinAPI_SelectObject($hBackDC, $hPen)
	For $i = 1 To 4
		_WinAPI_DrawLine($hBackDC, $iWidth - $i - 4, Int($iHeight / 2) + Mod($iHeight, 2) - $i + 2, $iWidth + $i - 5, Int($iHeight / 2) + Mod($iHeight, 2) - $i + 2)
	Next
	$aData[1] = $hBack
	_WinAPI_DeleteObject($hPen)
	_WinAPI_ReleaseDC(0, $hDC)
	_WinAPI_DeleteDC($hFrontDC)
	_WinAPI_DeleteDC($hBackDC)
	Return $aData
EndFunc   ;==>CP_CreateArrowBitmap

Func CP_CreateSolidBitmap($iRGB, $iWidth, $iHeight)

	Local $hDC, $hBackDC, $hFrontDC, $hFront, $hBack
	Local $aData[2]

	$hDC = _WinAPI_GetDC(0)
	$hBackDC = _WinAPI_CreateCompatibleDC($hDC)
	$hBack = _WinAPI_CreateSolidBitmap(0, 0xFFFFFF, $iWidth, $iHeight)
	_WinAPI_SelectObject($hBackDC, $hBack)
	$hFrontDC = _WinAPI_CreateCompatibleDC($hDC)
	$hFront = _WinAPI_CreateSolidBitmap(0, $iRGB, $iWidth - 2, $iHeight - 2)
	_WinAPI_SelectObject($hFrontDC, $hFront)
	_WinAPI_BitBlt($hBackDC, 1, 1, $iWidth - 2, $iHeight - 2, $hFrontDC, 0, 0, $SRCCOPY)
	$aData[0] = $hBack
	$aData[1] = 0
	_WinAPI_DeleteObject($hFront)
	_WinAPI_ReleaseDC(0, $hDC)
	_WinAPI_DeleteDC($hFrontDC)
	_WinAPI_DeleteDC($hBackDC)
	Return $aData
EndFunc   ;==>CP_CreateSolidBitmap

Func CP_ColorChooserDlg($iRGB, $hWnd)

	Local Const $CC_ANYCOLOR = 0x100
	Local Const $CC_FULLOPEN = 0x2
	Local Const $CC_RGBINIT = 0x1

	Local $tCHOOSECOLOR = DllStructCreate($tagCHOOSECOLOR)
	Local $tCC = DllStructCreate('int[16]')

	DllStructSetData($tCHOOSECOLOR, 'Size', DllStructGetSize($tCHOOSECOLOR))
	DllStructSetData($tCHOOSECOLOR, 'hWndOwnder', $hWnd)
	DllStructSetData($tCHOOSECOLOR, 'rgbResult', CP_SwitchColor($iRGB))
	DllStructSetData($tCHOOSECOLOR, 'CustColors', DllStructGetPtr($tCC))
	DllStructSetData($tCHOOSECOLOR, 'Flags', BitOR($CC_ANYCOLOR, $CC_FULLOPEN, $CC_RGBINIT))

	Local $Ret = DllCall('comdlg32.dll', 'long', 'ChooseColor', 'ptr', DllStructGetPtr($tCHOOSECOLOR))

	If $Ret[0] = 0 Then
		Return -1
	EndIf
	Return CP_SwitchColor(DllStructGetData($tCHOOSECOLOR, 'rgbResult'))
EndFunc   ;==>CP_ColorChooserDlg

Func CP_Index($controlID, ByRef $aData)
	For $i = 0 To UBound($aData) - 1
		If $aData[$i] = $controlID Then
			Return $i
		EndIf
	Next
	Return -1
EndFunc   ;==>CP_Index

Func CP_PickerDlg($ID)

	Local $Msg, $X, $Y, $Index, $Mouse, $Rgb, $Size, $Active = 0, $Custom = -1, $Result = 0, $Pressed = False
	Local $Label[$cpId[$ID][9] * $cpId[$ID][10]]
	Local $Width = 25 * $cpId[$ID][9] + 3, $Height = 25 * $cpId[$ID][10] + 3
	Local $dH = 28 * (BitAND($cpId[$ID][7], 0x0100) = 0x0100)
	Local $hParent = _WinAPI_GetParent($cpId[$ID][1])
	Local $tRECT = _WinAPI_GetWindowRect($cpId[$ID][1])
	Local $GUIOnEventMode = Opt('GUIOnEventMode', 0)
	Local $GUICloseOnESC = Opt('GUICloseOnESC', 1)
	Local $Taskbar = CP_TaskbarHeight()
	Local $Palette = $cpId[$ID][4]

	$X = DllStructGetData($tRECT, 1)
	$Y = DllStructGetData($tRECT, 4)
	If $X < 0 Then
		$X = 0
	EndIf
	If $X > @DesktopWidth - ($Width + 6) Then
		$X = @DesktopWidth - ($Width + 6)
	EndIf
	If $Y < 0 Then
		$Y = 0
	EndIf
	If $Y > @DesktopHeight - $Taskbar - $dH - 28 * BitAND($cpId[$ID][7], $CP_FLAG_CHOOSERBUTTON) - ($Height + 6) Then
		$Y = @DesktopHeight - $Taskbar - $dH - 28 * BitAND($cpId[$ID][7], $CP_FLAG_CHOOSERBUTTON) - ($Height + 6)
	EndIf
	$cpId[0][2] = GUICreate('', $Width, $Height + $dH + 28 * BitAND($cpId[$ID][7], $CP_FLAG_CHOOSERBUTTON), $X, $Y, $WS_POPUP, $WS_EX_DLGMODALFRAME + _
							  $WS_EX_LAYOUTRTL, $hParent) ; $WS_EX_LAYOUTRTL by Aym
;	GUISetBkColor(0xFCFCFC, $cpId[0][2])
	If BitAND($cpId[$ID][7], 0x0100) Then
		GUICtrlCreateLabel('', 4, 4, $Width - 8, 23, $SS_GRAYFRAME)
		GUICtrlCreateLabel($cpId[$ID][6], 6, 9, $Width - 12, 14, $SS_CENTER)
		GUICtrlSetFont(-1, 8.5, 400, 0, 'MS Shell Dlg')
	EndIf
	For $i = 1 To $cpId[$ID][10]
		For $j = 1 To $cpId[$ID][9]
			$Index = ($i - 1) * $cpId[$ID][9] + $j - 1
			If ($Active = 0) And ($cpId[$ID][3] = $Palette[$Index][0]) And (BitAND($cpId[$ID][7], $CP_FLAG_MAGNIFICATION)) Then
				$Label[$Index] = GUICtrlCreateLabel('', 2 + ($j - 1) * 25, 2 + $dH + ($i - 1) * 25, 24, 24, $SS_SUNKEN)
				$Active = $Label[$Index]
			Else
				$Label[$Index] = GUICtrlCreateLabel('', 4 + ($j - 1) * 25, 4 + $dH + ($i - 1) * 25, 20, 20, $SS_SUNKEN)
			EndIf
			GUICtrlSetBkColor(-1, $Palette[$Index][0])
			If BitAND($cpId[$ID][7], $CP_FLAG_HANDCURSOR) Then
				GUICtrlSetCursor(-1, 0)
			EndIf
			If BitAND($cpId[$ID][7], $CP_FLAG_TIP) Then
				GUICtrlSetTip(-1, $Palette[$Index][1])
			EndIf
		Next
	Next
	$cpId[0][3] = GUICtrlCreateDummy()
	If BitAND($cpId[$ID][7], $CP_FLAG_CHOOSERBUTTON) Then
		$Custom = GUICtrlCreateButton('', 0, 0)
		$Size = CP_StringSize($Custom, $cpId[$ID][8]) + 24
		If $Size > $Width - 6 Then
			$Size = $Width - 6
		EndIf
		GUICtrlSetPos(-1, Int(($Width - $Size) / 2), $Height + 2 + $dH, $Size + Mod($Width - $Size, 2), 21)
		GUICtrlSetFont(-1, 8.5, 400, 0, 'MS Shell Dlg')
		GUICtrlSetData(-1, $cpId[$ID][8])
	EndIf

	GUISetState(@SW_SHOW, $cpId[0][2])

	While 1
		$Mouse = GUIGetCursorInfo($cpId[0][2])
		If BitXOR($Active, $Mouse[4]) Then
			If Not $Mouse[2] Then
				For $i = 0 To UBound($Label) - 1
					If $Mouse[4] = $Label[$i] Then
						If BitAND($cpId[$ID][7], $CP_FLAG_MAGNIFICATION) Then
							$Index = CP_Index($Active, $Label)
							GUICtrlSetPos($Active, 4 + Mod($Index, $cpId[$ID][9]) * 25, 4 + $dH + ($Index - Mod($Index, $cpId[$ID][9])) / $cpId[$ID][9] * 25, 20, 20)
							GUICtrlSetPos($Label[$i], 2 + Mod($i, $cpId[$ID][9]) * 25, 2 + $dH + ($i - Mod($i, $cpId[$ID][9])) / $cpId[$ID][9] * 25, 24, 24)
						EndIf
						$Active = $Label[$i]
						ExitLoop
					EndIf
				Next
			EndIf
		Else
			If ($Mouse[2]) And (Not $Pressed) Then
				$Index = CP_Index($Mouse[4], $Label)
				If $Index > -1 Then
					$cpId[$ID][3] = $Palette[$Index][0]
					$Result = 2
					ExitLoop
				EndIf
			EndIf
		EndIf
		$Pressed = $Mouse[2]
		$Msg = GUIGetMsg()
		Switch $Msg
			Case -3, $cpId[0][3]
				ExitLoop
			Case $Custom
				$Result = 1
				ExitLoop
		EndSwitch
	WEnd

	GUIDelete($cpId[0][2])

	$cpId[0][2] = 0
	$cpId[0][3] = 0

	Opt('GUIOnEventMode', $GUIOnEventMode)
	Opt('GUICloseOnESC', $GUICloseOnESC)

	Switch $Result
		Case 0
			Return 0
		Case 1
			$Rgb = CP_ColorChooserDlg($cpId[$ID][3], $hParent)
			If $Rgb < 0 Then
				_WinAPI_SetFocus($cpId[$ID][1])
				Return 0
			EndIf
			$cpId[$ID][3] = $Rgb
			ContinueCase
		Case 2
			If BitAND($cpId[$ID][7], 0x0080) Then
				CP_SetColor($ID)
			EndIf
	EndSwitch
	_WinAPI_SetFocus($cpId[$ID][1])
	Return 1
EndFunc   ;==>CP_PickerDlg

Func CP_SetColor($ID)

	Local $aData

	If $cpId[$ID][3] < 0 Then
		_GUIImageList_Destroy($cpId[$ID][2])
	Else
		If BitAND($cpId[$ID][7], $CP_FLAG_ARROWSTYLE) Then
			$aData = CP_CreateArrowBitmap($cpId[$ID][3], $cpId[$ID][11] - 10, $cpId[$ID][12] - 10)
		Else
			$aData = CP_CreateSolidBitmap($cpId[$ID][3], $cpId[$ID][11] - 10, $cpId[$ID][12] - 10)
		EndIf
		_GUIImageList_Remove($cpId[$ID][2])
		_GUIImageList_Add($cpId[$ID][2], $aData[0], $aData[1])
		_GUICtrlButton_SetImageList($cpId[$ID][1], $cpId[$ID][2], 4)
		_WinAPI_DeleteObject($aData[0])
		_WinAPI_DeleteObject($aData[1])
	EndIf
EndFunc   ;==>CP_SetColor

Func CP_StringSize($hWnd, $sText)

	If Not IsHWnd($hWnd) Then
		$hWnd = GUICtrlGetHandle($hWnd)
		If $hWnd = 0 Then
			Return SetError(1, 0, 0)
		EndIf
	EndIf

	Local $hDC, $hFont, $hOld, $tSize

	$hDC = _WinAPI_GetDC($hWnd)
	$hFont = _SendMessage($hWnd, $WM_GETFONT)
	$hOld = _WinAPI_SelectObject($hDC, $hFont)
	$tSize = _WinAPI_GetTextExtentPoint32($hDC, $sText)
	_WinAPI_SelectObject($hDC, $hOld)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Return SetError(0, 0, DllStructGetData($tSize, 1))
EndFunc   ;==>CP_StringSize

Func CP_SwitchColor($iRGB)
	Return BitOR(BitAND($iRGB, 0x00FF00), BitShift(BitAND($iRGB, 0x0000FF), -16), BitShift(BitAND($iRGB, 0xFF0000), 16))
EndFunc   ;==>CP_SwitchColor

Func CP_TaskbarHeight()

	Local $Ret, $tRECT = DllStructCreate('int;int;int;int')
	Local $Ret = DllCall('user32.dll', 'int', 'SystemParametersInfo', 'int', 48, 'int', 0, 'ptr', DllStructGetPtr($tRECT), 'int', 0)

	If (@error) Or ($Ret[0] = 0) Then
		Return SetError(1, 0, 0)
	EndIf
	Return @DesktopHeight - DllStructGetData($tRECT, 4)
EndFunc   ;==>CP_TaskbarHeight

Func CP_ValidatePalette($aPalette, $iSize, $iRGB = 0)

	If Not IsArray($aPalette) Then
		$aPalette = $cpPalette
	EndIf

	Local $Data, $Dim = UBound($aPalette)

	Dim $Data[$Dim][2]
	Switch UBound($aPalette, 2)
		Case 0
			For $i = 0 To $Dim - 1
				$Data[$i][0] = $aPalette[$i]
				$Data[$i][1] = Hex($aPalette[$i], 6)
			Next
		Case 1
			For $i = 0 To $Dim - 1
				$Data[$i][0] = $aPalette[$i][0]
				$Data[$i][1] = Hex($aPalette[$i], 6)
			Next
		Case Else
			For $i = 0 To $Dim - 1
				$Data[$i][0] = $aPalette[$i][0]
				$Data[$i][1] = $aPalette[$i][1]
			Next
	EndSwitch
	Select
		Case $Dim > $iSize
			ReDim $Data[$Dim][2]
		Case $Dim < $iSize
			ReDim $Data[$iSize][2]
			For $i = $Dim To $iSize - 1
				$Data[$i][0] = $iRGB
				$Data[$i][1] = Hex($iRGB, 6)
			Next
	EndSelect
	Return $Data
EndFunc   ;==>CP_ValidatePalette

#EndRegion Internal Functions

#Region Windows Message Functions

Func CP_WM_ACTIVATE($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $cpId[0][2]
			Switch BitAND($wParam, 0xFFFF)
				Case 0
					GUICtrlSendToDummy($cpId[0][3])
			EndSwitch
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>CP_WM_ACTIVATE

Func CP_WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	;If 1= WM_MenuCOMMAND($hWnd, $iMsg, $wParam, $lParam) then Return ; if the funtion is used
	WM_MenuCOMMAND($hWnd, $iMsg, $wParam, $lParam)

	For $i = 1 To $cpId[0][0]
		If $cpId[$i][1] = $lParam Then
			If Number($wParam) > 0 Then
				If Not CP_PickerDlg($i) Then
					Return 0
				EndIf
			EndIf
			ExitLoop
		EndIf
	Next
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>CP_WM_COMMAND

Func CP_WM_MOUSEWHEEL($hWnd, $iMsg, $wParam, $lParam)

	Local $Focus = _WinAPI_GetFocus()

	For $i = 1 To $cpId[0][0]
		If ($cpId[$i][1] = $Focus) And (BitAND($cpId[$i][7], BitOR($CP_FLAG_MOUSEWHEEL, 0x0080)) = BitOR($CP_FLAG_MOUSEWHEEL, 0x0080)) Then

			Local $Palette = $cpId[$i][4]
			Local $Pos, $Index = 0, $Max = UBound($Palette) - 1
			Local $Wheel = BitShift($wParam, 16) / 120

			For $j = 0 To $Max
				If $cpId[$i][3] = $Palette[$j][0] Then
					$Index = $j
					ExitLoop
				EndIf
			Next
			$Pos = $Index - $Wheel
			If $Pos < 0 Then
				$Pos = 0
			EndIf
			If $Pos > $Max Then
				$Pos = $Max
			EndIf
			If BitXOR($Pos, $Index) Then
				$cpId[$i][3] = $Palette[$Pos][0]
				CP_SetColor($i)
				_WinAPI_SetFocus($cpId[$i][1])
				_SendMessage($hWnd, $CP_WM_COMMAND, 0, $cpId[$i][1])
			EndIf
		EndIf
	Next
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>CP_WM_MOUSEWHEEL

#EndRegion Windows Message Functions

