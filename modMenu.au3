Global $hToolbar

Dim $iMemo
;Dim $iItem ; Command identifier of the button associated with the notification.

	Global $hStatus, $hMain
	Global Const $mnc2SubMenu2Start = 2000
	Global Const $mnc2SubMenu2End = 2199 ; max no. of aya is 21-119 ayas=176 المزامير

	Global Const $mnc2SubMenu3Start = 2200
	Global Const $mnc2SubMenu3End = 2399 ; max no. of chptr ayas=151 المزامير

	Global Const $mncSubMenuStart = 5500
	Global Const $mncSubMenuEnd   = 5700

	Global Enum $mnc_FileClose = 5000,  $mnc_FileSort, $mnc_FileBible, $mnc_SubMenu, $mnc_FileMap, $mnc_ViewPrev, $mnc_ViewNext
	Global Enum $mn2_EditSearch = 6000, $mn2_EditKamos, $mn2_ViewShahd, $mn2_EditCopy, $mn2_FileSaveAs, $mn2_ViewPrev, $mn2_ViewNext, $mn2_SubMenu1, $mn2_SubMenu2

	Global Enum $idTB_FileBible = 4000, $idTB_FileMap, $idTB_ViewShahd, $idTB_FileSaveAs, $idTB_FilePrint, $idTB_FileSearch,  _
				$idTB_ViewTach, $idTB_ViewCount, $idTB_ViewNum, $idTB_ViewAya, $idTB_ViewAdd, $idTB_EditKamos, $idTB_ViewPrev, $idTB_ViewNext

	Global Const $idSubMenuStart = 1500
	Global Const $idSubMenuEnd   = 1700

	Global $idView_SubMenu
	Global Enum $idFileBible    = 1000, $idFileMap, $idFileSaveAs, $idFilePrint,$idFileSort, $idFileClose, $idFileExit , _
				$idEditSelectAll, 		     $idEditUnSelect,   $idEditCopy,  $idEditSearch, $idEditKamos, _
				$idViewFont,  $idViewNum,    $idViewCount,      $idViewTach,  $idViewAya,    $idViewAdd,  $idViewGoto, $idViewPrev, $idViewNext, $idViewShahd, $idViewDef, _
				$idFavAdd, 	  $idFavManag, _
				$idHelpOfcPage,$idHelpWrtComment, $idHelpChkUpdate, $idHelpPage,	$idHelpLoadPage,  $idHelpKamosPage,  $idHelpAbout

	Global $hFile, $hView
	;---
	Const $lng_NoToolbar = 14
	Const $lngICOSize = 16+8

	Const $icoID_Bible = 4
	Const $icoID_SaveAs = 6
	Const $icoID_Print = 7
	Const $icoID_Search = 8
	Const $icoID_Kamos = 14
	Const $icoID_Address = 13
	Const $icoID_Count = 10
	Const $icoID_Num = 11
	Const $icoID_Tach = 9
	Const $icoID_Aya = 12
	Const $icoID_Shahd = 5
	Const $icoID_Prev = 15
	Const $icoID_Next = 16
	Const $icoID_Map = 17
	Const $icoID_Copy = 18
	Const $icoID_ChkUpdate = 19
	;Const $icoID_Protect = 20
