;---------------------------------------------------------------------------------------------------------
;				Bible
;====================================================
; AutoIt version: 3.0.103
; Language:       English
; Author:         "Ayman Henry"
;---------------------------------------------------------------------------------------------------------------------------
;= Warpper

#Region AutoIt3Wrapper directives section
;** This is a list of compiler directives used by AutoIt3Wrapper.exe.
;** comment the lines you don't need or else it will override the default settings
;===============================================================================================================
;#AutoIt3Wrapper_Add_Constants=                  ;Add the needed standard constant include files. Will only run one time.
	;** AUTOIT3 settings
	;#AutoIt3Wrapper_UseAnsi=                        ;(Y/N) Use Ansi versions for AutoIt3a or AUT2EXEa. Default=N
	;#AutoIt3Wrapper_UseX64=                         ;(Y/N) Use X64 versions for AutoIt3_x64 or AUT2EXE_x64. Default=N
	;#AutoIt3Wrapper_Version=                        ;(B/P) Use Beta or Production for AutoIt3 and AUT2EXE. Default is P
	;#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N)Run Script with console debugging. Default=N
;===============================================================================================================
;** AUT2EXE settings
	#AutoIt3Wrapper_Icon=ICONs\Bible.ico                          ;Filename of the Ico file to use
	#AutoIt3Wrapper_OutFile=Bible.exe                        ;Target exe/a3x filename.
	;#AutoIt3Wrapper_OutFile_Type=exe                  ;a3x=small AutoIt3 file;  exe=Standalone executable (Default)
	#AutoIt3Wrapper_Compression=4                    ;Compression parameter 0-4  0=Low 2=normal 4=High. Default=2
	;#AutoIt3Wrapper_UseUpx=                         ;(Y/N) Compress output program. Default=Y
	;#AutoIt3Wrapper_Change2CUI=                     ;(Y/N) Change output program to CUI in stead of GUI. Default=N
;===============================================================================================================
;** Target program Resource info
	#AutoIt3Wrapper_Res_Field=Comment|يعرض نص الانجيل بالتشكيل و البحث - التفسير التطبيقى للكتاب
	#AutoIt3Wrapper_Res_Field=Info|ارسل بفكرة للتطوير او للتليغ عن خطأ                    ;Comment fFld
	#AutoIt3Wrapper_Res_Field=Done_By|aymhenry@hotmail.com @2011
	#AutoIt3Wrapper_Res_Field=WebSite|http://my.opera.com/aymhenry                   ;Comment field

	#AutoIt3Wrapper_Res_Description=كتاب لكل العصور             ;Description field
	;#AutoIt3Wrapper_Res_Description=كتاب لكل العصور - نسخة تجريبة فقط-وليست للتوزيع

	#AutoIt3Wrapper_Res_Fileversion=2.0                ;File Version
	#AutoIt3Wrapper_Res_Field=Product Name| الكتاب المقدس بالتشكيل و البحث - الشواهد - التفسير التطبيقى للكتاب - قاموس الكتاب

	;#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=  ;(Y/N/P) AutoIncrement FileVersion After Aut2EXE is finished. default=N
	;                                                P=Prompt, Will ask at Compilation time if you want to increase the version number.
	#AutoIt3Wrapper_Res_Language=3073                   ;Resource Language code . default 2057=English (United Kingdom)
	;#AutoIt3Wrapper_Res_Comment=©2011 أيمن هنرى
	#AutoIt3Wrapper_Res_LegalCopyright=  البرنامج مجانى- يوزع الى كل من يريد قراءة الانجيل             ;Copyright field

	;#AutoIt3Wrapper_Res_SaveSource=                 ;(Y/N) Save a copy of the Scriptsource in the EXE resources. default=N
	;#AutoIt3Wrapper_res_requestedExecutionLevel=    ;None, asInvoker, highestAvailable or requireAdministrator (default=None)

	; free form resource fields ... max 15
	; you can use the following variables:
	; %AutoItVer% which will be replaced with the version of AutoIt3
	; %date% = PC date in short date format
	; %longdate% = PC date in long date format
	; %time% = PC timeformat
	; eg: #AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
	#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
	#AutoIt3Wrapper_Res_Field=Complied|%longdate%            ;Free format fieldname|fieldvalue
	;#AutoIt3Wrapper_Res_Field=Name|Value            ;Free format fieldname|fieldvalue
	;#AutoIt3Wrapper_Res_Field=Name|Value            ;Free format fieldname|fieldvalue
	;#AutoIt3Wrapper_Res_Field=Name|Value            ;Free format fieldname|fieldvalue
