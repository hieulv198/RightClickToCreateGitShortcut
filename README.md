## Description

Create a lazy shortcut file to open git-bash on folder, instead of Right-Click and open git-bash.
This shortcut file can send to desktop to reduce the action to be performed when opening git.

## How to Install
Run as admin file Reg.bat

### How to Use
1. Open folder 
2. Shift + Right-click to open hidden menu.
3. Chose **"Create git-bash shortcut for this folder"**
4. A folder "Git-Shortcut" will be created.


### Problems solving (for my bookmark)

- How to check is program install with PowerShell => Check in HKLM:...\Uninstall
>Function Test-IsProgramInstalled {...}
- Get current path in powershell => tooooo hard to find a right solution >.<   
>(get-item .).FullName
- Register a command string to run Powershell excute a file with run as admin, pass a string with spaces as parameter
>$cmd = "powershell -NoExit -NoProfile -command ""&'$excuteFilePath' (get-item .).FullName"" {-Verb RunAs}"
-Create Shortcut file with PowerShell.