;---------------------------------------------------------------------------------------------------------------------------
Func MainMenu(ByRef $hGUI)

	Local $hEdit, $hFav, $hHelp
	Local $bStatNum, $bStatTash, $bStatAya, $bStatCont, $bStatAdd

	;--------------------------
	$idView_SubMenu = _GUICtrlMenu_CreateMenu ()
	;--------------------------

	; Create File menu
	$hFile = _GUICtrlMenu_CreateMenu ()
	_GUICtrlMenu_InsertMenuItem ($hFile, 0, "فتح إن&جيل ...   F2", $idFileBible)
	_GUICtrlMenu_InsertMenuItem ($hFile, 1,"خريطة الكتاب" 		    , $idFileMap )
	_GUICtrlMenu_InsertMenuItem ($hFile, 2,""		    , 0 )
	_GUICtrlMenu_InsertMenuItem ($hFile, 3, "&حفظ باسم ..."      , $idFileSaveAs)
	_GUICtrlMenu_InsertMenuItem ($hFile, 4, "&طباعة ..."         , $idFilePrint)
	_GUICtrlMenu_InsertMenuItem ($hFile, 5, ""                   , 0)
	_GUICtrlMenu_InsertMenuItem ($hFile, 7, "ترتيب الشرائط"  , $idFileSort)
	_GUICtrlMenu_InsertMenuItem ($hFile, 8, "إغلاق الشريط" & "   Ctrl+W"       , $idFileClose)
	_GUICtrlMenu_InsertMenuItem ($hFile, 9, ""                   , 0)
	_GUICtrlMenu_InsertMenuItem ($hFile, 10, "&خروج"              , $idFileExit)

	; Create Edit menu
	$hEdit = _GUICtrlMenu_CreateMenu (1)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 0, "تحديد الكل"  	, $idEditSelectAll)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 1, "إلغاء التحديد" , $idEditUnSelect)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 2, "&نسخ"    , $idEditCopy)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 3, ""                   , 0)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 4, "بحث فى الكتاب المقدس"  & " F3", $idEditSearch)
	_GUICtrlMenu_InsertMenuItem ($hEdit, 5, "بحث فى قاموس الكتاب"  & "   F4", $idEditKamos)

	; Create View menu
	$hView = _GUICtrlMenu_CreateMenu (1+2)
	_GUICtrlMenu_InsertMenuItem ($hView, 0, "ال&خــط"		    , $idViewFont)
	_GUICtrlMenu_InsertMenuItem ($hView, 1, ""                   , 0)

	_GUICtrlMenu_InsertMenuItem ($hView, 2, "التفسير التطبيقى للكتاب"  , $idViewAya)
	_GUICtrlMenu_InsertMenuItem ($hView, 3, ""                   , 0)

	_GUICtrlMenu_InsertMenuItem ($hView, 4, "عناويين الاح&داث" 	, $idViewAdd)
	_GUICtrlMenu_InsertMenuItem ($hView, 5, "ن&ص مستمر"     	, $idViewCount)
	_GUICtrlMenu_InsertMenuItem ($hView, 6, "&ترقـيم الآيــات"	, $idViewNum)
	_GUICtrlMenu_InsertMenuItem ($hView, 7, "ت&شـكيل الحـروف"	, $idViewTach)
	_GUICtrlMenu_InsertMenuItem ($hView, 8, ""                  , 0)

	_GUICtrlMenu_InsertMenuItem ($hView, 9, "إذهـب ألى ..."	, $idViewGoto, $idView_SubMenu)
	_GUICtrlMenu_InsertMenuItem ($hView,10, "السابق" & "           PgUp"	, $idViewPrev)
	_GUICtrlMenu_InsertMenuItem ($hView,11, "التالى " & "            PgDn"	, $idViewNext)
	_GUICtrlMenu_InsertMenuItem ($hView,12, ""                   , 0)

	_GUICtrlMenu_InsertMenuItem ($hView,13, "الشـواهـد"			, $idViewShahd)
	_GUICtrlMenu_InsertMenuItem ($hView,14, "الاعدادات الافتراضية"	, $idViewDef)

	; Create Fav menu
	$hFav = _GUICtrlMenu_CreateMenu (1)
	_GUICtrlMenu_InsertMenuItem ($hFav, 0,"إضافة للمفضلات"		    , $idFavAdd)
	_GUICtrlMenu_InsertMenuItem ($hFav, 1,"تنظيم  المفضلات"		    , $idFavManag)

	; Create Help menu
	$hHelp = _GUICtrlMenu_CreateMenu (1)
	;_GUICtrlMenu_InsertMenuItem ($hHelp, 0,"خريطة الكتاب" 		    , $idFileMap )
	;_GUICtrlMenu_InsertMenuItem ($hHelp, 1,""		    , 0 )
	_GUICtrlMenu_InsertMenuItem ($hHelp, 0,"الموقع الرسمى للبرنامج"    , $idHelpOfcPage)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 1,"إرسال إقتراح-تبليغ عن خطأ", $idHelpWrtComment)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 2,"اختبار وجود إصدار احدث من البرنامج",   $idHelpChkUpdate)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 3,""		    , 0 )
	_GUICtrlMenu_InsertMenuItem ($hHelp, 4,"رابط تحميل ملف المساعدة"  , $idHelpPage)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 5,"رابط تحميل البرنامج"  	, $idHelpLoadPage)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 6,"رابط تحميل برنامج قاموس الكتاب"  	, $idHelpKamosPage)
	_GUICtrlMenu_InsertMenuItem ($hHelp, 7,""		    , 0 )
	_GUICtrlMenu_InsertMenuItem ($hHelp, 8,"عن البرنامج"			  	, $idHelpAbout)
	;--------
	;_GUICtrlMenu_InsertMenuItem ($idView_SubMenu, 0, "&ملف" 	, 0, $idView_SubMenu)
	;------
	; Create Main menu
	$hMain = _GUICtrlMenu_CreateMenu (1)
	_GUICtrlMenu_InsertMenuItem ($hMain, 0, "&ملف" 	, 0, $hFile)
	_GUICtrlMenu_InsertMenuItem ($hMain, 1, "ت&حرير", 0, $hEdit)
	_GUICtrlMenu_InsertMenuItem ($hMain, 2, "&عرض"  , 0, $hView)
	_GUICtrlMenu_InsertMenuItem ($hMain, 3, "ال&مفضـلات"  , 0, $hFav)
	_GUICtrlMenu_InsertMenuItem ($hMain, 4,"&تعليمات"  	 , 0, $hHelp)

	; Set window menu
	_GUICtrlMenu_SetMenu ($hGUI, $hMain)

	; ---------------------------------------------

	_GUICtrlMenu_SetItemBmp ( $hFile, $idFileBible, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Bible, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hFile, $idFileMap,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Map, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hFile, $idFileSaveAs,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_SaveAs, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hFile, $idFilePrint, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Print, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hFile, $idFileClose,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 131, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hFile, $idFileExit,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 27, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hEdit, $idEditCopy,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Copy, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hEdit, $idEditSearch,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Search, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hEdit, $idEditKamos,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),  $gstrExeFile, $icoID_Kamos, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hView, $idViewFont,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 73, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewAdd,   _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Address, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewCount, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Count, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewNum,   _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Num, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewTach,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Tach, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewAya,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),  $gstrExeFile, $icoID_Aya, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hView, $idViewPrev,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Prev, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hView, $idViewNext,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Next, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hView, $idViewShahd,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),$gstrExeFile, $icoID_Shahd, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hFav, $idFavAdd,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 43, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hHelp, $idHelpPage,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 154, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hHelp, $idHelpChkUpdate,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_ChkUpdate, $lngICOSize, $lngICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hHelp, $idHelpAbout,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, 0, $lngICOSize, $lngICOSize), false)

	; ---------------------------------------------
	; Adjust Setting ==============================
	if CurAdd()= 0 then
		$bStatAdd = $TBSTATE_CHECKED
;msgbox (0,0,$bStatAdd)
		;GUICtrlSetState($idViewAdd, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAdd, True, False)
	Else
		$bStatAdd = 0;$TBSTATE_CHECKED
		;GUICtrlSetState($idViewAdd, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAdd, False, False)
	EndIf
	;---
	if CurCont()= 1 then
		$bStatCont = $TBSTATE_CHECKED
		;GUICtrlSetState($idViewCount, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewCount, True, False)
	Else
		$bStatCont = 0;$TBSTATE_CHECKED
		;GUICtrlSetState($idViewCount, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewCount, False, False)

	EndIf
	;---
	if CurNum() = 0 then
		$bStatNum = 0;$TBSTATE_CHECKED
		;GUICtrlSetState($idViewNum, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewNum, False, False)
	Else
		$bStatNum = $TBSTATE_CHECKED
		;GUICtrlSetState($idViewNum, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewNum, True, False)
	EndIf
	;---
	if CurTach() = 0 then
		$bStatTash = 0;$TBSTATE_CHECKED
		;GUICtrlSetState($idViewTach, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewTach, False, False)
	Else
		$bStatTash = $TBSTATE_CHECKED
		;GUICtrlSetState($idViewTach, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewTach, True, False)
	EndIf