;===============================================================================================================
; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 3) etc
; If no ResNumber is specified, the added icons are numbered from 201 up

	#AutoIt3Wrapper_Res_Icon_Add=ICONs\1-icoBible.ico;4  ; Filename[,ResNumber[,LanguageCode]] of ICO to be added.
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\2-icoShahed.ico; 5
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\3-icoSave.ico;6
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\4-icoPrint.ico;7
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\5-IcoSearch.ico;8

	#AutoIt3Wrapper_Res_Icon_Add=ICONs\6-icoTash.ico;9
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\7-icoCont.ico;10
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\8-icoNumber.ico;11
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\9-icoTafser.ico;12
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\10-icoAddress.ico;13

	#AutoIt3Wrapper_Res_Icon_Add=ICONs\11-icoKamos.ico;14
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\12-icoNext.ico;15
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\13-icoPrev.ico;16
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\14-icoMap.ico;17
	#AutoIt3Wrapper_Res_Icon_Add=ICONs\15-icoCopy.ico;18

	#AutoIt3Wrapper_Res_Icon_Add=ICONs\16-icoChkUpdate.ico;19
	;#AutoIt3Wrapper_Res_Icon_Add=ICONs\17-Protect.ico;20

	;#AutoIt3Wrapper_Res_Icon_Add=ico2.ico                  ; Filename of ICO to be added.
	;#AutoIt3Wrapper_Res_Icon_Add=ico3.ico                  ; Filename of ICO to be added.
	;#AutoIt3Wrapper_Res_Icon_Add=ico4.ico                  ; Filename of ICO to be added.
	;#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename of ICO to be added.
	;#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName]] to be added.
	;#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName]] to be added.
;===============================================================================================================
; Tidy Settings

	;#AutoIt3Wrapper_Run_Tidy=                       ;(Y/N) Run Tidy before Run/Compilation. default=N
	;#AutoIt3Wrapper_Tidy_Stop_OnError=              ;(Y/N) Continue when only Warnings. default=Y
	;#Tidy_Parameters=                               ;Tidy Parameters...see SciTE4AutoIt3 Helpfile for options
;===============================================================================================================
; Obfuscator

	;#AutoIt3Wrapper_Run_Obfuscator=                 ;(Y/N) Run Obfuscator before Compilation. default=N
	;#obfuscator_parameters
;===============================================================================================================
; AU3CHECK settings

	;#AutoIt3Wrapper_Run_AU3Check=                   ;(Y/N) Run au3check before compilation. Default=Y
	;#AutoIt3Wrapper_AU3Check_Parameters=            ;Au3Check parameters
	;#AutoIt3Wrapper_AU3Check_Dat=                   ;Override the default au3check definition
	;#AutoIt3Wrapper_AU3Check_Stop_OnWarning=        ;(Y/N) N=Continue on Warnings.(Default) Y=Always stop on Warnings
	;#AutoIt3Wrapper_AU3Check_Parameters=            ;Au3Check parameters
	;#AutoIt3Wrapper_PlugIn_Funcs=                   ;Define PlugIn function names separated by a Comma to avoid AU3Check errors
;===============================================================================================================
; cvsWrapper settings

	;#AutoIt3Wrapper_Run_cvsWrapper=                 ;(Y/N/V) Run cvsWrapper to update the script source. default=N
	;                                                 V=only when version is increased by #AutoIt3Wrapper_Res_FileVersion_AutoIncrement.
	;#AutoIt3Wrapper_cvsWrapper_Parameters=          ; /NoPrompt : Will skip the cvsComments prompt" & @CRLF & _
	;                                                 /Comments : Text to added in the cvsComments. It can also contain the below variables.
;===============================================================================================================
; RUN BEFORE AND AFTER definitions

	; The following directives can contain:
	;   %in% , %out%, %icon% which will be replaced by the fullpath\filename.
	;   %scriptdir% same as @ScriptDir and %scriptfile% = filename without extension.
	;   %fileversion% is the information from the #AutoIt3Wrapper_Res_Fileversion directive
	;   %scitedir% will be replaced by the SciTE program directory
	;   %autoitdir% will be replaced by the AutoIt3 program directory
	;#AutoIt3Wrapper_Run_Before=         ;process to run before compilation - you can have multiple records that will be processed in sequence
	;#AutoIt3Wrapper_Run_After=          ;process to run After compilation - you can have multiple records that will be processed in sequence
#EndRegion
;---------------------------------------------------------------------------------------------------------------------------
#Include <modInclude.au3>
;---------------------------------------------------------------------------------------------------------------------------

	Global Const $conToolbar_MinWidth = 64
	Global Const $pconTabCloseWidth = 16 + 2 + 1
	Global Const $pconMain_LeftSide = 25
	Global $plngShiftPixl = 1000; any big number
	;Global $plngProgramExit = 0; 1 yes exit
	Global $plngToolTipExist = 0; 1 yes exit
	Global $plngCommand = 0; 1 yes exit

	if ChkDataFile () = 0 Then Exit

	_Main()
