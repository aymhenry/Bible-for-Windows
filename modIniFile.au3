#Include-once
;-============ Constant for style ===========
		Global Const $conStyleNormal = 0
		Global Const $conStyleBold = 1
		Global Const $conStyleItalic = 2
		Global Const $conStyleUnder = 4
		Global Const $conStyleSuper = 8

;--=========== Default Values  ==============

		Global Const $conFBibleAya    = 0
		Global Const $conFBibleNum    = 1
		Global Const $conFBibleWrdHead   = 2
		Global Const $conFBibleWrd = 3
		Global Const $conFBibleWrdNum = 4

		Global Const $conFBibleDicTit = 5
		Global Const $conFBibleDicTxt = 6

		Global Const $conFBibleAdd1 = 7
		Global Const $conFBibleAdd2 = 8

		Global Const $conFBibleDicTxt2 = 9

		Global Const $conFSrchTitle = 10			; Title in the bigening of Search
		Global Const $conFSrchAya = 11			; Aya in Search
		Global Const $conFSrchFoundAya = 12		; found aya
		Global Const $conFSrchAdrs = 13			; address of the found Aya

		Global Const $conKamosFontTit = 14			; address of the found Aya
		Global Const $conKamosFont = 15			; address of the found Aya

		Global Const $conMunuFont = 16			; address of the found Aya

		Global Const $as_DefalutFont [15+2] = [ _
					"033-0000FF-FFFFFF-0000-" & "Traditional Arabic", _		;  $conFBibleAya
					"019-000000-FFFF00-0008-" & "Traditional Arabic", _		;  $conFBibleNum
					"018-000000-FFFF00-0005-" & "Arial Black", _			;  $conFBibleWrdHead
					"018-000000-FFFF00-0000-" & "Arial Black", _			;  $conFBibleWrd
					"016-FF0000-FFFF00-0008-" & "Traditional Arabic", _		;  $conFBibleWrdNum
					"020-000000-FFFFFF-0005-" & "Arial", _					;  $conFBibleDicTit
					"014-000000-FFFFFF-0000-" & "Tahoma", _					;  $conFBibleDicTxt
					"018-000000-FFFFFF-0005-" & "Arial", _			;  $conFBibleAdd1
					"016-000000-FFFFFF-0005-" & "Arial", _			;  $conFBibleAdd2
					"014-000000-FFFFFF-0000-" & "Tahoma", _					;  $conFBibleDicTxt2
					"016-0000FF-FFFFFF-0004-" & "Arial", _		;  $conFSrchTitle   Traditional Arabic
					"016-000000-FFFFFF-0000-" & "Tahoma", _		;  $conFSrchAya
					"016-FF0000-FFFFFF-0005-" & "Arial", _		;  $conFSrchFoundAya
					"018-0000FF-FFFFFF-0005-" & "Arial", _		;  $conFSrchAdrs
					"014-0000FF-FFFFFF-0004-" & "Tahoma", _					;  $conKamosFontTit
					"012-000000-FFFFFF-0000-" & "Tahoma",  _				;  $conKamosFont
					"010-000000-FFFFFF-0000-" & "Tahoma" _					;  $conMunFont
					]

		Global Const $as_FontDesc[Ubound ($as_DefalutFont)] = [  _
						'نص الانجيل', 	 _		;0
						'ترقيم الايات بالانجيل', 	 _		;1
						'الكلمة الموضحة', _		;2
						'شرح الكلمات', 		 _		;3
						'ترقيم اية الشرح', 	 _		;4
						'التفسير - الشواهد', 	 _		;5
						'شرح الملاحظات', 	 _		;6
						'عنوان رئيسى', 	 _		;7
						'عنوان فرعى', 	 _		;8
						'سرد الشواهد', 	 _		;9
						'تقرير البحث الاولى', 	 _		;10
						'الاية ناتج البحث', 	 _		;11
						'النص ناتج البحث', 	 _		;12
						'رابط الشاهد- النص الفائق', 	 _		;13
						'العنوان بالقاموس' 	, _		;14
						'نتائج القاموس' 	, _		;15
						'خط نماذج البرنامج'    _		;16
						]


