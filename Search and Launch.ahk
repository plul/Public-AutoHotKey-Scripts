;;; This is a small window made for quickly searching websites like google or youtube without opening the browser.
;;; It's also really useful for quickly running programs and websites or typing things like your email.

;;; USAGE:
;;; The current hotkey for bringing up the window is the windows and G key simultaneously. That is, WIN+G


#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#MaxHotKeysPerInterval 200

;-------------------------------------------------------
; START GUI PREAMPLE - SPAWN WINDOW INSTANCES
;-------------------------------------------------------

Gui, +AlwaysOnTop -SysMenu +Owner
Gui, Add, Edit, vPedersen gFindus

Gui, 2:+AlwaysOnTop -SysMenu +Owner
Gui, 2:Add, Edit, -WantReturn vSearchEdit
; add a hidden button that captures the Enter key:
Gui, 2:Add, Button, x-10 y-10 w1 h1 +default gSearchEditEnter
;-------------------------------------------------------
; END GUI PREAMPLE
;-------------------------------------------------------

; The hotkey that brings up the GUI:
#g::
Gui, 1:Show,, :)
return

; action of the escape key:
GuiEscape:
GuiControl,, Pedersen, ;clear the input box
Gui, Cancel
return

resetGUI:
GuiControl,, Pedersen, ;clear the input box
Gui, Cancel ;hide the window
return

; Findus tries to match whatever is in the input box with your defined commands:
Findus:
Gui, 1:Submit, NoHide

;;; SEEK INSPIRATION BELOW AND ADD YOUR OWN COMMANDS WITH A NEW IF STATEMENT ;;;
	; Search google by typing g and a space
	if Pedersen = g%A_Space%
	{
	  Gosub,resetGUI
	  Gui, 2:Show,, LMGTFY
	  oldURL = https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=
	}

	; Search for torrents by typing t and a space
	if Pedersen = t%A_Space%
	{
	  Gosub,resetGUI
	  Gui, 2:Show,, Sharing is caring
	  oldURL = https://kickass.to/usearch/REPLACEME
	  oldURL2= http://torrentz.eu/search?f=REPLACEME
	  urls = 2;
	}

	; Search facebook by typing f and a space
	if Pedersen = f%A_Space%
	{
	  Gosub,resetGUI
	  Gui, 2:Show,, Stalking who?
	  oldURL = https://www.facebook.com/search/results.php?q=REPLACEME
	}

	; Search youtube by typing y and a space
	if Pedersen = y%A_Space%
	{
	  Gosub,resetGUI
	  Gui, 2:Show,, Youtube
	  oldURL = https://www.youtube.com/results?search_query=REPLACEME
	}

	; Search reddit by typing r and a space
	if Pedersen = r%A_Space%
	{
	  Gosub,resetGUI
	  Gui, 2:Show,, Search Reddit
	  oldURL = http://www.reddit.com/search?q=REPLACEME
	}

	; launch google calendar
	if Pedersen = cal
	{
	  Gosub,resetGUI
	  run https://www.google.com/calendar
	}

	; launch reddit
	if Pedersen = red
	{
	  Gosub,resetGUI
	  run www.reddit.com
	}

	; type some sample latex code:
	if Pedersen = int
	{
	  Gosub,resetGUI
	  SendRaw, \int_0^1  \; \mathrm{d}x\,
	}

	; open notepad
	if Pedersen = note
	{
	  Gosub,resetGUI
	  Run Notepad
	}

	; type your email very fast
	if Pedersen = @
	{
	  Gosub,resetGUI
	  Send, myemail@gmail.com
	}

	; this reloads this script. Useful after changing something in the script.
	if Pedersen = reload
	{
	  Reload
	  Sleep 200
	  MsgBox, Something went wrong
	}

	if Pedersen = date
	{
	  Gosub,resetGUI
	  FormatTime, date,, LongDate
	  MsgBox %date%
	  date =
	}

	if Pedersen = week
	{
	  Gosub,resetGUI
	  FormatTime, ugenummer,, YWeek
	  StringTrimLeft, ugenummertrimmed, ugenummer, 4
	  MsgBox It is currently week %ugenummertrimmed%
	  ugenummer =
	  ugenummertrimmed =
	}

return ; This closes Findus:

;-------------------------------------------------------
; SEARCH GUI
;-------------------------------------------------------
2GuiEscape:
GuiControl,, SearchEdit, ;clear the input box
Gui, Cancel
return

SearchEditEnter:
Gui, Submit
GuiControl,, SearchEdit, ;clear the input box
StringReplace, newURL, oldURL, REPLACEME, %SearchEdit%
run %newURL%
if (urls > 1) {
	StringReplace, newURL, oldURL2, REPLACEME, %SearchEdit%
	run %newURL%
}
urls = 1 ;set default back to 1
return
;-------------------------------------------------------
; END GUI
;-------------------------------------------------------