; ---
	if CurAyaChk () <> 0 then ; tasfer is OFF
		$bStatCont = 0
		$bStatAdd = 0
		;GUICtrlSetState ($idViewCount, $GUI_DISABLE)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewCount, True, False)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewAdd, True, False)

		$bStatAya = $TBSTATE_CHECKED
		;GUICtrlsetState ($idViewAya, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAya, True, False)
	Else
		if CurCont()= 1 then
				$bStatCont = $TBSTATE_CHECKED
			Else
				$bStatCont = 0; $TBSTATE_CHECKED
		EndIf
		;GUICtrlSetState ($idViewCount, $GUI_ENABLE)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewCount, False, False)

		if CurAdd()= 1 then
				$bStatAdd = $TBSTATE_CHECKED
			Else
				$bStatAdd = 0; $TBSTATE_CHECKED
		EndIf
		;GUICtrlSetState ($idViewAdd, $GUI_ENABLE)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewAdd, False, False)

		$bStatAya = 0
		;GUICtrlsetState ($idViewAya, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAya, False, False)
	EndIf

	;===============================================================================
	Toolbar ($bStatNum  , _
			 $bStatTash , _
			 $bStatAya  , _
			 $bStatCont , _
			 $bStatAdd  )
	;===============================================================================
	SetupTray ()
	SetupStatus ()

	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func WM_CONTEXTMENU1 ($iwParam, $bDisMenu)
	Local $hSubMenu, $lng
	Local $lngStep = Int($plng_CreatedTabs/15); 15 cols
	If $lngStep < 15 Then $lngStep = 15

	$hSubMenu = _GUICtrlMenu_CreatePopup ()

	_GUICtrlMenu_InsertMenuItem ($hSubMenu, 1, Num2India (1) & "- " & GetBibibleADD (0), $mncSubMenuStart)

	for $lng = 2 to $plng_CreatedTabs
		_GUICtrlMenu_InsertMenuItem ($hSubMenu, $lng, Num2India ($lng) & "- " & GetBibibleADD ($lng), $mncSubMenuStart + $lng -1 )
	Next

	for $lng = $lngStep to $lngMaxAya step $lngStep
		_GUICtrlMenu_SetItemType($hSubMenu ,$lng, $MFT_MENUBARBREAK)
	Next
;------------------
	Local $hMenu
	Local $lngSC_ICOSize = 16

	$hMenu = _GUICtrlMenu_CreatePopup ()
	_GUICtrlMenu_InsertMenuItem ($hMenu, 0, "إغلاق الشريط",	 $mnc_FileClose)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 1, "ترتيب الشريط",	 $mnc_FileSort)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 2, "", 0)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 3, "فتح أنجيل جديد", $mnc_FileBible)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 4, "خريطة الكتاب",  $mnc_FileMap)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 5, "", 0)
	;_GUICtrlMenu_InsertMenuItem ($hMenu, 5, "أضف الى المفضلات", $mnc_FavAdd)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 6, "إذهب الى ...", $mnc_SubMenu, $hSubMenu)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 7, "", 0)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 8, "الســابق", 	 $mnc_ViewPrev)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 9, "التـــالى", 	 $mnc_ViewNext)

		_GUICtrlMenu_SetItemDisabled($hMenu, 0, $bDisMenu)
;----
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_FileClose,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 131, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_FileBible, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Bible,  $lngSC_ICOSize,  $lngSC_ICOSize), false)

	;_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_FavAdd,    _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 43, $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_FileMap, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Map,  $lngSC_ICOSize,  $lngSC_ICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_ViewPrev, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Prev,  $lngSC_ICOSize,  $lngSC_ICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mnc_ViewNext, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Next,  $lngSC_ICOSize,  $lngSC_ICOSize), false)
;---
	_GUICtrlMenu_TrackPopupMenu ($hMenu, $iwParam)
	_GUICtrlMenu_DestroyMenu ($hMenu)
	Return True
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func WM_CONTEXTMENU2 ($iwParam)
	Local $lng, $lngStep
	Local $hSubMenu, $hSubMenu2
;------------------
	$lngStep = Int(1+$lngMaxAya/10); 10 cols
	If $lngStep < 10 Then $lngStep = 10

	$hSubMenu = _GUICtrlMenu_CreatePopup ()

	For $lng = 1 to $lngMaxAya
		_GUICtrlMenu_InsertMenuItem ($hSubMenu, $lng, "آية " & Num2India ($lng), $mnc2SubMenu2Start + $lng -1 )
	Next

	for $lng = $lngStep to $lngMaxAya step $lngStep
		_GUICtrlMenu_SetItemType($hSubMenu ,$lng, $MFT_MENUBARBREAK)
	Next
;------------------
	$lngStep = Int(1+$lngMaxValue/10); 10 cols
	If $lngStep < 10 Then $lngStep = 10

	$hSubMenu2 = _GUICtrlMenu_CreatePopup ()
	For $lng = 1 to $lngMaxValue
		_GUICtrlMenu_InsertMenuItem ($hSubMenu2, $lng, "الإصحاح " & Num2India ($lng), $mnc2SubMenu3Start + $lng -1 )
	Next

	for $lng = $lngStep to $lngMaxValue step $lngStep
		_GUICtrlMenu_SetItemType($hSubMenu2 ,$lng, $MFT_MENUBARBREAK)
	Next

;------------------
	Local $hMenu
	Local $lngSC_ICOSize = 16
	$hMenu = _GUICtrlMenu_CreatePopup ()
	_GUICtrlMenu_InsertMenuItem ($hMenu, 0, "بحث فى الكتاب المقدس",	 $mn2_EditSearch)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 1, "بحث فى قاموس الكتاب", $mn2_EditKamos)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 2, "", 0)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 3, "إذهب الى الآية ...", $mn2_SubMenu1, $hSubMenu)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 4, "إذهب الى الإصحاح ...", $mn2_SubMenu2, $hSubMenu2)

	_GUICtrlMenu_InsertMenuItem ($hMenu, 5, "الســابق", 	 $mn2_ViewPrev)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 6, "التـــالى", 	 $mn2_ViewNext)

	_GUICtrlMenu_InsertMenuItem ($hMenu, 7, "", 0)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 8, "الشـواهـد", $mn2_ViewShahd)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 9, "نسـخ", 		 $mn2_EditCopy)
	_GUICtrlMenu_InsertMenuItem ($hMenu, 10, "حفظ بأسـم", 		 $mn2_FileSaveAs)

