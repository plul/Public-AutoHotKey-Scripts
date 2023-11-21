## Requirements

1. **AutoHotKey Installation:**
   - Ensure that AutoHotKey version 1.1 is installed on your system. You can download it from the official website:
   [AutoHotKey v1.1 Download](https://www.autohotkey.com/download/ahk-install.exe)

   - For a more streamlined installation process, consider using Scoop, a command-line installer for Windows:

   ```cmd
   scoop install autohotkey1.1
   ```

   Using Scoop allows for easy management of software packages, including AutoHotKey. If you haven't installed Scoop yet, you can find it at [https://scoop.sh/](https://scoop.sh/).

2. **Script Files:**
   - Ensure you have the necessary script files, including `launcher.ahk` and `launcher_commands.ahk`, in the same directory.

3. **Operating System:**
   - The scripts are designed to work on Windows operating systems.


## Changes Made to the Code

1. **Code Structure Enhancement:**
   - Streamlined the code into two distinct files: one responsible for managing the launcher itself, and the other for handling custom user commands. This separation improves code organization and readability.

2. **Simplified UserCommands.ahk:**
   - Significantly enhanced the readability of the `UserCommands.ahk` file by refactoring switch cases and incorporating necessary functions. The updated structure makes it easier to understand and maintain.

3. **Tooltip Functions Removal:**
   - Eliminated unnecessary Tooltip functions in `GUI.ahk` to enhance simplicity. This streamlining contributes to a cleaner and more efficient codebase.

4. **GUI Refinement in Launcher:**
   - Cleaned up the launcher's graphical user interface (GUI):
     - Removed emojis and images for a more minimalist design.
     - Eliminated unused colors, ensuring a more coherent color scheme.
     - Fixed the margin, font size, and colors to create a visually consistent and polished appearance.


## What `launcher_commands.ahk` Contains Now:

The script conains three key functionalities:

1. **Search Engine Querying:**
   - You can seamlessly query any search engine of your choice. Just input your search term, and let it do the work.

2. **URL Handling:**
   - Ready to open URLs with ease. Just provide the link, and watch it happen.

3. **Folder Access:**
   - Navigate through your operating system's folders effortlessly. It's your command center for quick and efficient folder access.


## How to Use the Updated Code

1. Ensure you have both the `launcher_gui.ahk` and the `launcher_commands.ahk` file in the same directory.
2. Run the `launcher_commands.ahk` (it will be present in the background)
3. Use the hotkey **Ctrl + Space** to access the launcher. 
4. Refer to the updated `launcher_gui.ahk` file for clear and comprehensible custom user command implementations.

Feel free to tweak the code to match your vibe and specific needs. 🚀✨