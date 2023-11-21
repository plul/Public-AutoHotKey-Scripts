; Disable reliance on the user's environment
#NoEnv

; Ensure only one instance of the script is allowed to run
#SingleInstance force

; Set the maximum number of hotkeys that can be triggered in a specified time interval
#MaxHotkeysPerInterval 9999

; Set the input mode to "Input," which is generally preferred for sending simulated keystrokes
SendMode Input

; Set the working directory to the directory where the script resides
SetWorkingDir %A_ScriptDir%


; Call the subroutine for initializing the GUI
Gosub, gui_autoexecute
return

; Include the GUI configuration from the external file, present in the same folder as run.ahk
#include %A_ScriptDir%\launcher_gui.ahk