;---
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_EditSearch,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Search, $lngSC_ICOSize,  $lngSC_ICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_EditKamos,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),  $gstrExeFile, $icoID_Kamos,  $lngSC_ICOSize,  $lngSC_ICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_ViewShahd,  _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),$gstrExeFile, $icoID_Shahd,  $lngSC_ICOSize,  $lngSC_ICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_EditCopy,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU),   $gstrExeFile, $icoID_Copy,   $lngICOSize, $lngICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_FileSaveAs,_CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_SaveAs, $lngSC_ICOSize,  $lngSC_ICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_ViewPrev, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Prev,  $lngSC_ICOSize,  $lngSC_ICOSize), false)
	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_ViewNext, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Next,  $lngSC_ICOSize,  $lngSC_ICOSize), false)

	_GUICtrlMenu_SetItemBmp ( $hMenu, $mn2_SubMenu1, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $gstrExeFile, $icoID_Aya,  $lngSC_ICOSize,  $lngSC_ICOSize), false)

;---
	_GUICtrlMenu_TrackPopupMenu ($hMenu, $iwParam)
	_GUICtrlMenu_DestroyMenu ($hMenu)
	Return True
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func Copy2BibleText ()

	Local $strClip

	ClipPut ("")

	if _GUICtrlTab_GetCurFocus ($htab) = $plng_SearchDef then

		_IEAction ($oIESearch, "copy")
		$strClip = ClipGet()
	Else
		Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
		Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

		_IEAction ($oIE_Top, "copy")
		$strClip = ClipGet()
		if $strClip = "" Then ; may mb the selection on botton
			_IEAction ($oIE_Bottom, "copy")
			$strClip = ClipGet()
		EndIf

	EndIf

	$strClip = StringLeft ($strClip, 20)
	Return  $strClip
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func CopyBibleText ()

	Local $strClip

	ClipPut ("")

	if _GUICtrlTab_GetCurFocus ($htab) = $plng_SearchDef then

		_IEAction ($oIESearch, "copy")
		$strClip = ClipGet()
		if $strClip = "" and Then
			_IEAction ($oIESearch, "selectall")
			_IEAction ($oIESearch, "copy")
			_IEAction ($oIESearch, "unselect")
		EndIf

	Else
		Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
		Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

		_IEAction ($oIE_Top, "copy")
		$strClip = ClipGet()
		if $strClip = "" Then ; may mb the selection on botton
			_IEAction ($oIE_Bottom, "copy")
			$strClip = ClipGet()

			if $strClip = "" Then ; no selectio at all
				_IEAction ($oIE_Bottom, "selectall")
				_IEAction ($oIE_Bottom, "copy")
				_IEAction ($oIE_Bottom, "unselect")
				$strClip = ClipGet()

				_IEAction ($oIE_Top, "selectall")
				_IEAction ($oIE_Top, "copy")
				_IEAction ($oIE_Top, "unselect")
				$strClip = ClipGet() & _
						   @CRLF & "================================================================================" & @CRLF & _
						   $strClip

				ClipPut ( $strClip)
			EndIf
		EndIf
	EndIf

		TrayTip ( $gconProgName,"تم النسخ الى الحافظة", 10 , 1 )
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func FilePrintDef ()
	;Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	;Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	if _GUICtrlTab_GetCurFocus ($htab) = $plng_SearchDef then
		_IEAction ($oIESearch, "printdefault")
	Else
		_IEAction ($oIE, "printdefault"); print both lower and upper pages- lower first
	EndIf

EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func FilePrint ()
	;Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	;Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	if _GUICtrlTab_GetCurFocus ($htab) = $plng_SearchDef then
		_IEAction ($oIESearch, "print")
	Else
		;_IEAction ($oIE_Top, "print"); only upper page is printed
		_IEAction ($oIE, "print"); only upper page is printed
	EndIf

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SaveAs ()

	Local $strHTML
	Local $strFileName =  GetBibibleADD () & ".html"
	$strFileName = StringReplace ( $strFileName, ":", " الى ")

	Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	if _GUICtrlTab_GetCurFocus ($hTab) = $plng_SearchDef then
		;_IEAction ($oIESearch, "saveas")
		$strHTML = _IEDocReadHTML  ($oIESearch)
	Else
		$strHTML = _IEDocReadHTML  ($oIE_Top)
		$strHTML = StringTrimRight ($strHTML, StringLen($conEndHTML) )
		$strHTML = 	$strHTML & _
					"<br> <hr>" & _
				   _IEBodyReadHTML   ($oIE_Bottom) & _
				   $conEndHTML
	EndIf


	$strFileName = FileSaveDialog  ("حفظ باسم", @MyDocumentsDir, "صفحة ويب (*.html)", 16 +2 , $strFileName, $frmMainForm)
;---
	Local $file = FileOpen($strFileName , 2+ 8+ 64)

	If $file = -1 Then
		;Msgbox($conMirrorR2L + 16,$gconProgName, "غير مستطاع حفظ الملف " & @cr & $strFileName ,0, $frmMainForm)
		Return
	EndIf
	GUISetCursor (15, 1, $frmMainForm)
		;MsgBox (0,$conSrchHTML_OnClick, $strHTML)
		;MsgBox (0,"", StringReplace($strHTML,$conSrchHTML_OnClick,"" ))

	If 0= FileWrite($file, StringReplace($strHTML,$conSrchHTML_OnClick,"" )) Then
		Msgbox($conMirrorR2L + 16,$gconProgName, "غير مستطاع حفظ الملف " & @cr & $strFileName ,0, $frmMainForm)
		Return
	EndIf

	FileClose($file)
	GUISetCursor (2,1 , $frmMainForm)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func UnSelect ()
	Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	;Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	if _GUICtrlTab_GetCurFocus ($htab) = $plng_SearchDef then
		_IEDocWriteHTML ($oIESearch,_IEDocReadHTML ($oIESearch) )
		_IEAction ($oIESearch, "unselect")

	Else
		_IEAction ($oIE_Top, "unselect")

	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SelectAll ()

	Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	;Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	if _GUICtrlTab_GetCurFocus ($hTab) <> $plng_SearchDef then
		;ConsoleWrite ("Sele__All ")
		_IEAction ($oIE_Top, "selectall")
		;_IEAction ($oIE_Bottom, "selectall")
		;_IEAction ($oFrameDown, "saveas")
	Else
		_IEDocWriteHTML ($oIESearch,_IEDocReadHTML ($oIESearch) )
		_IEAction ($oIESearch, "selectall")
	EndIf

EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func Toolbar( $bStatNum, $bStatTash, $bStatAya, $bStatCont, $bStatAdd)
	Const $conFixedHight = 66
	Local $hGUI
	Local $aStrings[14]

	$hToolbar = _GUICtrlToolbar_Create ($frmMainForm)
	_GUICtrlToolbar_SetUnicodeFormat ( $hToolbar, True)
	_GUICtrlToolbar_SetBitmapSize($hToolbar, 32, 32)

	Local $iIconCnt = _WinAPI_ExtractIconEx ($gstrExeFile, -1, 0, 0, 1) ; Get count
	Local $hNormal = _GUIImageList_Create(32, 32, 5, 1)
	;Local $hNormal = _GUIImageList_Create(40, 40, 6, 1)
	Local $iIconIndex, $i

    For $i = 0 To $iIconCnt - 1
        $iIconIndex = _GUIImageList_AddIcon($hNormal, $gstrExeFile, $i, True)
    Next

    _GUICtrlToolbar_SetImageList($hToolbar, $hNormal)
	; Add standard system bitmaps
	;_GUICtrlToolbar_AddBitmap ($hToolbar, 1, -1, $IDB_VIEW_SMALL_COLOR ); this add 12 ico from 0 to 11
	;_GUICtrlToolbar_AddBitmap ($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR); add ico starts from 12 from 12 to 23

    ; Add strings

	$aStrings[0] = _GUICtrlToolbar_AddString ($hToolbar, "الانجيل")
	$aStrings[13] = _GUICtrlToolbar_AddString ($hToolbar, "الخريطة")
	$aStrings[1] = _GUICtrlToolbar_AddString ($hToolbar, "الشاهد")

    $aStrings[2] = _GUICtrlToolbar_AddString ($hToolbar, "حفظ")
    $aStrings[3] = _GUICtrlToolbar_AddString ($hToolbar, "طباعة")
    $aStrings[4] = _GUICtrlToolbar_AddString ($hToolbar, "بحـث")

	$aStrings[10] = _GUICtrlToolbar_AddString ($hToolbar, "القاموس")

    $aStrings[5] = _GUICtrlToolbar_AddString ($hToolbar, "تشكيل")
    $aStrings[6] = _GUICtrlToolbar_AddString ($hToolbar, "مستمر")
    $aStrings[7] = _GUICtrlToolbar_AddString ($hToolbar, "ترقيم")
    $aStrings[8] = _GUICtrlToolbar_AddString ($hToolbar, "تفسير")
    $aStrings[9] = _GUICtrlToolbar_AddString ($hToolbar, "عناوين")

    $aStrings[11] = _GUICtrlToolbar_AddString ($hToolbar, "السابق")
    $aStrings[12] = _GUICtrlToolbar_AddString ($hToolbar, "التالى")

	_GUICtrlToolbar_GetMaxSize ($hToolbar)

	GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

	; Add buttons

	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_FileBible,  $icoID_Bible, $aStrings[0] );  	15
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_FileMap,    $icoID_Map,	  $aStrings[13] );  	15
	_GUICtrlToolbar_AddButtonSep ($hToolbar)

	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewShahd,  $icoID_Shahd, $aStrings[1] );  	21	Shahd
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_FileSaveAs, $icoID_SaveAs,$aStrings[2] );		16
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_FilePrint,  $icoID_Print, $aStrings[3] );		22
	_GUICtrlToolbar_AddButtonSep ($hToolbar)

	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_FileSearch, $icoID_Search, $aStrings[4] );		17
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_EditKamos, $icoID_Kamos, $aStrings[10] )
	_GUICtrlToolbar_AddButtonSep ($hToolbar)

	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewTach, $icoID_Tach, $aStrings[5], $BTNS_BUTTON  , $bStatTash + $TBSTATE_ENABLED );		03
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewCount,$icoID_Count,$aStrings[6], $BTNS_BUTTON  , $bStatCont + $TBSTATE_ENABLED );		00	$TBSTATE_INDETERMINATE $TBSTATE_ENABLED
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewNum,  $icoID_Num,  $aStrings[7],  $BTNS_BUTTON  , $bStatNum  + $TBSTATE_ENABLED );		04	$TBSTATE_INDETERMINATE $TBSTATE_ENABLED
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewAya,  $icoID_Aya,  $aStrings[8], $BTNS_BUTTON  , $bStatAya  + $TBSTATE_ENABLED );		02
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewAdd,  $icoID_Address, $aStrings[9], $BTNS_BUTTON  , $bStatAdd  + $TBSTATE_ENABLED );		05

	_GUICtrlToolbar_AddButtonSep ($hToolbar)

	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewPrev, $icoID_Prev,  $aStrings[11] )
	_GUICtrlToolbar_AddButton ($hToolbar, $idTB_ViewNext, $icoID_Next,  $aStrings[12] )
	;-------------
	_GUICtrlToolbar_EnableButton($hToolbar, $idTB_ViewCount, _Iif($bStatAya = 0, True, false) )
	_GUICtrlToolbar_EnableButton($hToolbar, $idTB_ViewAdd,   _Iif($bStatAya = 0, True, false) )

	_GUICtrlToolbar_SetButtonSize($hToolbar, $conFixedHight,  GetToolbarWidth () )

	;GUICtrlSetResizing ($hToolbar, bitor($GUI_DOCKTOP, $GUI_DOCKRIGHT , $GUI_DOCKLEFT, $GUI_DOCKALL, $GUI_DOCKSIZE))

