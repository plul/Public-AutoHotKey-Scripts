#NoEnv
#SingleInstance force
#MaxHotkeysPerInterval 9999
;-------------------------------------------------------------------------------
; AUTO EXECUTE
gui_autoexecute:
    ; Initialize color variables for GUI
    cForeground := "c" . "FFFFFF"
    cBlue := "c" . "00BFFF"

    ; Set options for GUI control
    gui_control_options := "xm w220 " . cForeground . " -E0x200"
    ; -E0x200 removes border around Edit controls

    ; Initialize GUI state and other variables
    gui_state = closed
    search_urls := 0
    return



;-------------------------------------------------------------------------------
; LAUNCH GUI
^Space::
gui_spawn:
    ; Check if GUI is already open and close it if so
    if gui_state != closed
    {
        gui_destroy()
        return
    }

    gui_state = main

    ; Set GUI properties
    Gui, Margin, 16, 16
    Gui, Color, 000000, 000000
    Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption
    Gui, Font, s22, Arial

    ; Add an Edit control to the GUI with specified options, variable, and associated label
    Gui, Add, Edit, %gui_control_options% vvar gFindus

    ; Show the GUI with the specified title
    Gui, Show, , myGUI
    return



;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
GuiEscape:
    gui_destroy()
    return

; Callback function when the text changes in the input field.
Findus:
    Gui, Submit, NoHide
    #Include %A_ScriptDir%\launcher_commands.ahk
    return

#WinActivateForce
gui_destroy() {
    global gui_state
    global gui_search_title

    gui_state = closed
    ; Forget search title variable so the next search does not re-use it
    ; in case the next search does not set its own:
    gui_search_title =
    
    ; Destroy the GUI
    Gui, Destroy

    ; Bring focus back to another window found on the desktop
    WinActivate
}



;-------------------------------------------------------------------------------
;SEARCH ENGINES
uriEncode(str) {
    f = %A_FormatInteger%
    SetFormat, Integer, Hex
    If RegExMatch(str, "^\w+:/{0,2}", pr)
        StringTrimLeft, str, str, StrLen(pr)
    StringReplace, str, str, `%, `%25, All
    Loop
        If RegExMatch(str, "i)[^\w\.~%/:]", char)
           StringReplace, str, str, %char%, % "%" . SubStr(Asc(char),3), All
        Else Break
    SetFormat, Integer, %f%
    Return, pr . str
}

gui_search_add_elements:
    Gui, Add, Text, %gui_control_options% %cBlue%, %gui_search_title%
    Gui, Add, Edit, %gui_control_options% %cBlue% vgui_SearchEdit -WantReturn
    Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter
    GuiControl, Disable, var
    Gui, Show, AutoSize
    return

gui_search(url, title) {
    global
    ; Check if GUI state is not in search mode and add elements if necessary
    if gui_state != search
    {
        gui_state = search
        gui_search_title := title  ; Set the search title
        Gosub, gui_search_add_elements
    }
    search_urls := search_urls + 1
    search_url%search_urls% := url
}


gui_SearchEnter:
    ; Submit the search and run the specified URL with the query
    Gui, Submit
    gui_destroy()
    query_safe := uriEncode(gui_SearchEdit)
    Loop, %search_urls%
    {
        StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
        run %search_final_url%
    }
    search_urls := 0
    return
