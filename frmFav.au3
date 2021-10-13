
Global Const $strSecRoot = "RootFiles"
Global Const $strSecRootDesc = "الرئيسي"

Dim $strFavINI = FolderFileName ($gconINI_Fav, 1)
;---------------------------------------------------------------------------------------------
Func cmdFavManag_Click ()
	;Local $FormID = 32
	Local $conGetFavManagTit = "إدارة المفضلات"

	Const $conLeft =10
	Const $conTop = 10
	Const $GUIWidthFav= 440, $GUIHeightFav = 350

	Local $cmdOK, $cmdCancel, $cmdNewFolder, $cmdDelete, $cmdDeleteSec

	Local $lstFav
	Local $ctrlSec

	Local $lngItem, $a_INI_items, $data, $Msg, $data, $data2, $lngPos

	Local $cmbFolders

	$frmListFav = GUICreate($conGetFavManagTit, $GUIWidthFav, $GUIHeightFav ,-1,-1, _
								formStyle (), formExStyle (), $frmMainForm )
			GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmListFav)

	$cmbFolders = GUICtrlCreateCombo ("", $conLeft + 80, $conTop , 200, 25, BitOR ($CBS_SIMPLE,$GUI_SS_DEFAULT_COMBO))
		GUICtrlSetData ( $cmbFolders, FillCombo ($cmbFolders, $strFavINI) ,$strSecRootDesc)
		GUICtrlCreateLabel("الدليل", $conLeft, $conTop , 70, 20)

	$cmdDeleteSec = GUICtrlCreateButton("أ&حذف دليل", $conLeft + 300, $conTop, 100, 30)
;=========================

	$lstFav = GUICtrlCreateListView ("كود|الشاهد|الاسم", $conLeft, $conTop + 60, $GUIWidthFav -30, $GUIHeightFav - 150)
			_GUICtrlListView_SetColumnWidth($lstFav, 0, 0)
			_GUICtrlListView_SetColumnWidth($lstFav, 1, 40)
			_GUICtrlListView_SetColumnWidth($lstFav, 2, 200)

	$data = GUICtrlRead ( $cmbFolders )
	if $data = "" Then
		$data = $strSecRootDesc
	EndIf

	$cmdOK = GUICtrlCreateButton("إذهـب الى", $conLeft , $GUIHeightFav - 50, 100, 30, $BS_DEFPUSHBUTTON )
		GUICtrlSetState ( $cmdOK, $GUI_DISABLE)
	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $conLeft + 110, $GUIHeightFav -50, 100, 30)
	$cmdDelete = GUICtrlCreateButton("إحـــذف", $conLeft + 220, $GUIHeightFav - 50, 100, 30)

		if 0 = FillListData ($data, $lstFav) Then
			GUICtrlSetState ( $cmdOK, $GUI_DISABLE)
			GUICtrlSetState ( $cmdDelete, $GUI_DISABLE)
		Else
			GUICtrlSetState ( $cmdOK, $GUI_EnABLE)
			GUICtrlSetState ( $cmdDelete, $GUI_EnABLE)
		EndIf

	GUISetState(@SW_SHOW)
	GUICtrlSetState ($cmbFolders, $GUI_FOCUS)

	While 1
		$Msg = GUIGetMsg(1)
		Select

			Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
					MainForm_Close ()
					Return
			Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmListFav)
				frmForm_Close ($frmListFav)
				Return

			Case $Msg[0] = $cmbFolders
				GUICtrlSetState ( $cmdOK, $GUI_Disable)
				$data = GUICtrlRead ( $cmbFolders )
				if $data = "" Then
					$data = $strSecRootDesc
				EndIf
				if 0 = FillListData ($data, $lstFav) Then
					GUICtrlSetState ( $cmdOK, $GUI_DISABLE)
					GUICtrlSetState ( $cmdDelete, $GUI_DISABLE)
				Else
					GUICtrlSetState ( $cmdOK, $GUI_EnABLE)
					GUICtrlSetState ( $cmdDelete, $GUI_EnABLE)
				EndIf

			Case $Msg[0] = $cmdDeleteSec
				IniDelSec  ($lstFav, $cmbFolders)
				If _GUICtrlListView_GetItemCount($lstFav) =0 Then
					GUICtrlSetState ($cmdDelete, $GUI_Disable)
				endif


			Case $Msg[0] = $cmdDelete
				$data = GUICtrlRead ( GUICtrlRead($lstFav) )

				$lngPos = StringInStr ( $data, "|" )
				if $lngPos > 1 Then
					$data = StringMid ( $data, 1, $lngPos -1)
				Else
					$data = ""
				EndIf

				$data2 = GUICtrlRead ( $cmbFolders )
				if $data2 = "" Then
					$data2 = $strSecRootDesc
				EndIf
