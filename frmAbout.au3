#Include-once

;---------------------------------------------------------------------------------------------------------------------------
Func cmdCpyWrt_Click ()
	if _WinAPI_GetForegroundWindow() <> $frmMainForm then
		Return
	EndIf

	Const $conLeftSide3 = 10, $conTop = 10
	Local $GUIWidth = 450, $GUIHeight = 280

	Local $treeview, $itm_General, $itmGen_About, $itmGen_Comp
	Local $itmDsp_Res, $lblStart, $lblAbout
	Local $itmAuthr, $itmAut_Name, $itmAut_email, $itmAut_Rev, $itmAut_Book, $itmAut_Book2, $itmAut_New
	Local $OK_Btn

	Local $msg

	$frmAbout = GUICreate("عن البرنامج" ,$GUIWidth, $GUIHeight,-1,-1, _
		formStyle (), formExStyle (), $frmMainForm)

		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmAbout )

;	$frmAbout=GUICreate("عن البرنامج", $GUIWidth, $GUIHeight,-1,-1, _
;		BitOR ($WS_CAPTION,$WS_POPUPWINDOW),  $WS_EX_TOPMOST + $WS_EX_STATICEDGE + $WS_EX_LAYOUTRTL) ;0x00800000 , $frmMainForm
		;BitOR ($DS_SETFOREGROUND,$DS_MODALFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_POPUPWINDOW),$WS_EX_TOPMOST + $WS_EX_STATICEDGE + $WS_EX_LAYOUTRTL, $frmMainForm) ;0x00800000

	$treeview = GUICtrlCreateTreeView($conLeftSide3, $conTop, 150, $GUIHeight - 2 * $conTop, _
			BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE)

	$itm_General = GUICtrlCreateTreeViewItem("بيانات الحاسب", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)

	;$itm_Display = GUICtrlCreateTreeViewItem("المستخدم", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)
	$itmAuthr = GUICtrlCreateTreeViewItem("محرر البرنامج", $treeview)
		GUICtrlSetColor(-1, 0x0000C0)

		$itmGen_About = GUICtrlCreateTreeViewItem("نظـام التشغيل", $itm_General)
		$itmGen_Comp = GUICtrlCreateTreeViewItem("المكونات الصلبة", $itm_General)
		;$itmGen_User = GUICtrlCreateTreeViewItem("الشـاشة", $itm_General)

		;$itmDsp_Res = GUICtrlCreateTreeViewItem("اسم الجهاز", $itm_Display)
		;$itmDsp_Other = GUICtrlCreateTreeViewItem("اسم المستخدم", $itm_Display)

		$itmAut_Name = GUICtrlCreateTreeViewItem("الاسم", $itmAuthr)
		$itmAut_email = GUICtrlCreateTreeViewItem("البريد", $itmAuthr)
		$itmAut_Book = GUICtrlCreateTreeViewItem("التفسير", $itmAuthr)
		$itmAut_Book2 = GUICtrlCreateTreeViewItem("قاموس الكتاب", $itmAuthr)
		$itmAut_New = GUICtrlCreateTreeViewItem("ما هو الجديد؟", $itmAuthr)
		$itmAut_Rev = GUICtrlCreateTreeViewItem("أصدار البرنامج", $itmAuthr)

	$lblAbout = GUICtrlCreateLabel  ( $conRevInfo, $conLeftSide3 + 170, $conTop , _
		$GUIWidth - 170 - 3 * $conLeftSide3,  $GUIHeight - 2 * $conTop -40, $SS_LEFT );$SS_CENTER )


 	$OK_Btn = GUICtrlCreateButton("موافق", ($GUIWidth-70)/2 + 70, $GUIHeight -$conTop -40, 100, 30, _
		BitOr($GUI_SS_DEFAULT_LABEL, $BS_DEFPUSHBUTTON))

	;GUICtrlSetState($itm_General, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "General"-item and paint in bold
	;GUICtrlSetState($itm_Display, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "Display"-item and paint in bold
	GUICtrlSetState($itmAuthr, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))    ; Expand the "Display"-item and paint in bold

	GUISetState()
	;GUICtrlSetState ($OK_Btn, $GUI_FOCUS)
	GuiCtrlSetState($itmAut_Rev, $GUI_FOCUS)

	Opt("GUIOnEventMode", 0)

	While 1

		$msg = GUIGetMsg(1)
		Select
			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $OK_Btn) and ($msg[1] = $frmABout)
				frmAbout_CLose ()
				Return

			Case $msg[0] = $itm_General
				GUICtrlSetData ($lblAbout, "معلومات عامة عن نظام التشغيل")

			Case $msg[0] = $itmGen_About

				GUICtrlSetData ($lblAbout, "النـــــوع :"  & @OSType & @CRLF & _
										   "الاصــــدار :"  & @OSVersion & @CRLF & _
										   "التعـــديل :"  & @OSServicePack & @CRLF & _
										   "الانشــــاء :"  & @OSArch & @CRLF & @CRLF & _
										   "لوحة المفاتيح :" & _Language (@KBLayout) &  @CRLF & _
										   "لغة النظام :"  & _Language(@OSLang) )

											;& @CRLF  & _
										   ;"متعدد اللغات :"& @MUILang); & @CRLF _

			Case $msg[0] = $itmGen_Comp
				GUICtrlSetData ($lblAbout, "المعـــــــالج  :" & @CPUArch & @CRLF & @CRLF & _
										   "عــرض الشـاشة :" & @DesktopWidth & @CRLF & _
										   "طــول الشـاشة :" & @DesktopHeight & @CRLF & @CRLF & _
										   "أسـم المسـتخدم :" & @UserName & @CRLF & _
										   "أسـم الجهـــاز :" & @ComputerName); & @crlf & _

			;Case $msg[0] = $itm_Display
			;	GUICtrlSetData ($lblAbout, "بيانات مستخدم الجهاز")

			;Case $msg[0] = $itmDsp_Other
			;	GUICtrlSetData ($lblAbout, @UserName)
			;Case $msg[0] = $itmDsp_Res
			;	GUICtrlSetData ($lblAbout, @ComputerName)

			Case $msg[0] = $itmAuthr
				GUICtrlSetData ($lblAbout, "عن محرر البرنامج - لارسال مقترحات- الابلاغ عن أخطاء")

			Case $msg[0] = $itmAut_Name
				GUICtrlSetData ($lblAbout, "أيمن هنرى يونان" & @CRLF & " كل الشكر لتعب من قام بادخال نص الانجيل - و كلهم ابطال مجهولون")

			Case $msg[0] = $itmAut_email
				GUICtrlSetData ($lblAbout, "البرنامج مجانى" & @CRLF & _
										   "ارسل  تقريرعن خطأ" & @CRLF & _
										  "او اقتراح للتحسين و التطوير" & @CRLF & _
										  "aymhenry@hotmail.com" & @CR & @CR & _
										  "الموقع الرسمى للبرنامج" & @CR & $conWebSite) ;& @CR & _
										  ;"التحميل" & @CR & $conWebDownload )
			Case $msg[0] = $itmAut_Book
				GUICtrlSetData ($lblAbout, "التفسير التطبيقى للكتاب المقدس" & @CRLF & _
										   " دكتور بروس بارتون و اخرون - ترجمة وليم وهبة و اخرون" &  @CRLF & @CRLF & _
											"لم تتم مراجعتة من جهة ارثوذكسية")

			Case $msg[0] = $itmAut_Book2
				GUICtrlSetData ($lblAbout, _
										   "قاموس الكتاب المقدس" & @CRLF & _
											"هيئة التحرير" &  @CRLF & _
											"الدكتور بطرس عبد الملك." & @CRLF & _
											"الدكتور جون ألكسندر طمسن." & @CRLF & _
											"الأستاذ إبراهيم مطر." & @CRLF & @CRLF & _
											"لم تتم مراجعتة من جهة ارثوذكسية")

			Case $msg[0] = $itmAut_New
				GUICtrlSetData ($lblAbout, _
										Num2India (1) & "-" & "تم إضافة التشكيل الى الاسفار القانونية الثانية." & @CRLF & _
										Num2India (2) & "-" & "إضافة عناوين فرعية لموضوعات الانجيل." &  @CRLF & _
										Num2India (3) & "-" & "تحسين كفائة و سرعة البحث." & @CRLF & _
										Num2India (4) & "-" & "الوصول الى الاية بواسطة الاسم المختصر." & @CRLF & _
										Num2India (5) & "-" & "تحسين شكل الايقونات و القوائم." & @CRLF & _
										Num2India (6) & "-" & "الاتصال بالانترنت لتحديث البرنامج." & @CRLF & _
										Num2India (7) & "-" & "وضع روابط التحميل." & @CRLF & _
										Num2India (8) & "-" & "غلق شريط التبويب بنقرة واحدة." & @CRLF & _
										Num2India (9) & "-" & "تعديلات اخرى." )

			Case $msg[0] = $itmAut_Rev
				GUICtrlSetData ($lblAbout, "اسم البرنامج: " & @Cr & _
											$gconProgNameBigName & @CR & @CR & _
										   "المحــــــتوى:" &  @CR & _
										Num2India (1) & "-" & "الكتاب المقدس بالاسفار القانونية الثانية" & @CR & _
										Num2India (2) & "-" & "التفسير التطبيقى للكتاب (3440 صفحة)." & @CR & _
										Num2India (3) & "-" & "قاموس الكتاب المقدس (1440 صفحة)." & @CR & _
										    @CR & _
											"الإصدار الحـالى : " & $conRevNum   & @cr & _
											"تاريخ الاصدار : " & $conRevDate  & @cr & _
											"اسـم الاصدار  : " & $conRevInfo  );& @cr & @cr & _
	EndSelect
	WEnd