;---------------------------------------------------------------------------------------------------------------------------
Func _Main()

	Const $conTopSide = 25
	Local $lngItemHight=32, $lngShift =30
	Local $lngItemWdth=180, $Size, $iCount
    Local $msg;, $lngWinMinWidth, $lngSettingWinWdth
	Local $a_Rect [4]
	Local $lngWinStat= 0, $lngWinStatOLD=1

		$a_Rect[0] =  $pconMain_LeftSide
		$a_Rect[1] =  $conTopSide + $lngItemHight + 10 + $lngShift +15 + 5
		$a_Rect[2] =  $plngWinWdth - 2 * $pconMain_LeftSide
		$a_Rect[3] =  $plngWinHigh - 3 * $conTopSide - $lngItemHight - 20 - 10 - $lngShift - 5

	$frmMainForm = GUICreate ( $gconProgNameBigName, $plngWinWdth, $plngWinHigh, $plngWinLeft, $plngWinTop,  _
			BitOR ($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_CAPTION, $WS_MINIMIZEBOX,$WS_MAXIMIZEBOX ), $WS_EX_LAYOUTRTL )	;formStyle (), formExStyle (), $frmMainForm )
		;GUISetOnEvent($GUI_EVENT_CLOSE, "MainForm_Close")

		;GUISetOnEvent($GUI_EVENT_SECONDARYDOWN, "MouseRightClick")

		GUISetIcon (@ScriptDir & "\Bible.ico", $frmMainForm)
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmMainForm )

		GUICtrlSetColor (-1, 0xFF0000)
		GUICtrlSetState (-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$lngTahb_Left = $a_Rect[0] - 05
	$hTab = GUICtrlCreateTab ( $lngTahb_Left, _		; this number is used also with moust hove sub
							   $a_Rect[1] - $lngItemHight -06, _
							   $a_Rect[2] + 10, _
							  0 + $lngItemHight  ,  BitOr($GUI_SS_DEFAULT_TAB,  $TCS_FIXEDWIDTH,$TCS_FORCELABELLEFT ) );$TCS_FORCEICONLEFT $TCS_FORCELABELLEFT, $TCS_FORCEICONLEFT, $WS_EX_LAYOUTRTL)

			Local	$hImage = _GUIImageList_Create()

			;_GUIImageList_Add($hImage, _WinAPI_CreateSolidBitmap($frmMainForm, 0x00FF00, 16, 16))
			;_GUIImageList_Add($hImage, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), $strEXE, $icoID_Protect, 16 ,16))
			_GUIImageList_Add($hImage, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 47, 16, 16))
			_GUIImageList_Add($hImage, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 22, 16, 16))
			_GUIImageList_Add($hImage, _CreateBitmapFromIcon(_WinAPI_GetSysColor($COLOR_MENU), @SystemDir & '\shell32.dll', 112, 16, 16))

			_GUICtrlTab_SetImageList($hTab, $hImage)

			_GUICtrlTab_SetPadding($hTab, 1, 4)
			_GUICtrlTab_SetUnicodeFormat ($hTab, true)

		;GUICtrlSetOnEvent($hTab, "hTab_Change")
		GUICtrlSetResizing ($hTab, bitor($GUI_DOCKTOP, $GUI_DOCKRIGHT , $GUI_DOCKLEFT, $GUI_DOCKALL, $GUI_DOCKSIZE))
			TabCreate ( $conTab_TypeBible , $plng_BibleDef)
			TabCreate ( $conTab_TypeSearch, $plng_SearchDef)

			_GUICtrlTab_SetItemImage($hTab, 0, $plng_BibleDef)
			_GUICtrlTab_SetItemImage($hTab, 1, $plng_SearchDef)

			IE_Objects ($plng_SearchDef,  $a_Rect)

			_GUICtrlTab_SetItemSize($hTab, $lngItemWdth, $lngItemHight)
			GUICtrlCreateTabItem("")    ; end tabitem definition


			;_GUICtrlTab_SetCurFocus ($frmMainForm, $hTab); to give ability to use key  Esc etc... brfore seting the event
			;------------------------

	IE_Objects ($plng_BibleDef,  $a_Rect)
	GUICtrlSetState ($hTab, $GUI_FOCUS)

	$grp = GUICtrlCreateGroup ("", $a_Rect[0]-4, $a_Rect[1]-11, $a_Rect[2]+8, $a_Rect[3]+13)
	GUICtrlSetResizing (-1, bitor($GUI_DOCKTOP , $GUI_DOCKBOTTOM , $GUI_DOCKRIGHT , $GUI_DOCKLEFT))
	GUICtrlSetState ($grp, $GUI_FOCUS)

	MainMenu ( $frmMainForm)

	; Get Menu Hight
	;------------------------------------
		$Size = WinGetClientSize($frmMainForm)
		if IsArray ($Size) and @error  <> 1 Then
			if $Size[0] > 0  And $Size[1] > 0 Then
				$plngMenuHight = $plngWinHigh - $Size[1]
			EndIf
		Else
				$plngWinHigh = 25
		Endif
	;------------------------
		$lngMaxValue = GetBibleChpts ( CurBible() ); StringRight  ( $acBible[ CurBible() ], 3 ); $a_Settings [3]
		$lngMaxAya = CalcMaxAya2Chpt (CurBible(), CurChptr()) ; data not applied yet to aSetting

		SplashOff ()
		GUISetState(@SW_SHOW)

	;------------------------

		SetTabInfoBible ($plng_BibleDef);$plng_BibleDef
		TabSetFous ( $plng_BibleDef );$plng_BibleDef
		AppMenu ()
		if $plng_SettingTabs > $plng_CreatedTabs Then
			For $iCount = $plng_CreatedTabs +1 to $plng_SettingTabs
				TabCreate ( $conTab_TypeBible, 0 )
				WrtTxtHeader ( $iCount )
			Next
		EndIf

		$plng_CurrTabNo = $plng_BibleDef

		UpdateTxt()

		SetStatusICONs ()
	;_GUICtrlStatusBar_SetIcon ($hStatus, 1, 4, $strEXE)
	;------------------------
	While 1
        $msg = GUIGetMsg(1)

		If $plngCommand <> 0 Then
			MenuCOMMAND ($plngCommand)
			$plngCommand = 0
		EndIf

		;ConsoleWrite ("stat=" & WinGetState ($gconProgNameBigName) & @cr)
		$lngWinStat = WinGetState ($gconProgNameBigName)

		If $lngWinStat <> $lngWinStatOLD Then
			If BitAND($lngWinStat, 8) = 8 And BitAND ($lngWinStatOLD,8) = 0 Then
				SetStatusICONs ()
			EndIf
			$lngWinStatOLD = $lngWinStat
		EndIf

		Switch $msg[0]
				; moved to WM_SIZE sub
				Case $GUI_EVENT_RESIZED, $GUI_EVENT_MAXIMIZE, $GUI_EVENT_Restore
						SetStatusICONs (); ill not work if put in wm_size handler

				Case $GUI_EVENT_SECONDARYDOWN
					MouseRightClick ()

				Case $GUI_EVENT_CLOSE
					MainForm_Close ()

				;Case $NM_DBLCLK ; GUIRegisterMsg
				;		ConsoleWrite ("Double click" & @CR)
				Case $GUI_EVENT_PRIMARYUP
					MouseLeftClick ()
					;Sleep (300)

				; - Toolbar and others
				;Case $hTab
				;     hTab_Change ()
		EndSwitch

		if $lngExtraFormOpen = 1 Then ContinueLoop
		;if WinGetState  ($gconProgName) = 15 Then ; exists + Visible + enabled + active = 15
		if $msg[1] = $frmMainForm Then
				GUIGetHoverCursor ($lngTahb_Left)

				if $lngUpdateFlag = 1 Then
					ShowSearchItem ()
				Else
					If CurAyaChk () <> 0 Then	ShowShahedItem ()
				EndIf
		EndIf
		;Sleep (10)
	WEnd