;==========
				;IniDelItem ( $item, $strSec, $lstFav)
				if 1= IniDelete ( $strFavINI, Uni2Hex ($data2)) Then
					_GUICtrlListView_DeleteItemsSelected ($lstFav)
				EndIf

				If _GUICtrlListView_GetItemCount($lstFav) =0 Then
					GUICtrlSetState ($cmdDelete, $GUI_Disable)
				endif

				;IniDelItem  ($data,  $data2 ,$lstFav)
			Case $Msg[0] = $cmdOK
				$data = GUICtrlRead ( GUICtrlRead($lstFav) )

				$lngPos = StringInStr ( $data, "|" )
				if $lngPos > 1 Then
					$data = StringMid ( $data, 1, $lngPos -1)
				Else
					$data = ""
				EndIf

				frmForm_Close ($frmListFav)
				;MsgBox (0,$data, "Show Bible here")
				Return $data

		EndSelect
	WEnd
EndFunc
;---------------------------------------------------------------------------
Func IniDelSec ($lstFav, $cmbFldr)
	Local $strSec = GUICtrlRead ( $cmbFldr )
	if $strSec = "" then Return

	if 7 = Msgbox($conMirrorR2L + 4 + 262144 + 524288,$gconProgName, "حذف الدليل " & $strSec & @cr & _
						                              " بكل محتوياتة" & @cr & _
													  " هل انت متاكد و تريد الحذف ؟") Then
			Return
	EndIf

	if 1=IniDelete ( $strFavINI, Uni2Hex ($strSec)) then
		_GUICtrlListView_DeleteAllItems ($lstFav)
	EndIf

	GUICtrlSetData ($cmbFldr , "")
	GUICtrlSetData ($cmbFldr , FillCombo ($cmbFldr, $strFavINI) , $strSecRootDesc)

	$strSec = GUICtrlRead ( $cmbFldr )

	FillListData ( $strSec, $lstFav)
EndFunc
;---------------------------------------------------------------------------
;Func IniDelItem ( $item, $strSec, $lstFav)
;	;MsgBox(0,"",$strSec & " " & $item)
;	if 1= IniDelete ( $strFavINI, Uni2Hex ($strSec), $item) Then
;		_GUICtrlListView_DeleteItem ($lstFav, $item)
;	EndIf
;
;	If _GUICtrlListView_GetItemCount($lstFav) =0 Then
;		GUICtrlSetState ($cmdDelete, $GUI_Disable)
;	endif
;
;	;FillListData ( $strSec, $lstFav)
;EndFunc
;---------------------------------------------------------------------------
Func FillListData ($data, $lstFav )
	Local $strItem, $strText
	Local $a_INI_items = IniReadSection ($strFavINI, Uni2Hex ($data))
	Local $lngBib, $lngChp, $LngAFr, $LngATo;, $lngMaxAy, $lngMaxCh
	Local $LngFlg

	if @error=1 then Return 0

	;_ArrayDisplay ($a_INI_items)
	_GUICtrlListView_DeleteAllItems ($lstFav)

	if IsArray ($a_INI_items) then
		For $lngItem = 1 to $a_INI_items [0][0]

			$strItem = $a_INI_items [$lngItem][0]

			$lngBib = Dec (StringMid ($strItem, 1,2 )) ; fist chr
			$lngChp = Dec (StringMid ($strItem, 3,2 ))
			$LngFlg = Dec (StringMid ($strItem, 5,2 ))
			$LngAFr = Dec (StringMid ($strItem, 7,2 ))
			$LngATo = Dec (StringMid ($strItem, 9,2 ))

			If False = ChkIfValid ( $lngBib, $lngChp, $LngAFr, $LngATo) then ContinueLoop

		;-----------------
			if $LngFlg <1 then
				if $LngAFr  = 0 Or $LngATo = 0 Then ; safety will not happen allway both > 0 cheked in ChkIfValid
					$strText =  $acShort[$lngBib] & " " & Num2India($lngChp)
				ELse
					$strText = $acShort[$lngBib] & " " & Num2India($lngChp) & " : " & Num2India($LngAFr ) & "-" & Num2India($LngATo)
				Endif
			Else
				$strText = $acShort[$lngBib] & " " & Num2India($lngChp) & " : " & Num2India($LngFlg )
			EndIf

			GUICtrlCreateListViewItem ( $strItem & "|" & _
										$strText & "|" & _
										Hex2Uni($a_INI_items [$lngItem][1]) , $lstFav)
		Next
	Else
		Return 0
	EndIf

	_GUICtrlListView_SetItemSelected ( $lstFav, 0)
	Return 1
