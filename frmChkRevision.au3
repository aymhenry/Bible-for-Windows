;-----------------------------------Del this
;Opt ('MustDeclareVars', 1)
;#include "K:\Ayman\Bible\Bible\Rev023\EOC\modInclude.au3"
;$conRevInfo = 2.00
;$frmMainForm =-7777

;-----------------------------------
Global $lngpTest = 0; 0 No 1 yes
Global $hChkProg, $strFileTo, $plngStep = 0,  $lblInfo

Const $conFile = "http://files.myopera.com/aymhenry/blog/ChkUpdate.bib"
Const $conFileBytes = 16384; 105 16,384
Const $conFolderTo = @TempDir & "\"

;------------------------------------
Const $conChkSec01 = "Revsion"
	Const $conSec01_Key01 = "RevNum"
	Const $conSec01_Key02 = "RevDate"
	Const $conSec01_Key03 = "RevName"

Const $conChkSec02 = "Updates"
	Const $conSec02_Key   = "Line"

Const $conChkSec03 = "Valid"
	Const $conSec03_Key01 = "Checkvalue"
;--------------------------------------
;ConsoleWrite ($conFolderTo & $strFileTo & @cr)
;cmdChkUpdate_Click ()

Func cmdChkUpdate_Click ()

	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf
	$lngExtraFormOpen  = 1
	;------------------
	$strFileTo = Random (1 , 100, 1) & "_" & @YDAY & @MON & @MDAY & @HOUR & @MIN & @SEC & ".ini"
	;ConsoleWrite ($strFileTo & @cr)

	Local $cmdCancel, $msg, $cmdNext, $cmdGoPage, $cmdHome
	Local $conProgWinTit = "أختبار وجود إصدار أحدث"
	Local $GUIWidthProg = 450, $GUIHeightProg =350
	Local $conLeftSide = 10, $conTopSide = 10

	$frmChkProg = GUICreate($conProgWinTit, $GUIWidthProg, $GUIHeightProg, -1,-1, _
						formStyle (), formExStyle (), $frmMainForm )

		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmChkProg )
	GuiCtrlCreateGroup("اختبار وجود إصدار احدث من البرنامج", $conLeftSide, $conTopSide, _
						$GUIWidthProg  -2*$conLeftSide,  $GUIHeightProg - 60 ,-1, $WS_EX_TRANSPARENT)

	$hChkProg = GUICtrlCreateProgress ( 2* $conLeftSide, $GUIHeightProg-80, $GUIWidthProg  -4*$conLeftSide, 15, $PBS_SMOOTH)

		GUICtrlSetState ($hChkProg, $GUI_HIDE)
		GUICtrlSetData ($hChkProg, 0)

	$lblInfo = GUICtrlCreateLabel ( "الإصدار الحالى : " & $conRevNum & @CR & _
					"يعمل هذا المساعد على التاكد من أن " & _
					"هذة النسخة من البرنامج هى الاحدث ."  & @CR & _
					"فى حالة وجود نسخة أحدث على المستخدم" & " "  &  _
					"الدخول الى موقع البرنامج - او رابط تنزيل البرنامج " & _
					"الموجودة فى قائمة تعليمات" & @cr & @cr & _
					"يستغرق هذا الأختبار أقل من دقيقة - هل تريد الإستمرار ؟" _
					,2*$conLeftSide ,4*$conTopSide, $GUIWidthProg-4*$conLeftSide , $GUIHeightProg-120 )


	$cmdCancel = GUICtrlCreateButton("إلغاء الامر",  $conLeftSide,       $GUIHeightProg-40 , 100, 30 )
	$cmdNext = GUICtrlCreateButton("التـالى",      2*$conLeftSide + 100, $GUIHeightProg-40 , 100, 30 )

	$cmdGoPage = GUICtrlCreateButton("تحمــيل",    3*$conLeftSide + 200, $GUIHeightProg-40 , 100, 30 )
	$cmdHome = GUICtrlCreateButton("موقع البرنامج",4*$conLeftSide + 300, $GUIHeightProg-40 , 100, 30 )

	GUICtrlSetState ($cmdNext, $GUI_DEFBUTTON)
	GUICtrlSetState ($cmdGoPage, $GUI_HIDE)
	GUICtrlSetState ($cmdHome, $GUI_HIDE)

	GUISetState(@SW_SHOW)
	GUICtrlSetState ($cmdNext, $GUI_FOCUS)

	if $lngpTest = 1 Then
		MsgBox (16,"Test", "This is a test Version")
	EndIf

	Opt("GUIOnEventMode", 0)
	While 1
		$msg = GUIGetMsg(1)

		;if $msg[0]  <> 0 Then
		;ConsoleWrite ( "$msg[0]=" & $msg[0] & " Cancel=" & $cmdCancel & @CR)
		;EndIf

		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmChkProg)
				frmChkProg_Close ()
				Return
			Case $msg[0] = $cmdHome
				cmdOfcPage_Start ()
				frmChkProg_Close ()
				Return
			Case $msg[0] = $cmdGoPage
				cmdLoadPage_Start ()
				frmChkProg_Close ()
				Return
			Case $msg[0] = $cmdNext
					;ConsoleWrite ("$plngStep " & $plngStep & @cr)
					Switch $plngStep
						Case 0
							if GotoStep01 ($hChkProg, $cmdNext, $cmdCancel, $cmdGoPage, $cmdHome) Then
								$plngStep  = 1
							EndIf
						Case 1
							;$plngStep  = 2
							GotoStep02 ($hChkProg, $cmdNext, $cmdCancel)
						;Case 2
					EndSwitch
		EndSelect
	WEnd

EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func frmChkProg_Close ()
	$lngExtraFormOpen  = 0
	IF IsPtr ( $frmChkProg ) Then
		GUIDelete($frmChkProg)
		$frmChkProg = 0
	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func ReadSection1 ()
	Const $conErrValue = "Error"
	Local $arData[5]

	$arData [0] = 4
	$arData [1] = Hex2Uni (IniRead($conFolderTo & $strFileTo, $conChkSec01, $conSec01_Key01, $conErrValue ) )
	$arData [2] = Hex2Uni (IniRead($conFolderTo & $strFileTo, $conChkSec01, $conSec01_Key02, $conErrValue ) )
	$arData [3] = Hex2Uni (IniRead($conFolderTo & $strFileTo, $conChkSec01, $conSec01_Key03, $conErrValue ) )

	$arData [4] =  Hex2Uni(IniRead($conFolderTo & $strFileTo, $conChkSec01, $conSec03_Key01, $conErrValue ) )

	if $arData [4] = $conErrValue  Or _
	   $arData [1] = $conErrValue Or _
	   $arData [2] = $conErrValue Or _
	   $arData [3] = $conErrValue Then

	   $arData [0] = 0
   EndIf

   Return $arData
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func GetFileInfo ( )

	Local $strData = ReadSection1 ()

	If $strData[0] = 0 Then
		GUICtrlSetData ($lblInfo, _
					"خطـأ فى الاتصال مع الشبكة او " & _
					"خطـأ فى محتوى ملف الاختبار. "  & @cr & @cr & _
					"تاكد من سلامة الاتصال بالشبكة الدولية للمعلومات ثم حاول مرة اخرى.")
		Return 0
	EndIf

	if $conRevNum - $lngpTest >= $strData[1] +0 Then
		GUICtrlSetData ($lblInfo, _
					"الإصدار الحـالى : " & $conRevNum   & @cr & _
					"تاريخ الاصدار : " & $conRevDate  & @cr & _
					"اسـم الاصدار  : " & $conRevInfo  & @cr & @cr & _
					"الإصدار المتاح على الشبكة : " & $strData[1] & @cr & _
					"تاريخ الاصدار : " & $strData[2] & @cr & _
					"اسـم الاصدار  : " & $strData[3] & @cr & @cr & _
					"النسخة الجارى تشغيلها هى أحدث اصدارات البرنامج" )
		Return 1
	Else
		GUICtrlSetData ($lblInfo, _
					"الإصدار الحـالى : " & $conRevNum & @cr & @cr & _
					"الإصدار المتاح على الشبكة : " & $strData[1] & @cr & _
					"تاريخ الاصدار : " & $strData[2] & @cr & _
					"اسـم الاصدار  : " & $strData[3] & @cr & @cr & _
					"لتحميل إصدار جديد من البرنامج" & @cr & _
					" الرجاء " & _
					"الدخول الى موقع البرنامج - او رابط تنزيل البرنامج " & _
					"و ذلك بالضغط على المفاتيح فى هذا النموذج او الموجودة فى قائمة تعليمات " & @cr & @cr & _
					"تعليمات - الموقع الرسمى للبرنامج او" & @cr  & _
					"تعليمات -رابط تحميل البرنامج" & @CR & @CR & _
					"اضغط التالى لبيان الجديد فى الاصدار الاحدث") ;& @cr & @cr & _
		Return -1
	EndIf

