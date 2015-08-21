; Created by Asger Juul Brunshøj

;-------------------------------------------------------
; AUTO EXECUTE
;-------------------------------------------------------
gui_autoexecute() {
    global

    #WinActivateForce

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
}

;-------------------------------------------------------
; LAUNCH GUI
;-------------------------------------------------------
CapsLock & Space::
IfWinNotExist, myGUI
{
    gui_spawn()
}
Return

gui_spawn() {
    global
    Gui, Margin, 16, 16
    Gui, Color, 1d1f21, 282a2e
    Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
    Gui, Font, s11, Segoe UI
    Gui, Add, Text, %gui_control_options% vgui_main_title, ¯\_(ツ)_/¯
    Gui, Font, s10, Segoe UI
    Gui, Add, Edit, %gui_control_options% vPedersen gFindus
    Gui, Show,, myGUI
}

;-------------------------------------------------------
; GUI FUNCTIONS
;-------------------------------------------------------
; Automatically triggered on Escape key:
GuiEscape:
    gui_destroy()
Return

; The callback function when the text changes in the input field.
Findus:
    Gui, Submit, NoHide
    #Include %A_ScriptDir%\GUI\UserCommands.ahk
Return

gui_destroy() {
    gui_tooltip_clear()
    gui_search_reset()
    Gui, Destroy
    WinActivate
    Return
}

gui_change_title(message,color = "") {
    ; If parameter color is omitted, the message is assumed to be an error message.
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

;-------------------------------------------------------
; SEARCH ENGINES
;-------------------------------------------------------

gui_search() {
    global
    Gui, Add, Text, %gui_control_options% %cYellow%, %gui_search_title%
    Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
    Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
    GuiControl, Disable, Pedersen
    Gui, Show, AutoSize
    Return
}

gui_SearchEnter:
    Gui, Submit
    query_safe := uriEncode(gui_SearchEdit)
    StringReplace, gui_search_new_url, gui_search_url, REPLACEME, %query_safe%
    run %gui_search_new_url%
    gui_destroy()
Return

gui_search_reset() {
    global
    gui_search_title =
    gui_search_url =
    gui_tooltip_clear()
    Return
}

;-------------------------------------------------------
; TOOLTIP
;
; Unfortunately this stopped working for me in Windows 10.
; It worked in Windows 7. The tooltip appears but then
; goes away immediately.
; I didn't attempt to fix it, and I will leave the code
; here for now in case it is an easy fix.
;-------------------------------------------------------
gui_tooltip_clear() {
    ToolTip
    Return
}

gui_commandlibrary() {
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
        IfInString, A_LoopReadLine, If
        {
            IfInString, A_LoopReadLine, Pedersen
            {
                IfInString, A_LoopReadLine, =
                {
                    StringGetPos, setpos, A_LoopReadLine,=
                    StringTrimLeft, trimmed, A_LoopReadLine, setpos+1 ; trim everything that comes before the = sign
                    StringReplace, trimmed, trimmed, `%A_Space`%,{space}, All
                    tooltiptext .= trimmed
                    tooltiptext .= "`n"

                    ; The following is used to correct padding:
                    StringGetPos, commentpos, trimmed,`;
                    If (maxpadding < commentpos)
                    {
                        maxpadding := commentpos
                    }
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

    ; The following allows the tooltip to display in a monospace font (uses GUI3 defined above)
    SendMessage, 0x31,,,, ahk_id %hwndStatic%
    font := ErrorLevel
    ToolTip %tooltiptextpadded%, 3, 3, 1
    SendMessage, 0x30, font, 1,, ahk_class tooltips_class32 ahk_exe autohotkey.exe

    Return
}
