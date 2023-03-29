@echo off
title Payloads: Logger

:: Config variables
set "debug=0"


:: Get data from file
curl -Lo data.logkey https://raw.githubusercontent.com/Jed556/Payloads/main/Logkey/data.logkey
setlocal EnableDelayedExpansion EnableExtensions
set "data="
for /f "delims=" %%i in (data.logkey) do (
  set "data=!data!%%i "
)
endlocal & set "data=%data%"

:: Focus on the target window
echo.
echo Focusing to previous window...
powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');" > nul
timeout /t 2 /nobreak > nul
echo.

:: Loop through the input
echo Typing...
setlocal EnableDelayedExpansion
set "keys="
for %%a in (%data%) do (
    :: Setup variables
    set "token=%%a"
    set "key=!token:~0,7!"
    set "keyIn=!key!{ENTER}"
    set "name=!token:~8!"
    set name=!name:_= !
    set "keys=!keys!!keyIn!"

    :: Enter key
    powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('!keyIn!');"
    echo [1;32m!key![0m : !name!
)
endlocal & set "keys=%keys%"

:: Check variables
if "%debug%"=="1" (
    echo.
    echo [DEBUG] Data: %data%
    echo [DEBUG] Keys: %keys%
)

:: Bye
:End
echo.
echo Done.
echo Exiting...
timeout /t 30 /nobreak > nul

del /Q /F "data.logkey"
del /Q /F "%~f0" & exit