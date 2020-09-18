$currentDir = $args[0]
$currentDirName =  Split-Path ($currentDir) -Leaf
$shortcutFolderPath = "$currentDir\Git-Shortcut"
$batchFilePath = "$shortcutFolderPath\git-$currentDirName.bat"
$shortcutFilePath = "$shortcutFolderPath\git-$currentDirName.lnk"
$gitIconLocation = "%ProgramFiles%\Git\git-bash.exe"

echo $gitIconLocation

#Recreate Folder
if (Test-Path $shortcutFolderPath)
{
    Remove-Item $shortcutFolderPath
}
New-Item -ItemType Directory -Path $shortcutFolderPath

#Create File Bash


#Create batfile
$batContent
@"
@echo off
cd %~dp0
start "" "%SYSTEMDRIVE%\Program Files\Git\bin\sh.exe" --login
"@ | Out-File -FilePath $batchFilePath -Encoding utf8


#Create Shortcut
# Create a Shortcut with Windows PowerShell
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($shortcutFilePath)
$Shortcut.TargetPath = $batchFilePath
$Shortcut.IconLocation = "$gitIconLocation,[0]"
$Shortcut.Save()