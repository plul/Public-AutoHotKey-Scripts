; Created by Asger Juul Brunshj
#SingleInstance,Force
; Note: Save with encoding UTF-8 with BOM if possible.
; I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.
; Notepad will save UTF-8 files with BOM automatically (even though it does not say so).
; Some editors however save without BOM, and then special characters look messed up in the AHK GUI.

;-------------------------------------------------------------------------------
; AUTO EXECUTE
;-------------------------------------------------------------------------------
gui_autoexecute:
    ; Tomorrow Night Color Definitions:
    cBackground := "c" . "1d1f21"
    cCurrentLine := "c" . "282a2e"
    cSelection := "c" . "373b41"
    cForeground := "c" . "c5c8c6"
    cComment := "c" . "969896"
    cRed := "c" . "cc6666"
    cOrange := "c" . "de935f"
    cYellow := "c" . "f0c674"
    cGreen := "c" . "b5bd68"
    cAqua := "c" . "8abeb7"
    cBlue := "c" . "81a2be"
    cPurple := "c" . "b294bb"

    gui_control_options := "xm w220 " . cForeground . " -E0x200"
    ; -E0x200 removes border around Edit controls

    ; Initialize variable to keep track of the state of the GUI
    gui_state = closed

    ; Initialize search_urls as a variable set to zero
    search_urls := 0
    
    ; Set Gui-Margins for subsequent guis in this
    vMarginX:=6
    vMarginY:=6
    return

;-------------------------------------------------------------------------------
; LAUNCH GUI 
;-------------------------------------------------------------------------------
CapsLock & Space:: ;; Open Gui
gui_spawn:
WinGetActiveTitle,sPreviousActiveWindow
tooltip, % sPreviousActiveWindow
    if gui_state != closed
	{
        ; If the GUI is already open, close it.
		gui_destroy()
		if WinExist(sPreviousActiveWindow)
		{
			WinActivate, sPreviousActiveWindow
		}
		return
	}

gui_state = main

Gui, Margin, 6, 6
Gui, Color, 1d1f21, 282a2e
Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
Gui, Font, s8, Segoe UI
Gui, Add, Text, %gui_control_options% vgui_main_title, ¯\_(ツ)_/¯
;Gui, Add, Text, , ¯\_(ツ)_/¯
Gui, Font, s10, Segoe UI
Gui, Add, Edit, %gui_control_options% vPedersen gFindus
Hotkey, ^Backspace, DeleteWord_Host,On
Gui, Show ,y0, Host 
SetTimer, ForceOnTop_Host,250	
return

;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
;-------------------------------------------------------------------------------
; Automatically triggered on Escape key: 
GuiEscape:
gui_destroy()
Hotkey, ^Backspace, DeleteWord_Host,Off
gui, destroy
SetCapsLockState,Off
search_url:=[]
REPLACEME:=""
tooltip,
tooltip,,,,2
;click
if WinExist(sPreviousActiveWindow)
	WinActivate, sPreviousActiveWindow
return

; The callback function when the text changes in the input field.
Findus:
Gui, Submit, NoHide
#Include %A_ScriptDir%\GUI\UserCommands.ahk
return 


ForceOnTop_Host:
if WinExist("Host")
	WinActivate
else
	SetTimer, ForceOnTop_Host, Off
return
DeleteWord_Host:
SendInput, ^+{Left}{BS}
return
;
; gui_destroy: Destroy the GUI after use.
;
#WinActivateForce
gui_destroy() {
	global gui_state
	global gui_search_title
	Hotkey, ^Backspace, DeleteWord_Host,Off
	Pedersen=
	gui_state = closed
    ; Forget search title variable so the next search does not re-use it
    ; in case the next search does not set its own:
	gui_search_title =
	
    ; Clear the tooltip
	Gosub, gui_tooltip_clear
	
    ; Hide GUI
	Gui, Destroy
	
    ; reset CapsLock state
	SetCapsLockState,Off
    ; Bring focus back to another window found on the desktop
	WinActivate
	tooltip,,,,1
	tooltip,,,,2
	tooltip,,,,3
	tooltip,,,,4
	
}

; gui_change_title: Sets the title of the GUI box.
gui_change_title(message,color = "") {
    ; If parameter color is omitted, the message is assumed to be an error
    ; message, and given the color red.
    If color =
    {
        global cRed
        color := cRed
    }
    GuiControl,, gui_main_title, %message%
    Gui, Font, s11 %color%
    GuiControl, Font, gui_main_title
    Gui, Font, s10 cffffff ; reset
}

;-------------------------------------------------------------------------------
; SEARCH ENGINES
;-------------------------------------------------------------------------------
;
; gui_search_add_elements: Add GUI controls to allow typing of a search query.
;
gui_search_add_elements:
gui_search_add_elements_default:
Gui, Add, Text, %gui_control_options% %cYellow%, %gui_search_title%
Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
GuiControl, Disable, Pedersen
Gui, Show, AutoSize, 
return


