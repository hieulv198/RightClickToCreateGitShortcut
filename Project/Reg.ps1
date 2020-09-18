Function Test-IsProgramInstalled ($programName)
{
    $32BitPrograms = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*
    $64BitPrograms = Get-ItemProperty     HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
    $programsWithGitInName = ($32BitPrograms + $64BitPrograms) | Where-Object { $null -ne $_.DisplayName -and $_.Displayname.Contains($programName)}
    $isGitInstalled = $null -ne $programsWithGitInName
    return $isGitInstalled
}
if (!(Test-IsProgramInstalled 'Git'))
{
    echo "Git is not installed"
    exit
}

#DECLARE
$currentPath = $args[0]
$prjName= "CreateGitShortcut"
$installLocation = "$env:ProgramFiles\$prjName"
$iconSourcePath = $currentPath
$iconPath = "$installLocation\git-shortcut.ico"
$excuteFilePath = "$installLocation\CreateGitShortcut.ps1"

$cmd = "powershell -NoExit -NoProfile -command ""&'$excuteFilePath' (get-item .).FullName"" {-Verb RunAs}"

#.Remove Existed HKLM
$keyWtPath = "HKLM:\SOFTWARE\Classes\Directory\background\shell\$prjName"
if (Test-Path -Path $keyWtPath)
{
    Remove-Item -Path $keyWtPath -ErrorAction SilentlyContinue
}

#.Create HKLM (Command)
New-item -Path $keyWtPath -Value 'Create Git-bash shortcut for this forder'
New-item -Path $keyWtPath\command -Value $cmd
New-ItemProperty -Path $keyWtPath -Name Icon -Value $iconPath
New-ItemProperty -Path $keyWtPath -Name Extended

#.Create InstallLocaltion
if( -Not (Test-Path $installLocation))
{
    New-Item -ItemType Directory $installLocation
}

#.Copy Icon
Copy-Item "$currentPath\git-shortcut.ico" -Destination $iconPath  -Force

#.Copy file
Copy-Item "$currentPath\CreateGitShortcut.ps1"  -Destination $excuteFilePath  -Force