EndFunc   ;==>_Main
;---------------------------------------------------------------------------------------------------------------------------
; Resize the status bar when GUI size changes
Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
	;ConsoleWrite ("Resizing .." & @CR)
	 AdjustToolbarWidth ()
    _GUICtrlStatusBar_Resize ($hStatus)
	;SetStatusICONs ()
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE
;---------------------------------------------------------------------------------------------------------

Func ChkDataFile ()
	; -- Splash -------------------
	If _Singleton($gconProgNameBigName ,1) = 0 Then
		WinActivate   ($gconProgNameBigName)
		Return 0
	EndIf

	;MsgBox (0,0, WinExists  ($gconProgName ))
	;If WinExists ($gconProgName ) = 1 Then
	;	WinActivate  ($gconProgName)
	;	MsgBox (0,0, WinKill    ($gconProgName))
	;EndIf


	;SplashTextOn ( "", $gconProgName & @LF &  "كتاب لكل العصور" & @LF &  @LF & $conRevInfo & @LF & @LF & $conMyName ,300 , 200 ,-1 ,-1 ,1+2+32,"Tahoma",11,500 )
	SplashTextOn ( "", $gconProgNameBigName & @LF &  @LF & $conRevInfo & @LF & @LF & $conMyName ,300 , 200 ,-1 ,-1 ,1+2+32,"Tahoma",11,500 )

	$Debug_TAB = False ; Check ClassName being passed to functions, set to True and use a handle to another control to see it work

	; - basic data file
	If "" = FolderFileName ($gconDB_Main) Then
		Msgbox($conMirrorR2L + 16,$gconProgName, "الملف " & $gconDB_Main & " غير موجود - يجب أعادة الاعداد للبرنامج")
		SplashOff ()
		Return 0
	EndIf

	;---- Access Data Base
	OpenDBSystem ()

	;--- Setting
	CreateArray ()
	ReadSettings ()


	;--- Hotkeys
	HotKeySet ("{F1}", "ManagHotKeys") ;"cmdCpyWrt_Click")
	HotKeySet ("{F2}", "ManagHotKeys") ;"cmdGetBible_Click")
	HotKeySet ("{F3}", "ManagHotKeys") ;"cmdSearch_Click")
	HotKeySet ("{F4}", "ManagHotKeys") ;"cmdKamos_Click")

	HotKeySet ("{PGDN}", "ManagHotKeys") ;"cmdNextAya_Click")
	HotKeySet ("{PGUP}", "ManagHotKeys") ;"cmdPrevAya_Click")

	HotKeySet ("^w", "ManagHotKeys") ;"cmdCloseTab_Click")
	HotKeySet ("^c", "ManagHotKeys") ;"cmdCloseTab_Click")

	;HotKeySet ("{Esc}", "ManagEscKey")

	;-- AutoIt Options
	Opt ('GUICloseOnESC',   0)	;1 = Send the $GUI_EVENT_CLOSE message when ESC is pressed (default).
	Opt ('MustDeclareVars', 1)

	Opt ("TrayIconHide",    0)
	Opt ("TrayMenuMode",1)
	Opt ("TrayOnEventMode",1)

	Opt ("GUIOnEventMode", 0) ; 1

	Return 1
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func MainForm_Close ()
	Local $Size , $Pos
	Shutdwn ()

	$Pos  = WinGetPos  ($frmMainForm)

	If IsArray ($Pos) and @error  <> 1 Then
		if $Pos[2] > 0  And $Pos[3] > 0 Then
			$plngWinLeft = $Pos[0]
			$plngWinTop = $Pos[1]

			$Size = WinGetClientSize($frmMainForm)
			if IsArray ($Size) and @error  <> 1 Then
				if $Size[0] > 0  And $Size[1] > 0 Then
					$plngWinWdth = $Size[0]
					$plngWinHigh = $Size[1] + $plngMenuHight; Menu High
					;Msgbox (0,"asdAD", $Size[1] & " " & $plngWinHigh)
				EndIf
			Endif

		EndIf
	Endif

	;MsgBox(0, "Active window stats (x,y,width,height):", $size[0] & " " & $size[1] & " " & $pos[2] & " " & $pos[3])
	SaveSettings()

	IF IsPtr ( $frmSearch) Then GUIDelete($frmSearch)
	IF IsPtr ( $frmGetBible) Then GUIDelete($frmGetBible)

	IF IsPtr ( $frmAbout) Then GUIDelete($frmAbout)
	IF IsPtr ( $frmSelectFont) Then GUIDelete($frmSelectFont)

	IF IsPtr ( $frmListFav) Then GUIDelete($frmListFav)
	IF IsPtr ( $frmAddFav) Then GUIDelete($frmAddFav)
	IF IsPtr ( $frmShahed) Then GUIDelete($frmShahed)
	IF IsPtr ( $frmKamos) Then GUIDelete($frmKamos)

	GUIDelete ($frmMainForm)

	Exit
	Return
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func DispSwapAya ()

	if CurAyaChk () = 0 Then
		if CurAyaFrom () <> 0 Then ; safety step
			$a_Settings[5] = CurAyaFrom () ;$a_Settings[6]; expection 1 of 3
		Else
			$a_Settings[5] = 1 ;$a_Settings[6]; expection 2 of 3
		EndIf

		CurAyaChk ( CurAyaChk () ); adjust all in onestep
		CurAdd(0)

		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAya,True, False)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewCount, True, False)

		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAdd,False, False)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewAdd, True, False)

		TrayItemSetState ( $tryViewAya, $TRAY_CHECKED )
		TrayItemSetState ( $tryViewCont, $TRAY_DISABLE )

		_GUICtrlToolbar_EnableButton ($hToolbar, $idTB_ViewCount, False)
		_GUICtrlToolbar_CheckButton ($hToolbar, $idTB_ViewAya, True)

		_GUICtrlToolbar_EnableButton ($hToolbar, $idTB_ViewAdd, False)
		_GUICtrlToolbar_CheckButton ($hToolbar,  $idTB_ViewAdd, False)

	Else
		$a_Settings[5] = 0 ; expection 2 of 3
		;CurAyaFrom (-100) ; as it is do  not change
		CurAyaTo (1000)

		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAya,False, False)
		_GUICtrlMenu_SetItemDisabled ($hView, $idViewCount, False, False)

		_GUICtrlMenu_SetItemDisabled ($hView, $idViewAdd, False, False)

		TrayItemSetState ( $tryViewAya, $TRAY_UnCHECKED )
		TrayItemSetState ( $tryViewCont, $TRAY_ENABLE )

		_GUICtrlToolbar_EnableButton ($hToolbar, $idTB_ViewAdd, True)
		_GUICtrlToolbar_EnableButton($hToolbar, $idTB_ViewCount, true)
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewAya, False)

	EndIf
	UpdateTxt ()