gui_search(url:=0,filequery:="0",file:="REPLACEME") {    ;; I think the function just merges and indexes all urls in UserCommands.ahk ? 
	global
	backup_default:=false
     if gui_state != search
     {
		gui_state = search
		Gosub, gui_search_add_elements
     }
     search_urls := search_urls + 1
     search_url%search_urls% := url  ;; what does this do?
}

gui_search_default(url,Defaulturl) {    ;; I thi	 nk the function just merges and indexes all urls in UserCommands.ahk ? 
	global
	backup_default:=true
	DefaultURL_g:=Defaulturl
     if gui_state != search
     {
		gui_state = search
		Gosub, gui_search_add_elements
     }
     search_urls := search_urls + 1
     search_url%search_urls% := url  ;; what does this do?
}


gui_SearchEnter: ;; Function assembles the search string to execute. Since only the search term is replaced, it can just be "run" as a normal command.
Gui, Submit
gui_destroy()
Hotkey, ^Backspace, DeleteWord_Host,Off
tooltip
loop, %search_urls%
{
	;MsgBox, %search_url%%A_Index%
}
query_safe := uriEncode(gui_SearchEdit)
Loop, %search_urls%
{
	StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
	;MsgBox, % search_final_url
	if !query_safe ; nothing has been specified as search query, the string is empty
	{
		if backup_default 
			run, %DefaultURL_g%,,,RunPID
		else
			run, %search_final_url%,,,RunPID
	}
	else 
		run %search_final_url%,,,RunPID
}
    search_urls := 0  ;; reset search_urls
    sleep, 200
    click
	WinActivate, ahk_pid, %RunPID%
    return

;-------------------------------------------------------------------------------
; TOOLTIP
; The tooltip shows all defined commands, along with a description of what
; each command does. It gets the description from the comments in UserCommands.ahk.
; The code was improved and fixed for Windows 10 with the help of schmimae.
;-------------------------------------------------------------------------------
gui_tooltip_clear:
    ToolTip
    return

