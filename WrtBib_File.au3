#include "modStringTools.au3"
;#include "modGlobal.au3"
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <Array.au3>

Opt('MustDeclareVars', 1)
;$pstrMenuFSize =010 $pstrMenuWeight=400 $pstrMenuAttr=0 $pstrMenuFont=Tahoma
;http://files.myopera.com/aymhenry/blog/ChkUpdate.bib

Global $pstrMenuFSize	= 10
Global $pstrMenuWeight	= 400
Global $pstrMenuAttr	= 0
Global $pstrMenuFont	= "Tahoma"

#cs----
	[Revsion]
		RevNum=2.00
		RevDate=2010/Dec/10
	[Others]
		Data0=
		Data1=
		Data2=
	[Valid]
		Checkvalue=123456

#ce----
;------------------------------------
Const $conFileName = "ChkUpdate.bib"
Const $conFolder = @ScriptDir & "\"

Const $conChkSec01 = "Revsion"
	Const $conSec01_Key01 = "RevNum"
	Const $conSec01_Key02 = "RevDate"
	Const $conSec01_Key03 = "RevName"

Const $conChkSec02 = "Updates"
	Const $conSec02_Key   = "Line"
	;Const $conSec02_Key01 = "Data0"
	;Const $conSec02_Key02 = "Data1"
	;Const $conSec02_Key03 = "Data2"

Const $conChkSec03 = "Valid"
	Const $conSec03_Key01 = "Checkvalue"
