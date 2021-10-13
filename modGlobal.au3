;====================================================
;================= Global Constant =================
#include-once

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
Global Const $gstrExeFile = @ScriptDir & "\" & "Bible.exe"
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
Global Const $conRevNum  = "2.01"
Global Const $conRevDate = "يناير 2011"
Global Const $conRevInfo = "الاصدار الثانى"

Global Const $gconProgName ="الكتاب المقدس"
Global Const $gconProgNameBigName ="كِتَابٌ كُلِّ الْعُصُورِ - الْكِتَابِ الْمُقَدَّسِ"

Global Const $conMyName ="AymHenry@hotmail.com"
Global const $conWebSite = "http://my.opera.com/aymhenry/"
Global const $conWebDownload = "http://www.4shared.com/file/112953701/17b9f2a1/Bible39.htm"

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