EndFunc
;---------------------------------------------------------------------------------------------------------
Func DispSwapAdd ($IsRunUpdate = 1)
	if CurAyaChk () <> 0 then
		Return
	EndIf

	if CurAdd() = 0 Then
		CurAdd(1) ; $GUI_CHECKED

		GUICtrlsetState ($idViewAdd, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAdd,True, False)
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewAdd, True)

		;_GUICtrlStatusBar_SetIcon ($hStatus, 4, $icoID_Address, $strEXE)
	Else
		CurAdd (0) ; $GUI_UnCHECKED
		;GUICtrlSetState ($idViewAdd, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewAdd, False, False)
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewAdd, False)

		;_GUICtrlStatusBar_SetIcon ($hStatus, 4, -1, $strEXE)
	EndIf

	if $IsRunUpdate = 1 then UpdateTxt ()

EndFunc
;---------------------------------------------------------------------------------------------------------

Func DispSwapCont ($IsRunUpdate = 1)
	if CurAyaChk () <> 0 then
		Return
	EndIf

	if CurCont() = 0 Then
		CurCont(1) ; $GUI_CHECKED

		;GUICtrlsetState ($idViewCount, $GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewCount, True, False)
		TrayItemSetState ( $tryViewCont, $TRAY_CHECKED )
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewCount, True)
		;_GUICtrlStatusBar_SetIcon ($hStatus, 1, $icoID_Count, $strEXE)

	Else
		CurCont (0) ; $GUI_UnCHECKED
		;GUICtrlSetState ($idViewCount, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewCount, False, False)
		TrayItemSetState ( $tryViewCont, $TRAY_UnCHECKED )
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewCount, False)
		;_GUICtrlStatusBar_SetIcon ($hStatus, 1, -1, $strEXE)
	EndIf

	if $IsRunUpdate = 1 then UpdateTxt ()