;-============ Constant back color =====================
		Global Const $as_DefalutBKColor [3] = [ 0xFFFFFF, 0xFFFF00, 0xFFFFFF]

;--=========== Variables Values  ==============
		Global $as_SysFont [ Ubound ($as_DefalutFont)]
		Global $as_BKColor [3 ]
		Global $strSearch_txt

;--=========== Section Names
		;---=========== Display         =============== to be removed later
		;Global Const $conSecDispSetting2 = "DispBible2"
		;Global Const $conSecDispSetting3 = "DispSearch"

		Global Const $conSecSrch		 = "Search"
			Global Const $conSecSrchKey	 = "SrchKey"

		Global Const $conSecTabInfo		 = "TabInfo"
			Global Const $conSecTabInfoKey	 = "Tab"
			Global Const $conSecTabInfoActiv = "ActiveTab"

		Global Const $conSecDispSetting = "DispBible1"
			Global Const $conLblDispFontName = "FontName"
			Global Const $conLblDispFontSize = "FontSize"

			Global Const $conLblDispColorFont = "FontColor"
			Global Const $conLblDispFontWeight = "FontWeight"

			Global Const $conLblDispFontAtt = "FontAttrib"
			Global Const $conLblDispColorBk = "BackColor"

		;---=========== Windows Postion ===============
		Global Const $conSecWinPos = "WinPos"

			Global Const $conLblDispWinWdth = "WindowsWidth"
			Global Const $conLblDispWinHigh = "WindowsHight"
			Global Const $conLblDispWinTop = "WindowsTop"
			Global Const $conLblDispWinLeft = "WindowsLeft"

			; --- Default Values

			Global Const $conDefDispWinWdth = @DesktopWidth  * 0.8	;740;640
			Global Const $conDefDispWinHigh = @DesktopHeight * 0.8;580;480


		;---=========== Bible Postion   ===============
		Global Const $conSecBiblePos = "BiblePos"

			;Global Const $conLblDispShowCont = "ShowCont"
			;Global Const $conLblDispShowAdd = "ShowAdd"
			;Global Const $conLblDispShowNum = "ShowNum"
			;Global Const $conLblDispShowTach = "ShowTach"

			; --- Default Values
			Global Const $conDefDispShowCont = 1
			Global Const $conDefDispShowAdd = 1
			Global Const $conDefDispShowNum = 1
			Global Const $conDefDispShowTach = 1

			Global const $conDefDispAya = 0

			Global const $conStartID = 047
			Global const $conDefDispAyaFrom = 1 ;0
			Global const $conDefDispAyaTo = 25; 0; to be checked  متى

		;===============================================================================================
			;-------------------------
			Global $a_Settings [9]; 0- contu text  1 yes 0 No default is 1
								  ; 1- With Number. 1 yes 0 No default is 1
								  ; 2- With Tach 0 without 1 default 0
								  ; 3- Bible Code
								  ; 4- Bible -chapter NO.
								  ; 5- by Aya if 0 show all chapter
								  ; 6- from Aya 5 has to be zero
								  ; 7- to Aya 5 has to be zero
								  ; 8- USE Add=1 oor not =0

			;-----------------------
			Global $plngWinWdth, $plngWinHigh, $plngWinLeft, $plngWinTop


;---------------------------------------------------------------------------------------------------------------------------
Func ReadSettings ()
	Local $nAllSet, $nAdd, $nCont, $nNum, $nTach ;CurCont () + 2* CurNum () + 4* CurTach () + 8*CurAdd()

	Local $iCount, $aArray
	;Local $lngReadData
	Local $strINI_Setting = FolderFileName ($gconINI_Setting, 1)
	;===== Display
		For $iCount = 0 to UBound ($as_SysFont ) - 1
			 $as_SysFont [$iCount] = IniRead ($strINI_Setting , $conSecDispSetting , "BibleFont" & $iCount, $as_DefalutFont [$iCount])
		Next

		For $iCount = 0 to UBound ($as_BKColor ) -1
			 $as_BKColor [$iCount] = IniRead ($strINI_Setting , $conSecDispSetting , "BackFont" & $iCount, $as_DefalutBKColor [$iCount])
		Next
		$as_SysFont [ $conMunuFont ] = SetDefVal ( ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosFName), _
												   ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosSize), _
												   Hex(_WinAPI_GetSysColor($COLOR_BTNTEXT) ,6), _
												   Hex(_WinAPI_GetSysColor($COLOR_WINDOW)  ,6), _
												   ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosAttr) )
		SetButAttr ( $as_SysFont )

	;====== Cont & Num & Tach  Setting