EndFunc   ;==>_Main
;---------------------------------------------------------------------------------------------------------------------------
; WM_NOTIFY event handler
Func _WM_NOTIFY($hWndGUI, $MsgID, $wParam, $lParam)
	#forceref $hWndGUI, $MsgID, $wParam

	Local $tNMHDR, $event, $hwndFrom, $code, $i_idNew, $dwFlags, $lResult, $idFrom, $i_idOld
	Local $tNMTOOLBAR, $tNMTBHOTITEM

	;$bToolbarFlag = 1

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hwndFrom = DllStructGetData($tNMHDR, "hWndFrom")
	$idFrom = DllStructGetData($tNMHDR, "IDFrom")
	$code = DllStructGetData($tNMHDR, "Code")

	Switch $hwndFrom
		Case $hToolbar
			Switch $code
				Case $NM_LDOWN
					;$lngToolbarKey = $iItem

				Case $TBN_HOTITEMCHANGE
					$tNMTBHOTITEM = DllStructCreate($tagNMTBHOTITEM, $lParam)
					$i_idOld = DllStructGetData($tNMTBHOTITEM, "idOld")
					$i_idNew = DllStructGetData($tNMTBHOTITEM, "idNew")
					;$iItem = $i_idNew
					$dwFlags = DllStructGetData($tNMTBHOTITEM, "dwFlags")

					If BitAND($dwFlags, $HICF_LEAVING) = $HICF_LEAVING Then
						;MemoWrite("$HICF_LEAVING: " & $i_idOld)
						ToolTip ("")
					Else
						Switch $i_idNew

							Case $idTB_FileBible
								ToolTip ("اختيار الانجيل")
							Case $idTB_FileMap
								ToolTip ("خريطة الكتاب المقدس")
							Case $idTB_ViewShahd
								ToolTip ("استعراض الشواهد")

							Case $idTB_FileSearch
								ToolTip ("البحث فى الكتاب")

							Case $idTB_FilePrint
								ToolTip ("طباعة الصفحة")

							Case $idTB_FileSaveAs
								ToolTip ("حفظ هذا الاصحاح")

							Case $idTB_ViewNum
								if CurNum() <> 0   then
									ToolTip ("إظهار رقم الاية")
								Else
									ToolTip ("إخفاء رقم الاية")
								endif

							Case $idTB_ViewAdd
								if CurAdd()= 0  then
									ToolTip ("عرض عناوين الاحداث")
								Else
									ToolTip ("اأخفاء عناوين الاحداث")
								endif
							Case $idTB_ViewCount
								if CurCont()= 0  then
									ToolTip ("عرض نص مستمر")
								Else
									ToolTip ("اية لكل سطر")
								endif

							Case $idTB_ViewAya
								if CurAyaChk () = 0  then
									ToolTip ("إظهار التفسير")
								Else
									ToolTip ("إخفاء التفسير")
								EndIf

							Case $idTB_ViewTach
								if CurTach() <> 0    then
									ToolTip ("إظهار تشكيل الحروف")
								Else
									ToolTip ("إخفاء تشكيل الحروف")
								endif

							Case $idTB_EditKamos
									ToolTip ("البحث فى قاموس الكتاب المقدس")

							Case $idTB_ViewNext
								if CurAyaChk () = 0  then
									ToolTip ("عرض الاصحاح التالى")
								Else
									ToolTip ("عرض الاية التالية")
								EndIf


							Case $idTB_ViewPrev
								if CurAyaChk () = 0  then
									ToolTip ("عرض الاصحاح السابق")
								Else
									ToolTip ("عرض الاية السابق")
								EndIf

							EndSwitch

					EndIf
			EndSwitch
	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY

;---------------------------------------------------------------------------------------------------------------------------
Func SetupTray  ()
	Local $string

	TraySetIcon ($gstrExeFile, -1); bible.ico -3, -4

			$tryViewCont    = TrayCreateItem("نص مستمر" )
					TrayItemSetOnEvent ($tryViewCont, "DispSwapCont")
					TrayItemSetState ( -1, $TRAY_UNCHECKED )

					if CurCont()= 1 then
							TrayItemSetState ( -1, $TRAY_CHECKED )
						Else
							TrayItemSetState ( -1, $TRAY_UNCHECKED )
					EndIf

			$tryViewNum    = TrayCreateItem("ترقـيم الايــات")
					TrayItemSetOnEvent ($tryViewNum, "DispSwapNum")
					TrayItemSetState ( -1, $TRAY_UNCHECKED )
					if CurNum () = 1 then
							TrayItemSetState ( -1, $TRAY_UnCHECKED )
						Else
							TrayItemSetState ( -1, $TRAY_CHECKED )
					EndIf

			$tryViewTach    = TrayCreateItem("تشـكيل الحـروف")
					TrayItemSetOnEvent ($tryViewTach, "DispSwapTach")
					TrayItemSetState ( -1, $TRAY_UNCHECKED )
					if CurTach() = 1 then
							TrayItemSetState ( -1, $TRAY_UnCHECKED )
						Else
							TrayItemSetState ( -1, $TRAY_CHECKED )
					EndIf

			$tryViewAya    = TrayCreateItem("التفســـير")
					TrayItemSetOnEvent ($tryViewAya, "DispSwapAya")
					TrayItemSetState ( -1, $TRAY_UNCHECKED )
					if CurAyaChk () <> 0 then
							TrayItemSetState ( -1, $TRAY_CHECKED )
							TrayItemSetState ( $tryViewCont, $TRAY_DISABLE )
						Else
							TrayItemSetState ( -1, $TRAY_UNCHECKED )
							TrayItemSetState ( $tryViewCont, $TRAY_ENABLE )
					EndIf

;---
			TrayCreateItem("")
;---
			$tryFileClose    = TrayCreateItem ( "إغلاق الشريط" )

					TrayItemSetOnEvent ($tryFileClose, "TabClose")
					TrayItemSetState ($tryFileClose, $GUI_DISABLE )


			$tryExit       = TrayCreateItem ( "الخروج" )
					TrayItemSetOnEvent (-1,"MainForm_Close")

		TraySetState()
EndFunc

;---------------------------------------------------------------------------------------------------------------------------
Func _CreateBitmapFromIcon($iBackground, $sIcon, $iIndex, $iWidth, $iHeight)

    Local $hDC, $hBackDC, $hBackSv, $hIcon, $hBitmap

    $hDC = _WinAPI_GetDC(0)
    $hBackDC = _WinAPI_CreateCompatibleDC($hDC)
    $hBitmap = _WinAPI_CreateSolidBitmap(0, $iBackground, $iWidth, $iHeight)
    $hBackSv = _WinAPI_SelectObject($hBackDC, $hBitmap)
    $hIcon = _WinAPI_PrivateExtractIcon2($sIcon, $iIndex, $iWidth, $iHeight)
    If Not @error Then
        _WinAPI_DrawIconEx($hBackDC, 0, 0, $hIcon, 0, 0, 0, 0, $DI_NORMAL)
        _WinAPI_DestroyIcon($hIcon)
    EndIf
    _WinAPI_SelectObject($hBackDC, $hBackSv)
    _WinAPI_ReleaseDC(0, $hDC)
    _WinAPI_DeleteDC($hBackDC)
    Return $hBitmap