EndFunc
;---------------------------------------------------------------------------------------------------------
Func DispSwapNum ($IsRunUpdate = 1)

	if CurNum () = 0 Then
		CurNum (1) ; $GUI_CHECKED
		;GUICtrlsetState ($idViewNum, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewNum, True, False)
		TrayItemSetState ( $tryViewNum, $TRAY_UnCHECKED )
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewNum, True)
		;_GUICtrlStatusBar_SetIcon ($hStatus, 2, -1, $strEXE)
	Else
		CurNum (0); $GUI_UnCHECKED
		;GUICtrlsetState ($idViewNum,$GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewNum, false, False)
		TrayItemSetState ( $tryViewNum, $TRAY_CHECKED )
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewNum, false)
		;_GUICtrlStatusBar_SetIcon ($hStatus, 2, $icoID_Num, $strEXE)
	EndIf

	if $IsRunUpdate = 1 then UpdateTxt ()

EndFunc
;---------------------------------------------------------------------------------------------------------
Func DispSwapTach ($IsRunUpdate = 1)

	if CurTach () = 1 Then
		CurTach (0)
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewTach, False)

		;GUICtrlsetState ($idViewTach, $GUI_UnCHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewTach, False, False)
		TrayItemSetState ( $tryViewTach, $TRAY_UnCHECKED )
		;_GUICtrlStatusBar_SetIcon ($hStatus, 0, -1, $strEXE)
	Else
		_GUICtrlToolbar_CheckButton($hToolbar, $idTB_ViewTach, True)
		CurTach (1)
		;GUICtrlsetState ($idViewTach,$GUI_CHECKED)
		_GUICtrlMenu_SetItemChecked  ($hView, $idViewTach, True, False)
		TrayItemSetState ( $tryViewTach, $TRAY_CHECKED )
		;_GUICtrlStatusBar_SetIcon ($hStatus, 0, $icoID_Tach, $strEXE)
	EndIf

	if $IsRunUpdate = 1 then UpdateTxt ()

EndFunc
;---------------------------------------------------------------------------------------------------------

;Func IEEvent_StatusTextChange ( $strStatisbarVal )
;		; $strStatisbarVal like 	Bible_320090026   or 32 0090 026 BBccccYYY
;	if $strStatisbarVal = "" or StringLeft ($strStatisbarVal, StringLen($conSrchFlag)) <> $conSrchFlag then Return
;	if $pstrStatisbarVal = $strStatisbarVal then Return
;
;	$pstrStatisbarVal = $strStatisbarVal
;
;	$lngUpdateFlag = 1
;	$pstrSearch_rslt =	$strStatisbarVal
;
;EndFunc

;---------------------------------------------------------------------------------------------------------
Func ShowSearchItem ($lngNewPage = 1) ; never used $lngNewPage=0
	Local $strAdd, $oHTML_Txt

	$oHTML_Txt = _IEGetObjByName ($oIESearch, $conSrchHTML_Txt)
	if @error <> 0 Then
		;$lngUpdateFlag = 0 ;del this
		Return
	EndIf

	$strAdd    = _IEFormElementGetValue ($oHTML_Txt)
	_IEFormElementSetValue ( $oHTML_Txt, "", 0 )

	If $strAdd = "" or StringLeft ($strAdd, StringLen($conSrchFlag)) <> $conSrchFlag then Return
	$strAdd = StringMid($strAdd, StringLen($conSrchFlag)+1)
	;MsgBox (0,0, $strAdd)
	;_ArrayDisplay ($a_hTabObject)
	;-------
	Local $nOtherTabOpen  = SrchOpenTabs ( $conTab_TypeBible & $strAdd)
	if $nOtherTabOpen <> -1 Then
		TabSetFous ($nOtherTabOpen)
		Return
	EndIf
; ================= USE TAB 0 THIS
	if $lngNewPage = 0 then; never used ! to be used later
		if $plng_BibleDef <>  _GUICtrlTab_GetCurFocus($hTab) Then
			TabSetFous ( $plng_BibleDef) ; use $plng_BibleDef Tab or
		EndIf
		;================= OR THIS
	else
		Local $nTab = TabCreate ()
		SetTabInfoBible ( $nTab )
		TabSetFous ( $nTab ) ; the new one and write bible in IE
	endif
;===============

	if CurAyaChk() <=0  Then ; HAS TO BE FIRST
		DispSwapAya ()
	EndIf

	CurBible ( BHex2Adrs ($strAdd, 1) )
	CurChptr ( BHex2Adrs ($strAdd, 2) )

	CurAyaFrom ( BHex2Adrs ($strAdd, 3) )
	CurAyaTo ( BHex2Adrs ($strAdd, 3) )
	CurAyaChk ( BHex2Adrs ($strAdd, 3) )

	UpdateTxt()

EndFunc
;---------------------------------------------------------------------------------------------------------
Func ShowShahedItem ($lngNewPage = 1) ; never used $lngNewPage=0
	Local $strAdd, $oHTML_Txt
	Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
	;Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)

	$oHTML_Txt = _IEGetObjByName ($oIE_Top, $conSrchHTML_Txt)
	if @error <> 0 Then
		;$lngUpdateFlag = 0 ;del this
		Return
	EndIf

	$strAdd    = _IEFormElementGetValue ($oHTML_Txt)
	_IEFormElementSetValue ( $oHTML_Txt, "", 0 )

	If $strAdd = "" or StringLeft ($strAdd, StringLen($conSrchFlag)) <> $conSrchFlag then Return

	$strAdd = StringMid($strAdd, StringLen($conSrchFlag)+1)

	;-------
	Local $nOtherTabOpen  = SrchOpenTabs ( $conTab_TypeBible & $strAdd)
	if $nOtherTabOpen <> -1 Then
		TabSetFous ($nOtherTabOpen)
		Return
	EndIf

