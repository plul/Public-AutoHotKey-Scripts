; Created by Asger Juul Brunshøj
; Note: Save with encoding UTF-8 with BOM if possible. I had issues with special characters like in ¯\_(ツ)_/¯ that wouldn't work otherwise.

; Write your own AHK commands in this file to be recognized by the GUI. Take inspiration from the samples provided here.



If 1 = 2 ; Does not do anything. It is just here so that everything below will start with 'Else If', just so no syntax errors creep in if the order is switched or something.
{
}



;;; SEARCH GOOGLE ;;;

Else If Pedersen = g%A_Space% ; Search Google
{
    gui_search_title = LMGTFY
    gui_search_url := "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l="
    gui_search()
}
Else If Pedersen = a%A_Space% ; Search Google for AutoHotkey related stuff
{
    gui_search_title = Autohotkey Google Search
    gui_search_url := "https://www.google.com/search?num=50&safe=off&site=&source=hp&q=autohotkey%20REPLACEME&btnG=Search&oq=&gs_l="
    gui_search()
}
Else If Pedersen = l%A_Space% ; Search Google with ImFeelingLucky
{
    gui_search_title = I'm Feeling Lucky
    gui_search_url := "http://www.google.com/search?q=REPLACEME&btnI=Im+Feeling+Lucky"
    gui_search()
}
Else If Pedersen = x%A_Space% ; Search Google as Incognito
; A note on how this works:
;   The variable name "gui_search_url" is poorly chosen.
;   What you actually specify in the variable "gui_search_url" is a command to run. It does not have to be a URL
;   Before the command is run, the word REPLACEME is replaced by your input.
;   It does not have to be a search url, that was just the application I had in mind when I originally wrote it.
;   So what this does is that it runs chrome with the arguments "-incognito" and the google search URL where REPLACEME in the URL has been replaced by your input.
{
    gui_search_title = Google Search as Incognito
    gui_search_url := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME"
    gui_search()
}



;;; SEARCH OTHER THINGS ;;;

Else If Pedersen = f%A_Space% ; Search Facebook
{
    gui_search_title = Search Facebook
    gui_search_url := "https://www.facebook.com/search/results.php?q=REPLACEME"
    gui_search()
}
Else If Pedersen = y%A_Space% ; Search Youtube
{
    gui_search_title = Search Youtube
    gui_search_url := "https://www.youtube.com/results?search_query=REPLACEME"
    gui_search()
}
Else If Pedersen = t%A_Space% ; Search torrent networks
{
    gui_search_title = Sharing is caring
    gui_search_url := "https://kickass.to/usearch/REPLACEME"
    gui_search()
}
Else If Pedersen = / ; Go to subreddit. This is not actually a search, but a quick way to navigate to a specific URL.
{
    gui_search_title := "/r/"
    gui_search_url := "https://www.reddit.com/r/REPLACEME"
    gui_search()
}
Else If Pedersen = kor ; Translate English to Korean
{
    gui_search_title = English to Korean
    gui_search_url := "https://translate.google.com/#en/ko/REPLACEME"
    gui_search()
}




;;; LAUNCH WEBSITES AND PROGRAMS ;;;

Else If Pedersen = face ; facebook.com
{
    gui_destroy()
    run www.facebook.com
}
Else If Pedersen = red ; reddit.com
{
    gui_destroy()
    run www.reddit.com
}
Else If Pedersen = cal ; Google Calendar
{
    gui_destroy()
    run https://www.google.com/calendar
}
Else If Pedersen = note ; Notepad
{
    gui_destroy()
    Run Notepad
}
Else If Pedersen = paint ; MS Paint
{
    gui_destroy()
    run "C:\Windows\system32\mspaint.exe"
}
Else If Pedersen = maps ; Google Maps focused on the Technical University of Denmark, DTU
{
    gui_destroy()
    run "https://www.google.com/maps/@55.7833964`,12.5244754`,12z"
}
Else If Pedersen = inbox ; Open google inbox
{
    gui_destroy()
    run https://inbox.google.com/u/0/
    ; run https://mail.google.com/mail/u/0/#inbox  ; Maybe you prefer the old gmail
}
Else If Pedersen = mes ; Opens Facebook unread messages
{
    gui_destroy()
    run https://www.facebook.com/messages?filter=unread&action=recent-messages
}
Else If Pedersen = url ; Open an URL from the clipboard (naive - will try to run whatever is in the clipboard)
{
    gui_destroy()
    run %ClipBoard%
}



;;; INTERACT WITH THIS AHK SCRIPT ;;;

Else If Pedersen = rel ; Reload this script
{
    gui_destroy() ; removes the GUI even when the reload fails
    Reload
}
Else If Pedersen = dir ; Open the directory for this script
{
    gui_destroy()
    Run, %A_ScriptDir%
}
Else If Pedersen = host ; Edit host script
{
    gui_destroy()
    run, notepad.exe "%A_ScriptFullPath%"
}
Else If Pedersen = user ; Edit GUI user commands
{
    gui_destroy()
    run, notepad.exe "%A_ScriptDir%\GUI\UserCommands.ahk"
}



;;; TYPE RAW TEXT ;;;

Else If Pedersen = @ ; Email address
{
    gui_destroy()
    Send, my_email_address@gmail.com
}
Else If Pedersen = name ; My name
{
    gui_destroy()
    Send, My Full Name
}
Else If Pedersen = phone ; My phone number
{
    gui_destroy()
    SendRaw, +45-12345678
}
Else If Pedersen = int ; LaTeX integral
{
    gui_destroy()
    SendRaw, \int_0^1  \; \mathrm{d}x\,
}
Else If Pedersen = logo ; ¯\_(ツ)_/¯
{
    gui_destroy()
    Send ¯\_(ツ)_/¯
}
Else If Pedersen = clip ; Paste clipboard content
{
    gui_destroy()
    SendRaw, %ClipBoard%
}



;;; FOLDERS ;;;

Else If Pedersen = down ; Downloads
{
    gui_destroy()
    run C:\Users\%A_Username%\Downloads
}
Else If Pedersen = drop ; Dropbox folder
{
    gui_destroy()
    run, C:\Users\%A_Username%\Dropbox\
}
Else If Pedersen = rec ; Recycle Bin
{
    gui_destroy()
    Run ::{645FF040-5081-101B-9F08-00AA002F954E}
}



;;; MISCELLANEOUS ;;;

Else If Pedersen = ping ; Ping Google
{
    gui_destroy()
    Run, cmd /K "ping www.google.com"
}
Else If Pedersen = date ; What is the date?
{
    gui_destroy()
    FormatTime, date,, LongDate
    MsgBox %date%
    date =
}
Else If Pedersen = week ; Which week is it?
{
    gui_destroy()
    FormatTime, ugenummer,, YWeek
    StringTrimLeft, ugenummertrimmed, ugenummer, 4
    MsgBox It is currently week %ugenummertrimmed%
    ugenummer =
    ugenummertrimmed =
}
