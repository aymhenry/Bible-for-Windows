;--========== Basic Data Holder
Global $cmbBible
Global $avArray[75], $cBibleChpts, $acShort[75] ; $acBible[75],

;CreateArray ()

;for $p= 1 to 74
;	ConsoleWrite (GetBibleChpts ($P) &@CR)
;Next
;---------------------------------------------------------------------------------------------------------------------------
Func GetBibleChpts ( $lngChptr )
	Local $lngNo = 0 + StringMid ($cBibleChpts, $lngChptr*4 -3 , 3)
	if $lngNo = 0 then $lngNo = 1
	Return $lngNo
EndFunc

Func CreateArray ()
	$avArray[001] = "التكوين"
	$avArray[002] = "الخروج"
	$avArray[003] = "اللاويين"
	$avArray[004] = "العدد"
	$avArray[005] = "التثنية"
	;------------------------------
	$avArray[006] = "يشوع"
	$avArray[007] = "القضاة"
	$avArray[008] = "راعوث"
	$avArray[009] = "صموئيل الاول"
	$avArray[010] = "صموئيل الثانى"
	$avArray[011] = "الملوك الاول"
	$avArray[012] = "الملوك الثانى"
	$avArray[013] = "أخبار الايام الاول"
	$avArray[014] = "أخبار الايام الثانى"
	$avArray[015] = "عزرا"
	$avArray[016] = "نحميا"

	$avArray[017] = "طوبيا"
	$avArray[018] = "يهوديت"
	$avArray[019] = "أستير"
	;------------------------------
	$avArray[020] = "أيوب"
	$avArray[021] = "المزامير"
	$avArray[022] = "الامثال"
	$avArray[023] = "الجامعة"
	$avArray[024] = "نشيد الانشاد"

	$avArray[025] = "الحكمة"
	$avArray[026] = "سيراخ"

	$avArray[027] = "إشعياء"
	$avArray[028] = "إرميا"
	$avArray[029] = "مراثى إرميا"

	$avArray[030] = "باروك"

	$avArray[031] = "حزقيال"

	$avArray[032] = "دانيال"
	;------------------------------
	$avArray[033] = "هوشع"
	$avArray[034] = "يوئيل"
	$avArray[035] = "عاموس"
	$avArray[036] = "عوبديا"
	$avArray[037] = "يونان"
	$avArray[038] = "ميخا"
	$avArray[039] = "ناحوم"
	$avArray[040] = "حبقوق"
	$avArray[041] = "صفنيا"
	$avArray[042] = "حجى"
	$avArray[043] = "زكريا"
	$avArray[044] = "ملاخى"

	$avArray[045] = "المكابيين الأول"
	$avArray[046] = "المكابيين الثانى"
	;------------------------------------------------------------------------
	$avArray[047] = "متى"
	$avArray[048] = "مرقس"
	$avArray[049] = "لوقا"
	$avArray[050] = "يوحنا"
	;------------------------------
	$avArray[051] = "أعمال الرسل"
	;------------------------------
	$avArray[052] = "رومية"
	$avArray[053] = "كورنثوس الاولى"
	$avArray[054] = "كورنثوس الثانية"
	$avArray[055] = "غلاطية"
	$avArray[056] = "أفسس"
	$avArray[057] = "فيلبى"
	$avArray[058] = "كولوسى"
	$avArray[059] = "تسالونيكى الاولى"
	$avArray[060] = "تسالونيكى الثانية"
	$avArray[061] = "تيموثاوس الاولى"
	$avArray[062] = "تيموثاوس الثانية"
	$avArray[063] = "تيطس"
	$avArray[064] = "فليمون"
	$avArray[065] = "العبرانيين"
	$avArray[066] = "يعقوب"
	$avArray[067] = "بطرس الاولى"
	$avArray[068] = "بطرس الثانية"
	$avArray[069] = "يوحنا الاولى"
	$avArray[070] = "يوحنا الثانية"
	$avArray[071] = "يوحنا الثالثة"
	$avArray[072] = "يهوذا"
	;------------------------------
	$avArray[073] = "رؤيا يوحنا"

	$cBibleChpts = _
			"050 040 027 036 034 024 021 004 031 024 " & _		; 1 to 10
			"022 025 029 036 010 013 014 016 016 042 " & _		; 11 to 20
			"151 031 012 008 019 051 066 052 005 006 " & _		; 21 to 30
			"048 014 014 003 009 001 004 007 003 " & _			; 31 to 40
			"003 003 002 014 004 016 015 " & _					; 41 to 46
			"028 016 024 021 " & _								; 47 to 40 new  test
			"028 016 016 013 006 006 004 004 005 003 " & _		; 51 to 60
			"006 004 003 001 013 005 005 003 005 001 " & _		; 61 to 70
			"001 001 022" 										; 71 to 74

	$acShort[001] = "تك"
	$acShort[002] = "خر"
	$acShort[003] = "لا"
	$acShort[004] = "عد"
	$acShort[005] = "تث"
	$acShort[006] = "يش"
	$acShort[007] = "قض"
	$acShort[008] = "را"
	$acShort[009] = "1صم"
	$acShort[010] = "2صم"
	$acShort[011] = "1مل"
	$acShort[012] = "2مل"
	$acShort[013] = "١أخ"
	$acShort[014] = "2أخ"
	$acShort[015] = "عز"
	$acShort[016] = "نح"
	$acShort[017] = "طو"
	$acShort[018] = "يهو"
	$acShort[019] = "أس"
	$acShort[020] = "أي"
	$acShort[021] = "مز"
	$acShort[022] = "أم"
	$acShort[023] = "جا"
	$acShort[024] = "نش"
	$acShort[025] = "حك"
	$acShort[026] = "سى"
	$acShort[027] = "إش"
	$acShort[028] = "إر"
	$acShort[029] = "مرا"
	$acShort[030] = "با"
	$acShort[031] = "حز"
	$acShort[032] = "دان"
	$acShort[033] = "هو"
	$acShort[034] = "يؤ"
	$acShort[035] = "عا"
	$acShort[036] = "عو"
	$acShort[037] = "يون"
	$acShort[038] = "مي"
	$acShort[039] = "نا"
	$acShort[040] = "حب"
	$acShort[041] = "صف"
	$acShort[042] = "حج"
	$acShort[043] = "زك"
	$acShort[044] = "ملا"
	$acShort[045] = "1مك"
	$acShort[046] = "2مك"
	$acShort[047] = "مت"
	$acShort[048] = "مر"
	$acShort[049] = "لو"
	$acShort[050] = "يو"
	$acShort[051] = "أع"
	$acShort[052] = "رو"
	$acShort[053] = "1كو"
	$acShort[054] = "2كو"
	$acShort[055] = "غل"
	$acShort[056] = "أف"
	$acShort[057] = "في"
	$acShort[058] = "كو"
	$acShort[059] = "1تس"
	$acShort[060] = "2تس"
	$acShort[061] = "١تيمو"
	$acShort[062] = "2تيمو"
	$acShort[063] = "تي"
	$acShort[064] = "فل"
	$acShort[065] = "عب"
	$acShort[066] = "يع"
	$acShort[067] = "1بط"
	$acShort[068] = "2بط"
	$acShort[069] = "1يو"
	$acShort[070] = "2يو"
	$acShort[071] = "3يو"
	$acShort[072] = "يه"
	$acShort[073] = "رؤ"

EndFunc