;------------------------------------
Start()
;------------------------------------
Func Start()
	Local $cmdSave, $cmdRead
	Local $txtSec01_Key01, $txtSec01_Key02, $txtSec01_Key03, $txtSec03_Key01

	Local $conProgWinTit = "أختبار وجود إصدار أحدث"
	Local $GUIWidthProg = 450, $GUIHeightProg =350, $GUIWidthProgEx = 200
	Local $conLeftSide = 10, $conTopSide = 10
	Local $bStatus, $lngBytes, $lblInfo, $lngFeedBack

    Local $txtInfo, $msg, $GUI

    $GUI = GUICreate("Read-Write My BIB file", 320, 120, @DesktopWidth / 2 - 160, @DesktopHeight / 2 - 45, -1, 0x00000018); WS_EX_ACCEPTFILES

	$GUI = GUICreate (  $conProgWinTit, $GUIWidthProg + $GUIWidthProgEx, $GUIHeightProg , -1,-1, _
			BitOR ($GUI_SS_DEFAULT_GUI,$WS_SIZEBOX,$WS_CAPTION, $WS_MINIMIZEBOX,$WS_MAXIMIZEBOX ), $WS_EX_LAYOUTRTL )
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $GUI )

	GuiCtrlCreateGroup("اختبار وجود إصدار احدث من البرنامج", $conLeftSide, $conTopSide, _
						$GUIWidthProg  -2*$conLeftSide,  $GUIHeightProg - 60 ,-1, $WS_EX_TRANSPARENT)

	GuiCtrlCreateGroup("بيانات إضافية", $GUIWidthProg + $conLeftSide, $conTopSide, _
						$GUIWidthProgEx  -2*$conLeftSide,  $GUIHeightProg - 60 ,-1, $WS_EX_TRANSPARENT)

	$txtInfo = GUICtrlCreateEdit ( "", 2*$conLeftSide ,4*$conTopSide, $GUIWidthProg-4*$conLeftSide , $GUIHeightProg-120 )


	$txtSec01_Key01 = GUICtrlCreateInput ( "",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 30, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )
					  GUICtrlCreateLabel ( "رقم الاصدار",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 5 + 00, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )


	$txtSec01_Key02 = GUICtrlCreateInput ( "",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 30*3, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )
					  GUICtrlCreateLabel ( "تاريخ الاصدار",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 5 + 30*2, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )

	$txtSec01_Key03 = GUICtrlCreateInput ( "",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 30*5, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )
					  GUICtrlCreateLabel ( "اسـم الاصدار",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 5 + 30*4, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )

	$txtSec03_Key01 = GUICtrlCreateInput ( "",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 30*7, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )
					  GUICtrlCreateLabel ( "رقم تعريف",  $GUIWidthProg + 2*$conLeftSide ,4*$conTopSide + 5 + 30*6, _
					$GUIWidthProgEx - 4*$conLeftSide, 25 )
	;GUICtrlSetData ($txtInfo, ReadData() )
	#Cs---
	GUICtrlSetData ($txtInfo, _
										    "1- الاسفار القانونية الثانية بالتشكيل." & @CRLF & _
											"2- تعديلات فى شكل الايقونات و القوائم." &  @CRLF & _
											"3- الوصول الى الاية بواسطة الاسم المختصر." & @CRLF & _
											"4- تحسين شكل الايقونات و القوائم." & @CRLF & _
											"5- الاتصال بالانترنت لتحديث البرنامج." & @CRLF & _
											"6- وضع روابط التحميل." & @CRLF & _
											"7- إضافة عناوين فرعية لموضوعات الانجيل." & @CRLF & _
											"8-تحسين كفائة و سرعة البحث." & @CRLF & _
											"9- تعديلات اخرى." )
	#CE---

	$cmdSave = GUICtrlCreateButton("إحفـظ", $conLeftSide , $GUIHeightProg-40 , 100, 30 )
		GUICtrlSetState (-1, $GUI_DISABLE)

	$cmdRead = GUICtrlCreateButton("أقـرأ", $conLeftSide +110, $GUIHeightProg-40 , 100, 30 )

    GUISetState()

    $msg = 0
    While $msg <> $GUI_EVENT_CLOSE
        $msg = GUIGetMsg()
        Select
			Case $msg = $cmdRead
				GUICtrlSetData ($txtInfo, ReadData() )

				GUICtrlSetData ($txtSec01_Key01, Hex2Uni(IniRead($conFolder & $conFileName, $conChkSec01, $conSec01_Key01,"" ) ))
				GUICtrlSetData ($txtSec01_Key02, Hex2Uni(IniRead($conFolder & $conFileName, $conChkSec01, $conSec01_Key02,"" ) ))
				GUICtrlSetData ($txtSec01_Key03, Hex2Uni(IniRead($conFolder & $conFileName, $conChkSec01, $conSec01_Key03,"" ) ))

				GUICtrlSetData ($txtSec03_Key01, Hex2Uni(IniRead($conFolder & $conFileName, $conChkSec01, $conSec03_Key01,"" ) ))

				GUICtrlSetState ($cmdSave, $GUI_EnABLE)
				MsgBox (0,"Info.", "Data Read",3)

            Case $msg = $cmdSave
                SaveData (GUICtrlRead ($txtInfo))

				IniWrite($conFolder & $conFileName, $conChkSec01, $conSec01_Key01, Uni2Hex(GUICtrlRead ($txtSec01_Key01) ))
				IniWrite($conFolder & $conFileName, $conChkSec01, $conSec01_Key02, Uni2Hex(GUICtrlRead ($txtSec01_Key02) ))
				IniWrite($conFolder & $conFileName, $conChkSec01, $conSec01_Key03, Uni2Hex(GUICtrlRead ($txtSec01_Key03) ))

				IniWrite($conFolder & $conFileName, $conChkSec01, $conSec03_Key01, Uni2Hex(GUICtrlRead ($txtSec03_Key01) ))


			   MsgBox (0,"Info.", "Data Save",3)
        EndSelect
    WEnd

EndFunc   ;==>Example
;----------------------------------------------

Func SaveData ($strText)
	Local $a_INISections
	Local $lngCnt, $items

	if Not FileExists ($conFolder & $conFileName)  Then
		MsgBox (16,"Error", "File is Not found")
		Return 0
	EndIf

	$a_INISections = StringSplit  ($strText, @CRLF, 1)

	;_ArrayDisplay ($a_INISections )

	For $lngCnt = 1 to $a_INISections[0]
		$items = Uni2Hex ($a_INISections[$lngCnt])
		IniWrite ( $conFolder & $conFileName, $conChkSec02, $conSec02_Key & $lngCnt - 1, $items)
	Next

EndFunc
;-------------------------------------------------------------------------
Func ReadData ()
	Local $a_INISections
	Local $lngCnt, $items

	if Not FileExists ($conFolder & $conFileName)  Then
		MsgBox (16,"Error", "File is Not found")
		Return ""
	EndIf

	$a_INISections = IniReadSection ($conFolder & $conFileName, $conChkSec02)
	if @error=1 Then
		MsgBox (16,"Error", "Cannot read file")
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