EndFunc   ;==>_CreateBitmapFromIcon
;---------------------------------------------------------------------------------------------------------------------------
Func _WinAPI_PrivateExtractIcon2($sIcon, $iIndex, $iWidth, $iHeight)

    Local $hIcon, $tIcon = DllStructCreate('hwnd'), $tID = DllStructCreate('hwnd')
    Local $Ret = DllCall('user32.dll', 'int', 'PrivateExtractIcons', 'str', $sIcon, 'int', $iIndex, 'int', $iWidth, 'int', $iHeight, 'ptr', DllStructGetPtr($tIcon), 'ptr', DllStructGetPtr($tID), 'int', 1, 'int', 0)

    If (@error) Or ($Ret[0] = 0) Then
        Return SetError(1, 0, 0)
    EndIf
    $hIcon = DllStructGetData($tIcon, 1)
    If ($hIcon = Ptr(0)) Or (Not IsPtr($hIcon)) Then
        Return SetError(1, 0, 0)
    EndIf
    Return $hIcon
EndFunc   ;==>_WinAPI_PrivateExtractIcon

;---------------------------------------------------------------------------------------------------------------------------
Func MenuCOMMAND($lngCommand)

	; - Sub Menu  ----------------------------------
	If $lngCommand >= $mncSubMenuStart  and $lngCommand <= $mncSubMenuEnd Then
		If $lngCommand = $mncSubMenuStart Then
			TabSetFous ($plng_BibleDef)
		Else
			TabSetFous (1 + $lngCommand - $mncSubMenuStart)
		EndIf
		Return 1
	EndIf
	;----
	If $lngCommand >= $idSubMenuStart  and $lngCommand <= $idSubMenuEnd Then
		If $lngCommand = $idSubMenuStart Then
			TabSetFous ($plng_BibleDef)
		Else
			TabSetFous (1 + $lngCommand - $idSubMenuStart)
		EndIf
		Return 1
	EndIf
	;----
	If $lngCommand >= $mnc2SubMenu2Start  and $lngCommand <= $mnc2SubMenu2End Then
		;If CurAyaChk() = 0 Then
		;	DispSwapAya ()
		;EndIf

		If CurAyaChk () <> 0 Then
			CurAyaChk ($lngCommand -$mnc2SubMenu2Start  + 1)
		Else
			CurAyaFrom ($lngCommand -$mnc2SubMenu2Start  + 1)
			if CurAyaTo() < CurAyaFrom () Then
				CurAyaTo ( 1000 ) ; put max value
			endif
		EndIf

		UpdateTxt ()
		Return 1
	EndIf
	;----
	If $lngCommand >= $mnc2SubMenu3Start  and $lngCommand <= $mnc2SubMenu3End Then
		If CurAyaChk() <> 0 Then
			 DispSwapAya ()
		EndIf

		;ConsoleWrite ("Menu= " & $lngCommand & " Equall=" & $mnc2SubMenu2Start - $lngCommand + 1 & @cr	)
		ReadBible (Default, $lngCommand -$mnc2SubMenu3Start  + 1)
		;CurChptr ($lngCommand -$mnc2SubMenu3Start  + 1)

		;UpdateTxt ()
		Return 1
	EndIf
	;----

		Switch $lngCommand
			; - File Menu  ----------------------------------
			Case $idFileBible, $mnc_FileBible, $idTB_FileBible
					cmdGetBible_Start ()
            Case $idFileMap, $idTB_FileMap, $mnc_FileMap
                    cmdBibleMap_Start ()
            Case $idFileSaveAs, $mn2_FileSaveAs, $idTB_FileSaveAs
                    SaveAs ()
			Case $idFilePrint
					FilePrint ()
            Case $idTB_FilePrint
                    FilePrintDef()
			Case $idFileSort, $mnc_FileSort
					cmdSort_Start ()
            Case $idFileClose, $mnc_FileClose
                    TabClose ()
			Case $idFileExit, $GUI_EVENT_CLOSE
					;$plngProgramExit = 1
                    MainForm_Close ()
					Return

            ; - Edit Menu  ----------------------------------
            Case $idEditSelectAll
                    SelectAll ()
            Case $idEditUnSelect
                    UnSelect ()
			Case $idEditCopy, $mn2_EditCopy
                    CopyBibleText ()
			Case $idEditSearch, $mn2_EditSearch, $idTB_FileSearch
                    cmdSearch_Start ()
			Case $idEditKamos, $mn2_EditKamos, $idTB_EditKamos
                    cmdKamos_Start ()

        ; - View Menu ----------------------------------
            Case $idViewFont
                    cmbFont_Start ()
            Case $idViewAdd, $idTB_ViewAdd
                    DispSwapAdd ()
            Case $idViewCount, $idTB_ViewCount
                    DispSwapCont ()
            Case $idViewNum, $idTB_ViewNum
                    DispSwapNum ()
            Case $idViewTach, $idTB_ViewTach
                    DispSwapTach ()
            Case $idViewAya, $idTB_ViewAya
                    DispSwapAya ()
			Case $idViewPrev, $mnc_ViewPrev, $idTB_ViewPrev, $mn2_ViewPrev
                    cmdPrevAya_Click ()
					;Sleep (2000)
			Case $idViewNext, $mnc_ViewNext, $idTB_ViewNext, $mn2_ViewNext
					cmdNextAya_Click ()
					;Sleep (2000)
            Case $idViewShahd, $mn2_ViewShahd, $idTB_ViewShahd
                    cmdShahd_Start ()
            Case $idViewDef
                    Setting_Def ()

        ; - Fav Menu ------------------------------------
            Case $idFavAdd;, $mnc_FavAdd
                    cmdFavAdd_Start ()
            Case $idFavManag
                    cmdFavManag_Start ()

        ; - Help Menu -----------------------------------
            Case $idHelpOfcPage
                    cmdOfcPage_Start ()
			Case $idHelpChkUpdate
					cmdChkUpdate_Start ()
			Case $idHelpWrtComment
					cmdWrtComment_Start ()
            Case $idHelpPage
                    cmdHelpPage_Start ()
            Case $idHelpLoadPage
                    cmdLoadPage_Start ()
            Case $idHelpKamosPage
                    cmdLoadKamos_Start ()
            Case $idHelpAbout
                    cmdCpyWrt_Start ()
			Case Else
				Return 0; i.e is not used
		EndSwitch
    Return 1; $GUI_RUNDEFMSG

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func WM_MenuCOMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	$plngCommand = _WinAPI_LoWord ($iwParam)
    ;Return 1; $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
