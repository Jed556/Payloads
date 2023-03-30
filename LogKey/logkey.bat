@echo off
title PLs: LogKey

:: Config variables
set "debug=0"
set "dataURL=raw.githubusercontent.com/Jed556/Payloads/main/LogKey/data.logkey"
set "fileName="
set "idLength=8"

:: Check for arguments
if "%1"=="1" (
    set "debug=1"
)

if NOT [%2]==[] (
    set "idLength=%2"
)

if NOT [%3]==[] (
    set "dataURL=%3"
)

if NOT [%4]==[] (
    set "fileName=%4"
)

if "%fileName%"=="" (
    for %%i in ("%dataURL%") do set "fileName=%%~nxi"
)

:: Art
cls
echo.
echo. [0;34m"|     [1;36m /#######  /##                     [0m                                          [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##__  ##| ## [0;36m  /#######  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##  \ ##| ## [0;36m /##_____/  [0m        [1;37mPayloads[0m by Jed556[0m                        [0;34m|"[0m
echo. [0;34m"|     [1;36m| #######/| ## [0;36m |  ######  [0m        [4mGitHub.com/Jed556/Payloads[0m                [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##____/ | ## [0;36m  \____  ## [0m        [1;32mActive[0m : LogKey[0m                           [0;34m|"[0m
echo. [0;34m"|     [1;36m| ## [0;36m /#################/  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m|__/ [0;36m/_________________/   [0m                                                  [0;34m|"[0m


:: Get data from url
echo.
echo Reading data from server...[1m
curl -Lo %fileName% %dataURL%
setlocal EnableDelayedExpansion EnableExtensions
set "data="
for /f "delims=" %%i in (data.logkey) do (
  set "data=!data!%%i "
)
endlocal & set "data=%data%"
echo [0m

:: Focus on the target window
echo.
echo Focusing to previous window...
powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%%{TAB}');" > nul
timeout /t 2 /nobreak > nul
echo.

:: Loop through the input
echo Typing...
set /a "idEnd=%idLength%-1"
setlocal EnableDelayedExpansion
set "keys="
for %%a in (%data%) do (
    :: Setup variables
    set "token=%%a"
    set "key=!token:~0,%idEnd%!"
    set "keyIn=!key!{ENTER}"
    set "name=!token:~%idLength%!"
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
    echo [1;35m[DEBUG][0m Path: %~dp0
    echo [1;35m[DEBUG][0m Data: %data%
    echo [1;35m[DEBUG][0m Keys: %keys%
)

:: Bye
:End
echo.
echo Done.
del /Q /F %fileName%

echo Exiting...
timeout /t 2 /nobreak > nul
del /Q /F "%~f0" & exit