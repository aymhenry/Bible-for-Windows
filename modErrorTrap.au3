#Include-Once

;## Create Global Com Error Object Variable
    Assign("COM ERROR OBJECT",  0, 2)
    Assign("COM ERROR VALUE",   0, 2)
    Assign("COM ERROR LAST",    0, 2)

;---------------------------------------------------------------------------------------------------------------------------
;## Instantiates the Error Handler
    Func _OnError($Enabled = True)
        Local $ComErrObj = Eval("COM ERROR OBJECT")

        If $Enabled And IsObj($ComErrObj) = False Then
            $ComErrObj = ObjEvent("AutoIt.Error","__COM_ERROR_FUNCTION")
        Else
            $ComErrObj = 0
        EndIf

        Assign("COM ERROR OBJECT", $ComErrObj, 2)
    EndFunc
;---------------------------------------------------------------------------------------------------------------------------
;## Replacement for @error and disabled Error Handler
    Func _Error($Value = False)
        Local $ComErrVal = Eval("COM ERROR VALUE")

        If $Value = False Then
            $Value = $ComErrVal
            $ComErrVal = 0
            _OnError(False)
        Else
            $ComErrVal = SetError($Value, 0, $Value)
			_OnError(True)
        EndIf

        Assign("COM ERROR VALUE", $ComErrVal, 2)

        Return SetError($Value, 0, $Value)
    EndFunc
;---------------------------------------------------------------------------------------------------------------------------
;## Returns an array with error details
;##   - OR -
;## Return value of supplied paramater
    Func _LastComError($Item = Default)
        Local $ComErrLst = Eval("COM ERROR LAST")
        Local $RC = 0

        If $Item = Default Then Return $ComErrLst

        $RC = _ArraySearch($ComErrLst, $Item)
        If @error Then Return SetError(1, 0, -1)

        Return $ComErrLst[$RC][1]
    EndFunc
;---------------------------------------------------------------------------------------------------------------------------
;## Private Function that is fired upon Com Error
    Func __COM_ERROR_FUNCTION()
        Local $ComErrObj = Eval("COM ERROR OBJECT")
        Local $ErrNumber = Hex($ComErrObj.Number, 8)
        Local $ComErrLst[8][2] = [ _
            ["Description",         StringStripWS($ComErrObj.Description, 3)    ], _
            ["WinDescription",   StringStripWS($ComErrObj.WinDescription, 3)  ], _
            ["Number",     $ErrNumber                           ], _
            ["LastDllError",       StringStripWS($ComErrObj.LastDllError, 3)  ], _
            ["Scriptline",    StringStripWS($ComErrObj.Scriptline, 3)    ], _
            ["Source",     StringStripWS($ComErrObj.Source, 3)      ], _
            ["HelpFile",          StringStripWS($ComErrObj.HelpFile, 3)    ], _
            ["HelpContext",         StringStripWS($ComErrObj.HelpContext, 3)    ] _
        ]

			MsgBox (16 +0x40000 , $gconProgName, _
					"modErrorTrap" & _
					@cr & StringStripWS($ComErrObj.Description, 3) & _
					@cr & "Number " &  $ErrNumber & _
					@cr & "Line No." & StringStripWS($ComErrObj.Scriptline, 3) & _
					@cr & "Source " & StringStripWS($ComErrObj.Source, 3) _
					 )

			ConsoleWrite (	StringStripWS($ComErrObj.Description, 3) & _
				@cr & "Number " &  $ErrNumber & _
				@cr & "Line No." & StringStripWS($ComErrObj.Scriptline, 3) & _
				@cr & "Source " & StringStripWS($ComErrObj.Source, 3) _
				 )


        Assign("COM ERROR LAST", $ComErrLst, 2)
        _Error($ErrNumber)

        Return SetError($ErrNumber, 0, -1)
    Endfunc
;---------------------------------------------------------------------------------------------------------------------------
