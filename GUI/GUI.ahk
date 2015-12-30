; Created by Asger Juul Brunshøj

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

    ; Initialize search_urls as a variable set to zero
    search_urls := 0
    return

;-------------------------------------------------------------------------------
; LAUNCH GUI
;-------------------------------------------------------------------------------
CapsLock & Space::
gui_spawn:
    IfWinExist, myGUI
        return
    global gui_control_options
    global gui_state
    gui_state = main

    Gui, Margin, 16, 16
    Gui, Color, 1d1f21, 282a2e
    Gui, +AlwaysOnTop -SysMenu +ToolWindow -caption +Border
    Gui, Font, s11, Segoe UI
    Gui, Add, Text, %gui_control_options% vgui_main_title, ¯\_(ツ)_/¯
    Gui, Font, s10, Segoe UI
    Gui, Add, Edit, %gui_control_options% vPedersen gFindus
    Gui, Show,, myGUI
    return

;-------------------------------------------------------------------------------
; GUI FUNCTIONS AND SUBROUTINES
;-------------------------------------------------------------------------------
; Automatically triggered on Escape key:
GuiEscape:
    gui_destroy()
    return

; The callback function when the text changes in the input field.
Findus:
    Gui, Submit, NoHide
    #Include %A_ScriptDir%\GUI\UserCommands.ahk
    return

;
; gui_destroy: Destroy the GUI after use.
;
#WinActivateForce
gui_destroy() {
    global gui_state
    global gui_search_title

    gui_state = closed
    ; Forget search title variable so the next search does not re-use it
    ; in case the next search does not set its own:
    gui_search_title =

    Gui, Destroy
    ; Bring focus back to another window found on the desktop
    WinActivate
}

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
    Gui, Add, Text, %gui_control_options% %cYellow%, %gui_search_title%
    Gui, Add, Edit, %gui_control_options% %cYellow% vgui_SearchEdit -WantReturn
    Gui, Add, Button, x-10 y-10 w1 h1 +default ggui_SearchEnter ; hidden button
    GuiControl, Disable, Pedersen
    Gui, Show, AutoSize
    return

gui_search(url) {
    global
    if gui_state != search
    {
        gui_state = search
        ; if gui_state is "main", then we are coming from the main window and
        ; GUI elements for the search field have not yet been added.
        Gosub, gui_search_add_elements
    }

    ; Assign the url to a variable.
    ; The variables will have names search_url1, search_url2, ...

    search_urls := search_urls + 1
    search_url%search_urls% := url
}

gui_SearchEnter:
    Gui, Submit
    query_safe := uriEncode(gui_SearchEdit)
    Loop, %search_urls%
    {
        StringReplace, search_final_url, search_url%A_Index%, REPLACEME, %query_safe%
        run %search_final_url%
    }
    search_urls := 0
    gui_destroy()
    return
