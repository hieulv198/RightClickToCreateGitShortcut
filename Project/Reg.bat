@echo off
cd %~dp0
SET ps1Path=%CD%\Reg.ps1
SET currentDir=%CD%

powershell -NoProfile -ExecutionPolicy Unrestricted -File "%ps1Path%"  "%currentDir%"
echo quit PowerShell
pause > nul