; ================= USE TAB 0 THIS
	if $lngNewPage = 0 then; never used ! to be used later
		if $plng_BibleDef <>  _GUICtrlTab_GetCurFocus($hTab) Then
			TabSetFous ( $plng_BibleDef) ; use $plng_BibleDef Tab or
		EndIf
		;================= OR THIS
	else
		Local $nTab = TabCreate ()
		SetTabInfoBible ( $nTab )
		TabSetFous ( $nTab ) ; the new one and write bible in IE
	endif
;===============

	;ConsoleWrite ("old =" & CurBible () & " " & CurChptr () & " " & CurAyaFrom() & " " & CurAyaTo() & " " & CurAyaChk() & @CR)

	if (CurAyaChk() <> 0 ) And (BHex2Adrs ($strAdd, 3) =0)  Then ; if not the same switch
		;ConsoleWrite ("text =" & @CR)
		DispSwapAya ()
	EndIf

	CurBible ( BHex2Adrs ($strAdd, 1) )
	CurChptr ( BHex2Adrs ($strAdd, 2) )
	CurAyaFrom ( BHex2Adrs ($strAdd, 4) )
	CurAyaTo ( BHex2Adrs ($strAdd, 5) )
	CurAyaChk ( BHex2Adrs ($strAdd, 3) ) ; change has to be manual

	;ConsoleWrite (CurBible () & " " & CurChptr () & " " & CurAyaFrom() & " " & CurAyaTo() & " " & CurAyaChk())
	;MsgBox (0,0, $strAdd & ">from>>" & BHex2Adrs ($strAdd, 3) )
	;MsgBox (0,0, $strAdd & ">to>>" & BHex2Adrs ($strAdd, 4) )
	;MsgBox (0,0, $strAdd & ">one aya>>" & BHex2Adrs ($strAdd, 5) )


	UpdateTxt()

EndFunc
;---------------------------------------------------------------------------------------------------------
Func cmdCloseTab_Click ()
	TabCloseHover ()
EndFunc

;---------------------------------------------------------------------------------------------------------
Func ManagHotKeys ()
	Local $strHotKayPressed = @HotKeyPressed
	Local $strHotKeyFunc

	if _WinAPI_GetForegroundWindow() <> $frmMainForm  or $bHotKeyFlag = 1 Then
		HotKeySet ( $strHotKayPressed )
		Send ( $strHotKayPressed )
		Sleep (10)
		HotKeySet ($strHotKayPressed, "ManagHotKeys") ; cmdCpyWrt_Click

		Return
	EndIf

	$bHotKeyFlag = 1
	Switch $strHotKayPressed
		case "{F1}"
			cmdCpyWrt_Start ()
		case "{F2}"
			cmdGetBible_Start ()
		case "{F3}"
			cmdSearch_Start ()
		case "{F4}"
			cmdKamos_Start ()

		case "{PGDN}"
			cmdNextAya_Click ()
		case "{PGUP}"
			cmdPrevAya_Click ()

		case "^c"
			CopyBibleText ()
		case "^w"
			cmdCloseTab_Click ()
	EndSwitch

	$bHotKeyFlag = 0
EndFunc
;---------------------------------------------------------------------------------------------------------
Func GetToolbarWidth ()
	Local $lngWidth = $conDefDispWinWdth

	Local $Size = WinGetClientSize($frmMainForm)
			if IsArray ($Size) and @error  <> 1 Then
				if $Size[0] > 0  And $Size[1] > 0 Then
					$lngWidth = $Size[0]
				EndIf
			Endif

	;----
	Local $lngNewIconWidth = Int( $lngWidth  / ($lng_NoToolbar + 1))

	If $conToolbar_MinWidth > $lngNewIconWidth Then $lngNewIconWidth = $conToolbar_MinWidth
	Return $lngNewIconWidth
EndFunc
;---------------------------------------------------------------------------------------------------------
Func AdjustToolbarWidth ()

	Local $Size;, $lngWidth
	Local $bStat_Num = _GUICtrlToolbar_GetButtonState($hToolbar, $idTB_ViewNum)
	Local $bStat_Tach = _GUICtrlToolbar_GetButtonState($hToolbar, $idTB_ViewTach)
	Local $bStat_Aya = _GUICtrlToolbar_GetButtonState($hToolbar, $idTB_ViewAya)
	Local $bStat_Cont = _GUICtrlToolbar_GetButtonState($hToolbar, $idTB_ViewCount)
	Local $bStat_Add = _GUICtrlToolbar_GetButtonState($hToolbar, $idTB_ViewAdd)

	_GUICtrlToolbar_Destroy($hToolbar)
	Toolbar (True, True, 0, True, True)

	_GUICtrlToolbar_SetButtonState($hToolbar, $idTB_ViewNum, $bStat_Num)
	_GUICtrlToolbar_SetButtonState($hToolbar, $idTB_ViewTach, $bStat_Tach)
	_GUICtrlToolbar_SetButtonState($hToolbar, $idTB_ViewAya, $bStat_Aya)
	_GUICtrlToolbar_SetButtonState($hToolbar, $idTB_ViewCount, $bStat_Cont)
	_GUICtrlToolbar_SetButtonState($hToolbar, $idTB_ViewAdd, $bStat_Add)