;---------------------------------------------------------------------------------------------------------------------------
Func AppMenu ()
	 _GUICtrlMenu_AppendMenu  ($idView_SubMenu, $MF_STRING, $idSubMenuStart, Num2India (1) & "- " & GetBibibleADD (0))
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func DelMenuItem ($lngTab)
	Local $lngCnt
	;ConsoleWrite (	"$plng_CreatedTabs " & $plng_CreatedTabs & @CR)
	 _GUICtrlMenu_RemoveMenu($idView_SubMenu, $lngTab-1, True)
	For $lngCnt = 2 to $plng_CreatedTabs ; zero base
		_GUICtrlMenu_SetItemText ($idView_SubMenu, $lngCnt-1, Num2India ($lngCnt) & "- " & GetBibibleADD ($lngCnt), true)
	Next
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func AddMenuItem ($lngTab)
	if $lngTab > $plng_CreatedTabs Or $lngTab < 0 or $lngTab = $plng_SearchDef or $lngTab = $plng_BibleDef Then Return


	_GUICtrlMenu_AppendMenu  ($idView_SubMenu, $MF_STRING, $idSubMenuStart + $lngTab - 1, Num2India ($lngTab) & "- " & GetBibibleADD ($lngTab))

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func UpdateMenuItem ($lngTab)
;	ConsoleWrite (	"$lngTab " & $lngTab & @CR)

	if $lngTab > $plng_CreatedTabs Or $lngTab < 0 or $lngTab = $plng_SearchDef  Then Return
	if $lngTab = 0 Then
		_GUICtrlMenu_SetItemText ($idView_SubMenu, $lngTab, Num2India (1) & "- " & GetBibibleADD (0), true)
	else
		_GUICtrlMenu_SetItemText ($idView_SubMenu, $lngTab-1, Num2India ($lngTab) & "- " & GetBibibleADD ($lngTab), true)
	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SetupStatus ()
	;Local $aText[2] = ["" & @TAB, $conStatusMain]
	;Local $aParts[2] = [200, 200 + 400 ]

	;ConsoleWrite ($gstrExeFile & @cr)
	Local $aText[7] = ["", "", "", "", "", $conStatusMain, ""]
	Local $aParts[7] = [30,60,90,120,150, 420, 650 ]

	$hStatus = _GUICtrlStatusBar_Create ($frmMainForm, $aParts, $aText, $SBARS_TOOLTIPS );$SBARS_SIZEGRIP
		GUICtrlSetResizing ($hStatus, $GUI_DOCKAUTO)
		_GUICtrlStatusBar_SetParts ($hStatus, $aParts)
		_GUICtrlStatusBar_SetUnicodeFormat($hStatus, True)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func SetStatusICONs ()
	Local	$bStatTash = $icoID_Tach, _
	        $bStatCont = $icoID_Count, _
			$bStatNum  = $icoID_Num, _
			$bStatAya  = $icoID_Aya, _
			$bStatAdd  = $icoID_Address

	;_GUICtrlStatusBar_SetIcon ($hStatus, 3, 50, "shell32.dll")
	;_GUICtrlStatusBar_SetIcon ($hStatus, 0, _WinAPI_LoadShell32Icon (23))

	If CurTach() 	<> 0 	Then $bStatTash 	= -1
	If CurCont() 	= 0 	Then $bStatCont 	= -1
	If CurNum() 	<> 0 	Then $bStatNum 		= -1
	If CurAyaChk() 	= 0 	Then $bStatAya 		= -1
	If CurAdd() 	= 0 	Then $bStatAdd 		= -1

	;_GUICtrlStatusBar_SetMinHeight($hStatus, 30)

	_GUICtrlStatusBar_SetIcon ($hStatus, 0, $bStatTash, $gstrExeFile)
	_GUICtrlStatusBar_SetIcon ($hStatus, 1, $bStatCont, $gstrExeFile)
	_GUICtrlStatusBar_SetIcon ($hStatus, 2, $bStatNum, $gstrExeFile)
	_GUICtrlStatusBar_SetIcon ($hStatus, 3, $bStatAya, $gstrExeFile)
	_GUICtrlStatusBar_SetIcon ($hStatus, 4, $bStatAdd, $gstrExeFile)

	if $bStatTash 	<> -1  Then
		_GUICtrlStatusBar_SetTipText($hStatus, 0, "التشكيل فعال")
	EndIf

	if $bStatCont 	<> -1 Then
		_GUICtrlStatusBar_SetTipText($hStatus, 1, "الأيات بنفس السطر")
	EndIf

	if $bStatNum 	<> -1 Then
		_GUICtrlStatusBar_SetTipText($hStatus, 2, "إظهار ترقيم الأيات")
	EndIf

	if $bStatAya 	<> -1 Then
		_GUICtrlStatusBar_SetTipText($hStatus, 3, "التفسير التطبيقى")
	EndIf

	if $bStatAdd 	<> -1 Then
		_GUICtrlStatusBar_SetTipText($hStatus, 4, "أظهار عنوانين الموضوعات")
	EndIf

EndFunc
;---------------------------------------------------------------------------------------------------------
Func WrtStatus ($str, $iBar = $pconStatusBible)
	; _GUICtrlStatusBar_SetBkColor($hStatus, dec("00FF00") ) ; color is BRG CLR_DEFAULT
	;ConsoleWrite ($str & "<<<<" & @CR)

	_GUICtrlStatusBar_SetText ($hStatus, $str, $iBar )


	SetStatusICONs ()

EndFunc
;---------------------------------------------------------------------------------------------------------