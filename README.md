### What it is
This is a small GUI that allows you to run any normal AutoHotkey command or block of code by typing a name for the command you want to run. I wrote this script because I was creating more and more hotkeys for various things, but I ran out of keys on my keyboard to assign hotkeys to. It is designed to be as minimal as possible.

![Screenshot](/img/ahk_launcher.png "Screenshot of the GUI")

### How to use it
Run the `Host.ahk` file.

This entire script is build around the `CapsLock` key.
The GUI is activated by `CapsLock`+`Space`.
Normal `CapsLock` functionality is preserved, and can be toggled by `Alt`+`CapsLock`.

When typing something in the GUI, whatever you type is matched up against the commands in `UserCommands.ahk`. These are normal AutoHotkey commands so you can and should write your own. I have supplied some sample commands to show some ideas. But it only becomes truly powerful once you customize it with commands to suit your specific needs.

##### Trying it out yourself
1. Make sure `Host.ahk` is running.
* Open the GUI with `CapsLock`+`Space`.
* Type `face` into the GUI to open facebook.com.
* Open the GUI again. Type `note` into the GUI to open Notepad.
* While in Notepad, type `@` into the GUI. It will write your e-mail address (but you need to go into `UserCommands.ahk` later to specify your own address).
* Try typing `down` into the GUI to open your Downloads folder or `rec` to open the Recycle Bin.
* You can search google by typing `g` followed by a space. A new input field should appear. Type your search query and press enter. Use `l ` if you are 'Feeling Lucky'.
* You can search Youtube with `y `, search Facebook with `f ` or the torrent networks with `t `.
* If you like Reddit, you can visit a specific subreddit by typing `/` into the GUI and then the name of the subreddit you have in mind.
* Try `week` or `date`. (I can never remember the week number so this is useful when on the phone with somebody who insists on comparing calendars going by week number).
* Type `ping` into the GUI to quickly ping www.google.com to see if your internet connection works.

There are some additional example commands included. Try typing simply `?`, and you should see a tooltip with all defined commands and a description of what they do. You may also explore all the sample commands in detail by looking in `UserCommands.ahk`. Now it is time for you to start filling in your own personalized commands.

My own personal `UserCommands.ahk` file is huge, but it is tailored to the things I do everyday and would not be much use for anybody else.

##### How to write your own commands
The variable `Pedersen` contains your text from the input field.

The first thing to do is often to hide the GUI and reset the input field. Do this by calling `gui_destroy()`.

After that, you can run any normal AHK block of code. If for example you have some program you use all the time, you can create a shortcut to that program by

    else if Pedersen = prog
    {
        gui_destroy()
        run "C:\Program Files\Company\That awesome program.exe"
    }

That's it! now you can launch your favourite program by typing `prog` into the input field.

There is a function, `gui_search(url)`, defined in this script that you can call if you want to search some specific website. So for example if you translate from English to Korean using Google Translate all the time, and you want a shortcut for that, then the way to go about it is the following:

1. Go to Google Translate.
* Translate something. For example try translating `Winged turtle`.
* Google Translate tells you that a winged turtle would be 날개 달린 거북이 in Korean. But the URL is the interesting part. The URL is `https://translate.google.com/#en/ko/winged%20turtle`.
* Replace your query with the word `REPLACEME`. Like this: `https://translate.google.com/#en/ko/REPLACEME`.
* Then the code could be:

        else if Pedersen = kor ; Translate English to Korean
        {
            gui_search_title = English to Korean
            gui_search("https://translate.google.com/#en/ko/REPLACEME")
        }

Now we can translate from English to Korean in a heartbeat.

### How it works
Disclaimer: Initially, this was not really written to be shared or used by others, so it is not properly documented and some of the variable names are not self-explanatory and some are in danish. I'm sorry about that. However if you don't go digging too deep, you should not get in trouble. The `UserCommands.ahk` file should be easy to edit.

Here are some quick tips about the script and how it works:

##### Function `gui_destroy()`
Hides and resets the GUI window.

##### Function `gui_search(url)`
`gui_search(url)` was made to search websites like Google and Reddit and so on. It will make a new text input field in the GUI where you can type your search query.
Then it will look at the supplied URL and find 'REPLACEME' and replace it
with your search query.
Example:

    else if Pedersen = y%A_Space% ; Search Youtube
    {
        gui_search_title = Youtube
        gui_search("https://www.youtube.com/results?search_query=REPLACEME")
    }

### What is in store for the future
There has been interest from a number of people in this script, and every once in a while I get a shoutout or a message on reddit from someone who found it and fell in love with it. That warms my heart, so I plan to clean it up completely one day. I also have some other AHK tricks that my life completely depends on, and I am looking forward to sharing those as well. I will wrap it all up in one script one day, and invite you into my world of CapsLock based bliss.

I have this GUI that I have now shared with you. The major things I have built in addition to the GUI are a window manager, a minimalistic password manager (which is actually integrated into the `¯\_(ツ)_/¯` GUI), and some indispensable mappings to the `uiojkl` keys so that you will never have to touch the arrow keys again. I use all of it all the time, and I hope I will be able to share it with you soon. 

### Known bugs
The english to korean Google Translate example does not currently work on the combination of Windows10 + Google Chrome. This is because everything after the `#` symbol in the URL is stripped. This is a bug in Chrome. It has nothing to do with AutoHotkey. The issue was reported here: https://code.google.com/p/chromium/issues/detail?id=514162#c5

### Most recent changes
##### December 30. 2015:
Most significant change is to `url_search(url)` as a consequence of a re-introduced feature: Ability to search multiple URLs. Searching multiple URLs is now possible as so:

    else if Pedersen = m%A_Space% ; Open more than one URL
    {
        gui_search_title = multiple
        gui_search("https://www.google.com/search?&q=REPLACEME")
        gui_search("https://www.bing.com/search?q=REPLACEME")
        gui_search("https://duckduckgo.com/?q=REPLACEME")
    }

Note that the syntax has changed with this update, where it used to be

    gui_search_url := "https://www.youtube.com/results?search_query=REPLACEME"
    gui_search()

The url is now passed as a parameter instead:

    gui_search("https://www.youtube.com/results?search_query=REPLACEME")

Additionally, the tooltip was revived for Windows 10 and improved with the help of Github user schmimae.