gui_commandlibrary:
    ; hidden GUI used to pass font options to tooltip:
    CoordMode, Tooltip, Screen ; To make sure the tooltip coordinates is displayed according to the screen and not active window
    Gui, 2:Font,s10, Lucida Console
    Gui, 2:Add, Text, HwndhwndStatic

    tooltiptext =
    maxpadding = 0
    StringCaseSense, Off ; Matching to both if/If in the IfInString command below
    Loop, read, %A_ScriptDir%/GUI/UserCommands.ahk
    {
        ; search for the string If Pedersen =, but search for each word individually because spacing between words might not be consistent. (might be improved with regex)
        If Substr(A_LoopReadLine, 1, 1) != ";" ; Do not display commented commands
        {
            If A_LoopReadLine contains if
            {
                IfInString, A_LoopReadLine, Pedersen
                    IfInString, A_LoopReadLine, =
                    {
                        StringGetPos, setpos, A_LoopReadLine,=
                        StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 ; trim everything that comes before the = sign
                        StringReplace, trimmed, trimmed, `%A_Space`%,{space}, All
                        tooltiptext .= trimmed
                        tooltiptext .= "`n"

                        ; The following is used to correct padding:
                        StringGetPos, commentpos, trimmed,`;
                        if (maxpadding < commentpos)
                            maxpadding := commentpos
                    }
            }
        }
    }
    tooltiptextpadded =
    Loop, Parse, tooltiptext,`n
    {
        line = %A_LoopField%
        StringGetPos, commentpos, line, `;
        spaces_to_insert := maxpadding - commentpos
        Loop, %spaces_to_insert%
        {
            StringReplace, line, line,`;,%A_Space%`;
        }
        tooltiptextpadded .= line
        tooltiptextpadded .= "`n"
}
Sort, tooltiptextpadded
tooltip,% Substr(tooltiptextpadded,Instr(tooltiptextpadded,"`n",,,Ceil((StrSplit(tooltiptextpadded,"`n").length())/2))),A_ScreenWidth,3,3
ToolTip % Substr(tooltiptextpadded,1,Instr(tooltiptextpadded,"`n",,,Ceil((StrSplit(tooltiptextpadded,"`n").length())/2))), 3, 3, 1
return


 ;Clip() - Send and Retrieve Text Using the Clipboard
 ;by berban - updated February 18, 2019
 ;https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156

 ;modified by Gewerd Strauss

fClip(Text="", Reselect="",Restore:=1,DefaultMethod:=1)
{
	;m(DefaultMethod)
	if !DefaultMethod
	{
		BlockInput,On
		if InStr(Text,"&|") ;; check if needle contains cursor-pos. The needle must be &|, without brackets
		{
			move := StrLen(Text) - RegExMatch(Text, "[&|]")
			Text := RegExReplace(Text, "[&|]")
			sleep, 20
			MoveCursor:=true
		}
		Else
		{
			MoveCursor:=false
			move:=1 			;; offset the left-moves for the edgecase that this is not guarded by movecursor
		}
		Static BackUpClip, Stored, LastClip
		If (A_ThisLabel = A_ThisFunc)
		{
			If (Clipboard == LastClip)
				Clipboard := BackUpClip
			BackUpClip := LastClip := Stored := ""
		} 
		Else 
		{
			If !Stored 
			{
				Stored := True
				BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
			} 
			Else
				SetTimer, %A_ThisFunc%, Off
			LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
			If (Text = "") ; No text is pasted, hence we pull it. 
			{
				SendInput, ^c 
				ClipWait, LongCopy ? 0.6 : 0.2, True
			} 
			Else 
			{
				Clipboard := LastClip := Text
				ClipWait, 10
				SendInput, ^v
			;MsgBox, mc:%MoveCursor%
				if MoveCursor
				{
					if WinActive("E-Mail – ") and Winactive("— Mozilla Firefox")
					{
						WinActivate
						sleep, 20
						BlockInput,On
						WinActivate, "E-Mail – "
						if !ReSelect and (ReSelect = False)
							SendInput, % "{Left " move-1 "}"
						else if (Reselect="")
							SendInput, % "{Left " move-1 "}"
					}	
					else
						if !ReSelect and (ReSelect = False)
							SendInput, % "{Left " move-2 "}"
					else if (Reselect="")
					{
						SendInput, % "{Left " move-2 "}"
					}
				}
			}
			SetTimer, %A_ThisFunc%, -700
			Sleep 200 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
			If (Text = "") ; we are pulling, not pasting
			{
				SetTimer, %A_ThisFunc%, Off
				{
					f_unstickKeys()
					if !Restore
					{
						BlockInput, Off
						return LastClip := Clipboard
					}
					LastClip := Clipboard
					ClipWait, LongCopy ? 0.6 : 0.2, True
					BlockInput,Off
					Return LastClip
				}
			}
			Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
			{
				SetTimer, %A_ThisFunc%, Off
				SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
			}
		}
		f_unstickKeys()  
		BlockInput, Off
		Return
		
	}
	else
	{
		if InStr(Text,"&|") ;; check if needle contains cursor-pos. The needle must be &|, without brackets
		{
			move := StrLen(Text) - RegExMatch(Text, "[&|]")
			Text := RegExReplace(Text, "[&|]")
			sleep, 20
			MoveCursor:=true
		}
		Else
		{
			MoveCursor:=false
			move:=1 			;; offset the left-moves for the edgecase that this is not guarded by movecursor
		}
		If (A_ThisLabel = A_ThisFunc) {
			If (Clipboard == LastClip)
				Clipboard := BackUpClip
			BackUpClip := LastClip := Stored := ""
		} Else {
			If !Stored {
				Stored := True
				BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
			} Else
				SetTimer, %A_ThisFunc%, Off
			LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
			If (Text = "") {
				SendInput, ^c
				ClipWait, LongCopy ? 0.6 : 0.2, True
			} Else {
				Clipboard := LastClip := Text
				ClipWait, 10
				SendInput, ^v
			}
			SetTimer, %A_ThisFunc%, -700
			Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
			If (Text = "")
				Return LastClip := Clipboard
			Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
				SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
			if Move and !ReSelect{
				SendInput, % "{Left " move-2 "}"
			}
		}
		Return
		
	}
	fClip:
	f_unstickKeys()
	BlockInput,Off
	Return fClip()
}


f_unstickKeys()
{
	BlockInput, On
	SendInput, {Ctrl Up}
	SendInput, {V Up}
	SendInput, {Shift Up}
	SendInput, {Alt Up}
	BlockInput, Off
}


/* original by berban https://github.com/berban/Clip/blob/master/Clip.ahk
	; Clip() - Send and Retrieve Text Using the Clipboard
; by berban - updated February 18, 2019
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156
	Clip(Text="", Reselect="")
	{
		Static BackUpClip, Stored, LastClip
		If (A_ThisLabel = A_ThisFunc) {
			If (Clipboard == LastClip)
				Clipboard := BackUpClip
			BackUpClip := LastClip := Stored := ""
		} Else {
			If !Stored {
				Stored := True
				BackUpClip := ClipboardAll ; ClipboardAll must be on its own line
			} Else
				SetTimer, %A_ThisFunc%, Off
			LongCopy := A_TickCount, Clipboard := "", LongCopy -= A_TickCount ; LongCopy gauges the amount of time it takes to empty the clipboard which can predict how long the subsequent clipwait will need
			If (Text = "") {
				SendInput, ^c
				ClipWait, LongCopy ? 0.6 : 0.2, True
			} Else {
				Clipboard := LastClip := Text
				ClipWait, 10
				SendInput, ^v
			}
			SetTimer, %A_ThisFunc%, -700
			Sleep 20 ; Short sleep in case Clip() is followed by more keystrokes such as {Enter}
			If (Text = "")
				Return LastClip := Clipboard
			Else If ReSelect and ((ReSelect = True) or (StrLen(Text) < 3000))
				SendInput, % "{Shift Down}{Left " StrLen(StrReplace(Text, "`r")) "}{Shift Up}"
		}
		Return
		Clip:
		Return Clip()
	}
*/