;		CurCont ( IniRead ($strINI_Setting , $conSecBiblePos , $conLblDispShowCont, $conDefDispShowCont ) )
;		CurAdd ( IniRead ($strINI_Setting , $conSecBiblePos , $conLblDispShowAdd, $conDefDispShowAdd ) )
;		CurNum  ( IniRead ($strINI_Setting , $conSecBiblePos , $conLblDispShowNum, $conDefDispShowNum   ) )
;		CurTach ( IniRead ($strINI_Setting , $conSecBiblePos , $conLblDispShowTach, $conDefDispShowTach ) )

		;MsgBox(0,0,"sdS")

		;CurCont (0)
		;CurAdd  (0)
		;CurNum  (0)
		;CurTach (0)

	;====== Tabs
		$aArray = IniReadSection($strINI_Setting , $conSecTabInfo)

		If @error <> 1 Then
			$plng_SettingTabs = $aArray[0][0] -1 ; zero based
			;_ArrayDisplay ( $aArray)
			For $iCount = 0 to $plng_SettingTabs ;$aArray[0][0]
				if $iCount > $pconMaxTabs then ExitLoop

				$a_hTabObject [$iCount] = $aArray [$iCount +1 ][1]
			Next

			;$nAllSet = BHex2Adrs (GetTabInfo ($a_hTabObject [0]), 6)
;ConsoleWrite ($nAllSet & " GetTabInfo ($a_hTabObject [0])====ini===>" &StringMid ($a_hTabObject [0],12,2)&  @CR)

			;$nAllSet = BHex2Adrs ( StringMid ($a_hTabObject [0],12,2), 6)
			$nAllSet = Dec( StringMid ($a_hTabObject [0],12,2) ) + 0

			CurCont ( BitAND ($nAllSet, 1) )
			CurNum  (BitAND ($nAllSet, 2) /2)
			CurTach ( BitAND ($nAllSet, 4)/4)
			CurAdd ( BitAND ($nAllSet, 8)/8)
