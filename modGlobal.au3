;====================================================
;================= Global Constant =================
#include-once
; main form
Global $frmMainForm

;-- basic data
;--========== Basic Data Holder
Global $cmbBible
Global $avArray[75], $cBibleChpts, $acShort[75] ; $acBible[75],

; --modTabs
;--========= Array to Hold Tah info
Global $lngExtraFormOpen
Global Const $pconMaxTabs = 50
Global $a_hTabObject [$pconMaxTabs + 1];[1] ; CloseTab_Step2 has to be fixed if two dim

Global $a_hTabIDs [2] ; only 2

; for tabs
Global $plng_BibleDef = 0			; Bible default TAB
Global $plng_SearchDef = 1			; Search default TAB

Global $plng_CurrTabNo = 0			; Curr tab
Global $plng_CreatedTabs = -1				; total created tabs
Global $plng_SettingTabs = -1				; total created tabs


Global $conTab_TypeBible = "B"	; only one char to change ;check modIniFile:Txt2Setting
Global $conTab_TypeSearch ="S"

; ---- modStyles
;-============ Constants to Read From Def. Strings =====
		Global Const $conPosSize = 1		; ReadDefVal ($conDefBible1Font, $conPosSize)
		Global Const $conPosFColor = 5		; ReadDefVal ($conDefBible1Font, $conPosFColor)
		Global Const $conPosBColor = 12		; ReadDefVal ($conDefBible1Font, $conPosBColor)
		Global Const $conPosAttr = 19		; ReadDefVal ($conDefBible1Font, $conPosAttr)
		Global Const $conPosFName = 24		; ReadDefVal ($conDefBible1Font, $conPosFName)


;--========= Main Form Data
Global Const $conRemove = "51-4E-4B-4F-4C-50-4D-52"
Global $strTachChr = ChrTach ($conRemove)

Global const $conSrchFlag = "Bible_"
Global const $conSrchHTML_Txt = "txtAdd"
Global const $conSrchHTML_OnClick = "onclick="; keep lower case

Global $PDF = chrw (0x202e), $RLE = chrw (0x202B), $R2L = chrw (0x200F)

Global  $icoTrayIcon, $nHoverTab, $lngOldMousePos
Global  $tryViewCont, $tryViewTach, $tryViewNum, $tryViewAya, $tryFileClose
Global  $tryAbout, $tryExit

Global $pstrSearch_rslt		; used to take feedback from IESearch to Prog

;Global $bToolbarFlag = 0
Global $bHotKeyFlag = 0
Global $pstrPgDnUp = "N"
Global $lngUpdateFlag = 0

Global $oIE, $oIESearch
Global $hTab, $hProg, $cmdOK_Stop, $lngTahb_Left, $grp

;--========== File Names

Global Const $gconDB_Folder = "DataFiles"

Global Const $gconDB_Main  = "BibleMan02.bib"
Global Const $gconDB_App   = "BibleApp02.bib"
Global Const $gconDB_Kamos = "BibleKam02.bib"

Global Const $gconINI_Setting = "BibleSet02.ini"
Global Const $gconINI_Fav = "BibleFav02.ini"

;--========= Global Form data
Global $pstrMenuFont = "Tahoma" ; "Traditional Arabic";
Global $pstrMenuFSize = 8;10
Global $pstrMenuAttr = 0
Global $pstrMenuWeight = 400

;--==========  About Form Golbals
Global Const $conMyName ="aymhenry@hotmail.com"
Global const $conAndroid = "https://play.google.com/store/apps/details?id=aym.soft.bible"
Global const $conFaceBook = "https://m.facebook.com/Alengeel2/?ref=bookmarks"
Global const $conWebSite = "https://sites.google.com/view/alengeel/"
Global const $conWebDownload = "https://drive.google.com/file/d/1odXVTiY-2T0_4OhJG7KfOD6Eq3SyH6tk/view?usp=sharing"

Global Const $gconProgName ="الكتاب المقدس"
Global Const $gconProgNameBigName ="كِتَابٌ كُلِّ الْعُصُورِ - الْكِتَابِ الْمُقَدَّسِ"

;--=========  General Used Vars
Global Const $conMirrorR2L = 0x100000;0x180000

;================================
Global $IE_Upper = "a_top" ;
Global $IE_Lower = "b_down";
;================================
Global const $conItem = 73
Global const $conNewTest = 47

Global const $conStartNo = 1
Global Const $conFileName = 047

;--========== Database Holder
Global $objDBS ;As DAO.Database System
Global $objMyDB; link to my data base
Global $conSysPassWord = "PleaseUseDoNotChange"
Global $recRecset; rec

;--========== Bible Add ================
Global $lngMaxValue
Global $lngMaxAya
Global $txtChptr

;--========= Others
;Global $lblTachInfo
;Global $pstrStatisbarVal
Global $plngMenuHight

;--========= Starts
Global Const $pconStatusBible = 5
Global Const $pconStatusInfo = 6
Global Const $conStatusMain = "الانجيل بالتشكيل - التفسير التطبيقى للكتاب"
;Global Const $conSatusTash = "الاصحاح لا يحتوى على تشكيل للحروف"
Global Const $conEndHTML = "</body></html>"

;---------------------------------------------------------------------------------------------------------------------------
Func ChrTach ($strASC)
	Local $nCnt, $strChrs
	for $nCnt = 1 to Stringlen($strASC) step 3
		$strChrs = $strChrs & Chrw(Dec( "006" &   StringMid($strASC, $nCnt ,2)  ) )

	Next
	Return $strChrs
EndFunc