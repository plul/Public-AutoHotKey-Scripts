### What it is
This is a small GUI that allows you to assign hotkeys to any normal AHK command you can think of. I was creating more and more hotkeys for various things. Soon I ran out of keys on my keyboard to assign hotkeys to, so I wrote this script. It is designed to be as minimal as possible.

### How to use it
Run the Host.ahk file.

This entire script is build around the CapsLock key.
A small GUI is activated by CapsLock+Space.
Normal CapsLock functionality is preserved, and can be toggled by Alt+CapsLock.

When typing something in the GUI, whatever you type is matched up against the commands in UserCommands.ahk. These are normal AutoHotkey commands so you can and should write your own. I have supplied some sample commands to show some ideas. But it only becomes truly powerful once you customize it with commands to suit your specific needs.

#### Trying it out yourself
* Make sure Host.ahk is running.
* Open the GUI with CapsLock+Space.
* Type `face` into the GUI to open facebook.com.
* Open the GUI again. Type `note` into the GUI to open Notepad.
* While in Notepad, type `@` into the GUI. It will write your e-mail address (but you need to go into UserCommands.ahk later to specify your own address).
* Try typing `down` into the GUI to open your Downloads folder or `rec` to open the recycle bin.
* You can search google by typing `g` followed by a space. A new input field should appear. Type your search query and press enter. Use `l ` if you are 'Feeling Lucky'.
* You can search Youtube with `y `, search Facebook with `f ` or the torrent networks with `t `.
* If you like reddit, you can visit a specific subreddit by typing `/` into the GUI and then the name of the subreddit you have in mind.
* Try `week` or `date`. (I can never remember the week number so this is useful when on the phone with somebody who insists on comparing calendars going by week number).
* Type `ping` into the GUI to quickly ping www.google.com to see if your internet connection works.

Now go explore the rest of the sample commands in UserCommands.ahk, and start filling in your own!
My own personal UserCommands.ahk file is huge, but it is tailored to the things I do everyday and would not be much use for anybody else.

#### How to write your own commands
The variable `Pedersen` contains your text from the input field.

The first thing to do is often to hide the GUI and reset the input field. Do this by calling `gui_destroy()`.

After that, you can run any normal AHK block of code. If for example you have some program you use all the time, you can create a shortcut to that program by

    Else If Pedersen = prog
    {
        gui_destroy()
        run "C:\Program Files\Company\That awesome program.exe"
    }

That's it!

There is a function, `gui_search()`, defined in this script that you can call if you want to search some specific website. So for example if you translate from English to Korean using Google Translate all the time, and you want a shortcut for that, then the way to go about it is the following:

1. Go to Google Translate.
* Translate something. For example try translating `Winged turtle`.
* Google Translate tells you that a winged turtle would be 날개 달린 거북이 in Korean. But the URL is the interesting part. The URL is `https://translate.google.com/#en/ko/winged%20turtle`.
* Replace your query with the word `REPLACEME`. Like this: `https://translate.google.com/#en/ko/REPLACEME`.
* Then the code could be:

        Else If Pedersen = kor ; Translate English to Korean
        {
            gui_search_title = English to Korean
            gui_search_url1 := "https://translate.google.com/#en/ko/REPLACEME"
            gui_search()
        }

Now we can translate from English to Korean in a heart beat.

### How it works
Disclaimer: This was never really written to be shared or used by others
so it is not properly documented and some of the variable names are not self-explicable and some are in danish. I'm sorry about that. However if you don't go digging too deep, you shouldn't get in trouble. The UserCommands.ahk file should be easy to edit.
There has been interest from a number of people in this script, so maybe I will clean it up completely one day.

Here are some quick tips about the script and how it works:

#### Function `gui_destroy()`
Hides and resets the GUI window.

#### Function `gui_search()`
gui_search() was made to search websites like Google and Reddit and so on. It will make a new text input field in the GUI where you can type your search query.
Then it will look at the supplied URL and find 'REPLACEME' and replace it
with your search query.
Example:

    Else If Pedersen = y%A_Space% ; Search Youtube
    {
        gui_search_title = Youtube
        gui_search_url1 := "https://www.youtube.com/results?search_query=REPLACEME"
        gui_search()
    }

### What happened to the tooltip?
There used to be a tooltip to display all defined commands in `UserCommands.ahk`. It worked on Windows 7 but it disappears immediately on Windows 10. It was nice, but I didn't attempt to fix it yet. I didn't use it much anyway. I removed the hotkey but left the code in GUI.ahk, in case it is an easy fix.

If you really want to give it a try, just add the following to your UserCommands.ahk file:

    Else If Pedersen = ? ; Tooltip with list of commands
    {
        GuiControl,, Pedersen, ; Clear the input box
        gui_commandlibrary()
    }

### Known bugs
The english to korean Google Translate example does not currently work on the combination of Windows10 + Google Chrome. This is because everything after the `#` symbol in the URL is stripped. This is a bug. It has nothing to do with AutoHotkey. The issue was reported here: https://code.google.com/p/chromium/issues/detail?id=514162#c5