;ConsoleWrite ($nAllSet & " Read ======ini===>" & $a_hTabObject [0] & "<======== CurAdd=" & CurAdd() & " CurCont=" & CurCont() & " CurNum=" & CurNum() & " CurTach=" & CurTach() & @CR)
		EndIf

		ChkTxtSetting () ; verfy txt data in $a_hTabObject Array copy it to a_Setting Array
	;======== WinPos
		$plngWinWdth = IniRead ($strINI_Setting , $conSecWinPos , $conLblDispWinWdth, $conDefDispWinWdth)
		$plngWinHigh = IniRead ($strINI_Setting , $conSecWinPos , $conLblDispWinHigh, $conDefDispWinHigh)

		$plngWinLeft = IniRead ($strINI_Setting , $conSecWinPos , $conLblDispWinLeft, -1)
		$plngWinTop  = IniRead ($strINI_Setting , $conSecWinPos , $conLblDispWinTop, -1)

		;MsgBox (0,0 , $plngWinLeft)
		;MsgBox (0,0 , $plngWinTop)

		If $plngWinWdth > @DesktopWidth or $plngWinHigh > @DesktopHeight Then ; this is other M/C
			$plngWdth    = $conDefDispWinWdth
			$plngWinHigh = $conDefDispWinHigh
			$plngWinLeft = 0.5 * (@DesktopWidth  - $conDefDispWinWdth)
			$plngWinTop =  0.33 * (@DesktopHeight - $conDefDispWinHigh)
		EndIf
	;======== Search
		$strSearch_txt  = IniRead ($strINI_Setting , $conSecSrch , $conSecSrchKey, "")
		$strSearch_txt = Hex2Uni ($strSearch_txt)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SaveSettings()
	Local $iCount
	Local $strINI_Setting = FolderFileName ($gconINI_Setting, 1)

	;====== Display
		For $iCount = 0 to UBound ( $as_SysFont ) - 1
			IniWrite ($strINI_Setting , $conSecDispSetting , "BibleFont" & $iCount, $as_SysFont [$iCount] )
		Next

		For $iCount = 0 to UBound ( $as_BKColor ) - 1
			IniWrite ($strINI_Setting , $conSecDispSetting , "BackFont" & $iCount, $as_BKColor [$iCount])
		Next
	;====== Bible Setting
		;ConsoleWrite ($strINI_Setting & "=")
		;IniWrite ($strINI_Setting , $conSecBiblePos , $conLblDispShowCont, CurCont ())  ; $a_Settings [0]
		;IniWrite ($strINI_Setting , $conSecBiblePos , $conLblDispShowAdd, CurAdd ()); $a_Settings [8]
		;IniWrite ($strINI_Setting , $conSecBiblePos , $conLblDispShowNum, CurNum ()); $a_Settings [1]
		;IniWrite ($strINI_Setting , $conSecBiblePos , $conLblDispShowTach, CurTach ());$a_Settings [2]

		IniDelete ($strINI_Setting , $conSecTabInfo )

		;MsgBox (0,"ini", $strINI_Setting)

		For $iCount = 0 to $plng_CreatedTabs
			IniWrite ($strINI_Setting , $conSecTabInfo, $conSecTabInfoKey & $iCount, $a_hTabObject [$iCount])
		Next
	;======== WinPos

	If BitAND (16,WinGetState ($gconProgNameBigName) ) = 0 Then ; Not minmize
		IniWrite ($strINI_Setting , $conSecWinPos , $conLblDispWinWdth, $plngWinWdth)
		IniWrite ($strINI_Setting , $conSecWinPos , $conLblDispWinHigh, $plngWinHigh)

		IniWrite ($strINI_Setting , $conSecWinPos , $conLblDispWinLeft, $plngWinLeft)
		IniWrite ($strINI_Setting , $conSecWinPos, $conLblDispWinTop, $plngWinTop)
	;======= Search
		IniWrite ($strINI_Setting , $conSecSrch, $conSecSrchKey, Uni2Hex ( $strSearch_txt))
	EndIf
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func Setting_Def ()
	Local $iCount

	if CurAdd () <> $conDefDispShowAdd Then
		DispSwapAdd ()
	EndIf

	if CurCont () <> $conDefDispShowCont Then
		DispSwapCont ()
	EndIf

	if CurNum () <> $conDefDispShowNum Then
		DispSwapNum ()
	EndIf

	if CurTach () <> $conDefDispShowTach Then
		DispSwapTach ()
	EndIf
	CurCont ($conDefDispShowCont)
	CurAdd ($conDefDispShowAdd)
	CurNum  ($conDefDispShowNum)
	CurTach ($conDefDispShowTach)

		For $iCount = 0 to UBound ( $as_SysFont ) - 1
			$as_SysFont [$iCount] = $as_DefalutFont [ $iCount ]
		Next

		$as_SysFont [ $conMunuFont ] = SetDefVal ( ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosFName), _
												   ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosSize), _
												   Hex(_WinAPI_GetSysColor($COLOR_BTNTEXT) ,6), _
												   Hex(_WinAPI_GetSysColor($COLOR_WINDOW)  ,6), _
												   ReadDefVal ( $as_SysFont [ $conMunuFont ], $conPosAttr) )
		SetButAttr ( $as_SysFont )

		For $iCount = 0 to UBound ( $as_BKColor ) - 1
			$as_BKColor [$iCount] = $as_DefalutBKColor [ $iCount ]
		Next

	UpdateTxt ()