EndFunc   ;==>Example
;---------------------------------------------------------------------------------------------------------------------------
Func frmAbout_CLose ()
;		$lngExtraFormOpen = BitAND (255-$lngFrmAboutID, $lngExtraFormOpen); ; make the first bit 3

		IF IsPtr ( $frmAbout ) Then
			GUIDelete($frmAbout)
			$frmAbout = 0
		EndIf

;msgbox (0,"", $lngExtraFormOpen)
;		if $lngExtraFormOpen =0 then Opt("GUIOnEventMode", 1)
		;	MsgBox (0,"",$lngExtraFormOpen)

		;GUISwitch ($frmMainForm)
		;WinActivate ($frmMainForm)
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
Func _Language( $Code)
	$Code = StringRight ( $Code, 4)
	Select
		Case StringInStr("0413 0813", $Code)
			Return "الهولندية"

		Case StringInStr("0409 0809 0c09 1009 1409 1809 1c09 2009 2409 2809 2c09 3009 3409", $Code)
			Return "الانجليزية"

		Case StringInStr("040c 080c 0c0c 100c 140c 180c", $Code)
			Return "الفرنسية"

		Case StringInStr("0407 0807 0c07 1007 1407", $Code)
			Return "الالمانية"

		Case StringInStr("0410 0810", $Code)
			Return "الإيطالية"

		Case StringInStr("0414 0814", $Code)
			Return "النرويجية"

		Case StringInStr("0415", $Code)
			Return "البولندية"

		Case StringInStr("0416 0816", $Code)
			Return "البرتغالية"

		Case StringInStr("040a 080a 0c0a 100a 140a 180a 1c0a 200a 240a 280a 2c0a 300a 340a 380a 3c0a 400a 440a 480a 4c0a 500a", $Code)
			Return "الاسبانية"

		Case StringInStr("041d 081d", $Code)
			Return "السويدية"

		Case Else
			Return "غير محددة"

	EndSelect
EndFunc