EndFunc
;-------------------------------------------------------------------------
Func ReadData ()
	Local $a_INISections
	Local $lngCnt, $items

	if Not FileExists ($conFolderTo & $strFileTo)  Then
		;MsgBox (16,"Error", "File is Not found")
		Return ""
	EndIf

	$a_INISections = IniReadSection ($conFolderTo & $strFileTo, $conChkSec02)
	if @error=1 Then
		;MsgBox (16,"Error", "Cannot read file")
		Return ""
	EndIf

	;_ArrayDisplay ($a_INISections )

	For $lngCnt = 1 to $a_INISections[0][0]
		;MsgBox(4096, "", "Key: " & $var[$i][0] & @CRLF & "Value: " & $var[$i][1])
		$items = $items & Hex2Uni ($a_INISections[$lngCnt][1]) & @CRLF
	Next
	$items = StringTrimRight ( $items, 2)

	Return $items
EndFunc
;-------------------------------------------------------------------------
Func GotoStep02 ($hChkProg, $cmdNext, $cmdCancel)
	Local $strItem = ReadData ()

	GUICtrlSetState ($hChkProg, $GUI_HIDE)
	GUICtrlSetData ($cmdCancel, "إغـلاق")
	GUICtrlSetState ($cmdNext, $GUI_DISABLE)

	GUICtrlSetData ($lblInfo, $strItem)
EndFunc
;-------------------------------------------------------------------------
Func GotoStep01 ($hChkProg, $cmdNext, $cmdCancel, $cmdGoPage, $cmdHome)

	Local $bStatus = True, $hDownload, $msg, $lngBytes, $lngFeedBack

	GUICtrlSetState ($hChkProg, $GUI_Show)
	GUICtrlSetState ($cmdNext, $GUI_DISABLE)

	$hDownload = InetGet($conFile, $conFolderTo & $strFileTo, 1, 1)

	Do
		Sleep(250)
		;ConsoleWrite ("Download:" & InetGetInfo($hDownload, 0) & @CR)
		$msg = GUIGetMsg(1)

		If ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) Then
			InetClose($hDownload)
			GUICtrlSetData ($lblInfo, "تم إلغاء العمل بواسطة المستخدم.")
			GUICtrlSetState ($hChkProg, $GUI_HIDE)
			$bStatus = False
			ExitLoop
		EndIf
			$lngBytes = InetGetInfo($hDownload, 0)
			GUICtrlSetData ($hChkProg, 100*$lngBytes/$conFileBytes)

	Until InetGetInfo($hDownload, 2)    ; Check if the download is complete.
	GUICtrlSetData ($hChkProg, 100)
	InetClose($hDownload)

	if $bStatus = True Then
		$lngFeedBack = GetFileInfo ()
		If $lngFeedBack = 0 or $lngFeedBack = 1 Then ; Error or Same Rev
			GUICtrlSetData ($cmdCancel, "إغـلاق")
			GUICtrlSetState ($cmdNext, $GUI_HIDE)
			Return 0
		Else ; $lngFeedBack = -1 Then ; update req.
			GUICtrlSetState ($cmdGoPage, $GUI_Show)
			GUICtrlSetState ($cmdHome,   $GUI_Show)

			GUICtrlSetState ($cmdNext,   $GUI_Show)
			GUICtrlSetState ($cmdNext, $GUI_EnABLE)
			Return 1
		EndIf
	EndIf
EndFunc