EndFunc
;---------------------------------------------------------------------------------------------
Func SetButAttr (byRef $a_Data )
		;GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmSearch )
		$pstrMenuFont = ReadDefVal ( $a_Data [ $conMunuFont ], $conPosFName )
		$pstrMenuFSize  = ReadDefVal ( $a_Data [ $conMunuFont ], $conPosSize )

		$pstrMenuAttr =  ReadDefVal ( $a_Data [ $conMunuFont ], $conPosAttr) + 0
		$pstrMenuWeight = 200 * BitAND ( $pstrMenuAttr, 1) + 400
		$pstrMenuAttr = BitAND ( $pstrMenuAttr, 6)

		;ConsoleWrite ("$pstrMenuFSize =" & $pstrMenuFSize &  " $pstrMenuWeight=" &$pstrMenuWeight & " $pstrMenuAttr=" &  $pstrMenuAttr & " $pstrMenuFont=" &  $pstrMenuFont)
EndFunc
;---------------------------------------------------------------------------------------------
Func ChkTxtSetting ()
	Local $iCount, $strText
	Local $lngBib, $lngChp, $LngFlg, $LngAFr, $LngATo
	Local $lngMaxCh, $lngMaxAy
	Local $isError =  0

	For $iCount = 0 To $plng_SettingTabs ; zero based
		if $iCount = $plng_SearchDef Then ContinueLoop

		$strText = StringMid ($a_hTabObject [$iCount], StringLen ($conTab_TypeBible)+1 )
		;ConsoleWrite ( "start " & $strText & @CR)

		$lngBib = BHex2Adrs ($strText,1)
		$lngChp = BHex2Adrs ($strText,2)
		$LngFlg = BHex2Adrs ($strText,3)
		$LngAFr = BHex2Adrs ($strText,4)
		$LngATo = BHex2Adrs ($strText,5)

		if False = ChkIfValid ( $lngBib, $lngChp, $LngAFr, $LngATo) then
			$plng_SettingTabs = $iCount -1
			$isError = 0
			ExitLoop
		EndIf
;MsgBox (0,"tesr", 	$isError)
		if $iCount = 0 Then
			CurBible  ( $lngBib )
			CurChptr  ($lngChp )
			CurAyaChk ( $LngFlg )
			CurAyaFrom( $LngAFr )
			CurAyaTo  ( $LngATo )

		EndIf
		$isError = 1
	Next

	;MsgBox (0,"chk INI", $isError & "  at tab " & $iCount)

	if ($isError = 0) And ($plng_SettingTabs < 0 ) Then ; i.e $iCount > 0
		;$strText = StringMid ($a_hTabObject [$plng_BibleDef], StringLen ($conTab_TypeBible)+1 )
		;CurBible (-100)
			CurBible  ( $conStartID )
			CurChptr  ( $conStartNo )
			CurAyaChk ( $conDefDispAya )
			CurAyaFrom( $conDefDispAyaFrom )
			CurAyaTo  ( $conDefDispAyaTo )

			CurCont (1)
			CurAdd  (1)
			CurNum  (1)
			CurTach (1)

			$plng_SettingTabs = 0; i.e one tab
	EndIf
EndFunc
;---------------------------------------------------------------------------------------------
Func WrtTxtHeader ( $lngTab = $plng_CurrTabNo)

	If  $lngTab = $plng_SearchDef then Return

	Local $strText = $a_hTabObject [$lngTab]

	Local $lngBib = Dec (StringMid ($strText, 2,2 )) ; fist chr
	Local $lngChp = Dec (StringMid ($strText, 4,2 ))
	Local $LngFlg = Dec (StringMid ($strText, 6,2 ))
	Local $LngAFr = Dec (StringMid ($strText, 8,2 ))
	Local $LngATo = Dec (StringMid ($strText, 10,2 ))

	if $LngFlg <1 then
		if $LngAFr  = 0 Or $LngATo = 0 Then
			$strText =  $avArray[$lngBib] & " " & Num2India($lngChp)
		ELse
			$strText = $avArray[$lngBib] & " " & Num2India($lngChp) & " : " & Num2India($LngAFr ) & "-" & Num2India($LngATo)
		Endif
	Else
		$strText = $avArray[$lngBib] & " " & Num2India($lngChp) & " : " & Num2India($LngFlg )
	EndIf

	_GUICtrlTab_SetItemText($hTab, $lngTab,  $strText )
EndFunc
;---------------------------------------------------------------------------------------------