EndFunc

;---------------------------------------------------------------------------------------------------------
Func MouseRightClick ()
		If $lngExtraFormOpen = 1 Then Return ; one form is opened
	;-------
		Local $a_MousePos, $a_TabPos

		$a_MousePos = GUIGetCursorInfo  ($frmMainForm)

		If  $a_MousePos[4] <> $hTab Then ; if click on outside $hTab
			ToolTip ("")
			WM_CONTEXTMENU2 ($frmMainForm)
			Return
		EndIf
	;----- Click inside $hTab

		$a_TabPos = _GUICtrlTab_GetItemRect($hTab, $plng_SearchDef)

		GUIGetHoverCursor ($lngTahb_Left) ; calc. current tab number > $nHoverTab

		if $plng_CurrTabNo = $plng_SearchDef Then
			_IEAction ($oIESearch, "selectall")
			_IEAction ($oIESearch, "unselect")
		else
			Local $oIE_Top 	= _IEFrameGetObjByName ($oIE, $IE_Upper)
			Local $oIE_Bottom = _IEFrameGetObjByName ($oIE, $IE_Lower)
			_IEAction ($oIE_Top, "refresh")
			_IEAction ($oIE_Bottom, "refresh")
		EndIf

		ToolTip ("")

		if $nHoverTab = $plng_SearchDef or $nHoverTab = $plng_BibleDef Then
			WM_CONTEXTMENU1 ($frmMainForm, True)
		Else
			WM_CONTEXTMENU1 ($frmMainForm, False)
		EndIf

EndFunc
;---------------------------------------------------------------------------------------------------------
Func GUIGetHoverCursor ( $leftMarg )

	Local $a_MousePos = GUIGetCursorInfo  ($frmMainForm)
	Local $nTabNumber, $lngPos
	Local $lngItemWdth;, $plngShiftPixl
	Local $a_CurTabPos

	;Local $a_CurToolSize = _GUICtrlToolbar_GetMaxSize ($hToolbar)

	if $a_MousePos[4] <> $hTab Then
		;If $a_MousePos[0] > $a_CurToolSize[0] OR _
		;   $a_MousePos[1] > $a_CurToolSize[1] Then
		If $plngToolTipExist = 1 Then
			$plngToolTipExist = 0
			ToolTip ("") ; let toolbar chance to be shown
		EndIf
		$nHoverTab = $plng_CurrTabNo
		Return
	EndIf
;----
		$a_CurTabPos = _GUICtrlTab_GetItemRect($hTab, 0)
		$lngPos = $a_CurTabPos [0]
		$lngItemWdth = $a_CurTabPos [2] - $a_CurTabPos [0]
;----
		$lngPos = $a_MousePos [0] - $lngPos - $pconMain_LeftSide + 1
		$nTabNumber = Int($lngPos/$lngItemWdth)
		$plngShiftPixl = $lngPos - $lngItemWdth * $nTabNumber

		$nHoverTab = $nTabNumber
		$plngToolTipExist = 1

		Select
			Case $nTabNumber = $conTab_TypeBible
				ToolTip ("")
				ToolTip  ( GetBibibleADD ($nTabNumber))

			Case $nTabNumber = $plng_SearchDef ;and $lngExtraFormOpen <> 0
				$nHoverTab = $nTabNumber
				;If $lngExtraFormOpen = 1 Then
					ToolTip ("صفحة البحث" )
				;Else
				;	ToolTip ("اضغط للبحث" )
				;EndIf
				;ConsoleWrite ("$lngExtraFormOpen =" & $lngExtraFormOpen & @cr)

			Case $pconTabCloseWidth > $plngShiftPixl  And _
				($nTabNumber <>$conTab_TypeBible And $nTabNumber <> $conTab_TypeBible) And _
				($nTabNumber <= $plng_CreatedTabs)
				;ToolTip ("إغلق الشريط" & " (Ctrl+W)" )
				ToolTip ("(Ctrl+W) " & "إغلق الشريط" )


			Case $nTabNumber <= $plng_CreatedTabs
				ToolTip  ( GetBibibleADD ($nTabNumber))

			;Case Else
			;	ToolTip ("")
		EndSelect

		;$bToolbarFlag = 0
EndFunc

;---------------------------------------------------------------------------------------------------------
Func MouseLeftClick ()
	Local $a_MousePos = GUIGetCursorInfo  ($frmMainForm)
	Local $lngPos, $nTabNumber, $lngItemWdth
	If $htab <> $a_MousePos [4] and $a_MousePos[2] <>1  Then Return

	$nTabNumber = $nHoverTab
			if $pconTabCloseWidth > $plngShiftPixl  and  $nTabNumber <>$conTab_TypeBible and $nTabNumber <> $conTab_TypeBible Then
					;ConsoleWrite ("------------Close Tab-----------"  & $nTabNumber & "  Shift="& $plngShiftPixl &  @Cr)
					;CloseTab_Step2 ($nTabNumber)
					TabCloseHover ()
				Else
					;ConsoleWrite ("------------Normal Tab Action---"  & $nTabNumber & "  Shift="& $plngShiftPixl &@Cr)
					If $nTabNumber <> $plng_CurrTabNo then
						hTab_Change ()
					EndIf
			EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------