EndFunc
;---------------------------------------------------------------------------
Func cmdFavAdd_Click ($lngTab)

	Local $conGetFavManagTit = "إضـافة الى المفضـلات"
	Const $conLeft =10
	Const $conTop = 10

	Local $cmdOK, $cmdCancel, $cmdNewFolder, $txtName, $cmbFolders
	Local $strEntry
	Local $data, $Msg
	Local $strAddress = GetTabInfo($lngTab)
	Local $strDesc = GetBibibleADD ($lngTab)

	$frmAddFav = GUICreate ($conGetFavManagTit, 420, 180 ,-1,-1, _
								formStyle (), formExStyle (), $frmMainForm )
		GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $frmAddFav )

	GUICtrlCreateLabel("الوصــف : " & $strDesc, $conLeft + 00, $conTop + 00, 320 + 40, 25)

	$txtName = GUICtrlCreateInput ($strDesc , $conLeft + 70, $conTop + 40 , 320, 24)
		GUICtrlCreateLabel("الاسـم:", $conLeft, $conTop + 40 , 70, 20)

	$cmbFolders = GUICtrlCreateCombo ("", $conLeft + 70, $conTop + 80, 200, 25, BitOR ($CBS_SIMPLE,$GUI_SS_DEFAULT_COMBO))
		GUICtrlSetData ( $cmbFolders, FillCombo ($cmbFolders, $strFavINI) ,$strSEcRootDesc)
		GUICtrlCreateLabel("الدليل:", $conLeft, $conTop +80, 70, 20)

	$cmdNewFolder = GUICtrlCreateButton("دليل جديد", $conLeft + 300, $conTop + 80, 100, 30, 0)

	$cmdOK = GUICtrlCreateButton("أ&ضــف", $conLeft + 170, $conTop + 120, 100, 30, $BS_DEFPUSHBUTTON)
	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $conLeft + 300, $conTop +120, 100, 30)

	GUISetState(@SW_SHOW)
	GUICtrlSetState ($txtName, $GUI_FOCUS)
	;Opt("GUIOnEventMode", 0)

While 1
	$Msg = GUIGetMsg(1)
	Select
		Case  $msg[0] = $GUI_EVENT_CLOSE and $msg[1] = $frmMainForm and _IsPressed ("1B") = 0; esc
				MainForm_Close ()
				Return
		Case  ($msg[0] = $GUI_EVENT_CLOSE or $msg[0] = $cmdCancel) and ($msg[1] = $frmAddFav)
			frmForm_Close ($frmAddFav)
			Return

		Case $Msg[0] = $cmdOK
			$data = GUICtrlRead ($txtName)
			if $data = "" Then Return
			;$data = ConvertNumInd ($data)
			;MsgBox (0,"", $data)
			;$data = StringSplit ($data,3)
			Wrt2INI ($strFavINI, GUICtrlRead($cmbFolders) , $strAddress, $data )
			frmForm_Close ($frmAddFav)
			Return

		Case $Msg[0] = $cmdNewFolder

			$strEntry = InputCreatBox ( $frmAddFav )
			if $strEntry <> "" Then

					$data =  $strEntry & "|" & GUICtrlRead ( $cmbFolders )
					GUICtrlSetData ( $cmbFolders, "" )
					GUICtrlSetData ( $cmbFolders, $data, $strEntry )
					 ;GUICtrlSetData ( $cmbFolders, $data )
			endif
	EndSelect
