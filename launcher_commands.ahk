; open websites based on the provided search query and title
openUrl(searchQuery, title) {
    gui_search(searchQuery, title)
}

; open applications or urls
open(param) {
    gui_destroy()
    Run %param%
}

; Search Engines
Switch var {
    case "g" . A_Space:
        ; Search Google
        openUrl("http://www.google.com/search?q=REPLACEME", "Google")
    case "xi" . A_Space:
        ; Search Brave as Incognito
        openUrl("brave.exe -incognito https://www.google.com/search?safe=off&q=REPLACEME", "Brave Incognito")
    case "xg" . A_Space:
        ; Search Brave as Guest
        openUrl("brave.exe -guest https://www.google.com/search?safe=off&q=REPLACEME", "Brave Guest")
    case "y" . A_Space:
        ; Search YouTube
        openUrl("https://www.youtube.com/results?search_query=REPLACEME", "YouTube")
    case "m" . A_Space:
        ; Open more than one URL
        openUrl("https://www.google.com/search?&q=REPLACEME", "Many")
        openUrl("https://www.bing.com/search?q=REPLACEME", "Many")
        openUrl("https://duckduckgo.com/?q=REPLACEME", "Many")
}

; Launch applications or open URLs
Switch var {
    case "cal":
        open("https://www.google.com/calendar")
    case "chro":
        open("https://chrome.google.com/webstore/category/extensions")
    case "vpn":
        open("C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe")
    case "uni":
        open("appwiz.cpl")
    case "map":
        open("https://www.google.com/maps")
    case "pho":
        open("https://photos.google.com")
}

; Applications
Switch var {
    case "pain":
        open("mspaint")
    case "rege":
        ; Open Registry Editor
        open("C:\Windows\regedit.exe")
    case "gpe":
        ; Open Group Policy Editor
        open("gpedit.msc")
    case "task":
        ; Open Task Scheduler
        open("taskschd.msc")
    case "msco":
        ; Open System Configuration (msconfig)
        open("msconfig")
    case "upd":
        ; Open Windows Update
        open("ms-settings:windowsupdate")
    case "def":
        open("windowsdefender:")
    case "god":
        ; Open God Mode
        open("GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}")
    case "wapp":
        ; Open All Apps
        open("shell:appsfolder")
    case "qb":
        open("C:\Users\divyansh\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Scoop Apps\qBittorrent.lnk")
    case "winv":
        open("winver")
    case "part":
        ; Open Disk Management - Partitions Tool
        open("C:\Windows\system32\diskmgmt.msc")
    case "dm":
        open("C:\Users\Default\AppData\Local\Microsoft\Windows\WinX\Group3\05 - Device Manager.lnk")
}

; Folders
Switch var {
    case "home":
        open("C:\Users\" . A_Username)
    case "local":
        open("C:\Users\" . A_Username . "\AppData\Local")
    case "roam":
        open("C:\Users\" . A_Username . "\AppData\Roaming")
    case "star":
        open("C:\Users\" . A_Username . "\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")
    case "t1":
        open("C:\Windows\Temp")
    case "t2":
        open("C:\Users\" . A_Username . "\AppData\Local\Temp")
    case "rec":
        ; Recycle Bin
        open("::{645FF040-5081-101B-9F08-00AA002F954E}")
}
