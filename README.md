## Requirements

1. **AutoHotKey Installation:**
   Ensure that AutoHotKey version 1.1 is installed on your system.
   [AutoHotKey v1.1 Download](https://www.autohotkey.com/download/ahk-install.exe)


2. **Operating System:** The scripts are designed to work on Windows operating systems.


## Usage

1. Ensure you have both the `launcher_gui.ahk`, `launcher_commands.ahk` and `run.ahk` file in the same directory.
2. Run the `run.ahk` (it will be running in the background)
3. Use the hotkey **Ctrl + Space** to access the launcher. 
4. Refer to the updated `launcher_gui.ahk` file for clear and comprehensible custom user command implementations.



## Code Changes Overview

1. **Structure Enhancement:** Streamlined code into two files: one for the launcher, and another for custom commands, improving organization.

2. **Simplified UserCommands:** Enhanced readability by refactoring switch cases and incorporating necessary functions for clarity.

3. **Tooltip Functions Removal:** Removed unnecessary Tooltip functions in `GUI.ahk` for a cleaner and more efficient codebase.

4. **GUI Refinement:**
     - Removed emojis and images for a minimalist design.
     - Eliminated unused colors, ensuring a coherent color scheme.
     - Fixed margin, font size, and colors for a visually consistent appearance.


## What `launcher_commands.ahk` Contains Now:

The script now offers three key functionalities:

1. **Search Engine Querying:** Easily query any search engine. Input your search term, and let the script handle the rest.

2. **URL Handling:** Effortlessly open URLs. Simply provide the link, and watch it come to life.

3. **Folder Access:** Navigate through your operating system's folders seamlessly. Your command center for swift and efficient folder access.