WEnd
EndFunc

;---------------------------------------------------------------------------
Func Wrt2INI ($strFile, $strSec, $strKey, $strDesc)
	Local $Flag

	$Flag = IniWrite ( $strFile, _
					   Uni2Hex ($strSec) , _
					   $strKey , _
					   Uni2Hex ($strDesc)  )

	;MsgBox (0,"", $Flag)
	Return $Flag
EndFunc

;---------------------------------------------------------------------------

Func FillCombo (ByRef $cmbFav, $strFavINI)
	Local $a_INISections,  $items
	Local $lngCnt

	if not FileExists ($strFavINI)  Then
		;_IniWriteEx ( $strFavINI, $strSecRoot, $strSearchFileKey, $str )
		Return $strSEcRootDesc
	EndIf

	$a_INISections = IniReadSectionNames ($strFavINI)

	If @error Then
		;TrayTip ( $gconProgName, "ملف المفضلات فارغ - او خطأ فى القراءة", 30 , 3 )
		;MsgBox(4096, "", "put tray indication error read file.")
		WrtStatus ("ملف المفضلات فارغ - او خطأ فى القراءة", $pconStatusInfo)
		Return $strSEcRootDesc
	EndIf
	;$items = _ArrayToString ($a_INISections, "|", 1,  $a_INISections[0])

	;_ArrayDisplay ($a_INISections )

	For $lngCnt = 1 to $a_INISections[0]
		$items = $items & "|" & Hex2Uni ($a_INISections[$lngCnt])
	Next

	if StringInStr ($items, $strSEcRootDesc ) = 0 Then
		$items = $strSEcRootDesc & $items
	Else
		$items = StringTrimLeft ($items,1)
	EndIf

	Return $items

EndFunc
;---------------------------------------------------------------------------

Func InputCreatBox ( byref $MotherForm )
	Const $conGetFavNewFolder = "مجلد جديد"
	Const $conLeft =10
	Const $conTop = 10
	Local $txtName, $cmdCancel, $cmdok, $InputForm, $strEntry
	Local $Msg

	$InputForm = GUICreate($conGetFavNewFolder, 360, 120,-1,-1, _
								formStyle (), formExStyle (), $MotherForm )
	GUISetFont ($pstrMenuFSize, $pstrMenuWeight, $pstrMenuAttr, $pstrMenuFont, $InputForm)

	$txtName = GUICtrlCreateInput("", $conLeft , $conTop +35 , 220, 24)
		GUICtrlCreateLabel("أسـم الدليل", $conLeft, $conTop , 100, 20)

	$cmdOK = GUICtrlCreateButton("أ&ضـافة", $conLeft + 230, $conTop + 00, 100, 30, $BS_DEFPUSHBUTTON )
	;GUICtrlSetState ($cmdok, $GUI_Disable)
	$cmdCancel = GUICtrlCreateButton("إلغاء الامر", $conLeft + 230 , $conTop +50, 100, 30)

	GUISetState(@SW_SHOW)

While 1
	$Msg = GUIGetMsg()
	Select
		Case  $Msg = $GUI_EVENT_CLOSE  or  $Msg = $cmdCancel
			GUIDelete ($InputForm)
			Return ""

		Case  $Msg = $cmdOK

			if GUICtrlRead($txtName) <> "" Then
				$strEntry = GUICtrlRead($txtName)

				GUIDelete ($InputForm)
				Return $strEntry
			EndIf

	EndSelect
WEnd
EndFunc
;---------------------------------------------------------------------------
Func frmForm_Close ( byref $strMyForm)

	IF IsPtr ( $strMyForm ) Then
		GUIDelete($strMyForm)
		$strMyForm = 0
	EndIf
EndFunc
;---------------------------------------------------------------------------------------------------------------------------
