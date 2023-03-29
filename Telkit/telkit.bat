@echo off
title PLs: TelKit

:: Config variables
set "debug=0"
set "tempFolder=%temp%"
set "tempFile=TelnetStatus"

:: Start minimized
if NOT DEFINED IS_MINIMIZED (set IS_MINIMIZED=1 & start "" /min "%~f0" %* && exit)

:: Art
cls
echo.
echo. [0;34m"|     [1;36m /#######  /##                     [0m                                          [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##__  ##| ## [0;36m  /#######  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##  \ ##| ## [0;36m /##_____/  [0m        [1;37mPayloads[0m by Jed556[0m                        [0;34m|"[0m
echo. [0;34m"|     [1;36m| #######/| ## [0;36m |  ######  [0m        [4mGitHub.com/Jed556/Payloads[0m                [0;34m|"[0m
echo. [0;34m"|     [1;36m| ##____/ | ## [0;36m  \____  ## [0m        [1;32mActive[0m : TelKit[0m                           [0;34m|"[0m
echo. [0;34m"|     [1;36m| ## [0;36m /#################/  [0m                                                  [0;34m|"[0m
echo. [0;34m"|     [1;36m|__/ [0;36m/_________________/   [0m                                                  [0;34m|"[0m


:: Header
:Header
    echo.
    echo Running admin shell...

::------------------- Check for Admin Permissions -------------------

:init
    setlocal DisableDelayedExpansion
    set cmdInvoke=1
    set winSysFolder=System32
    set "batchPath=%~dpnx0" 
    :: this works also from cmd shell, other than %~0
    for %%k in (%0) do set batchName=%%~nk
    set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
    setlocal EnableDelayedExpansion

:checkPrivileges
    NET FILE 1>NUL 2>NUL
    if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
    if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
    echo Invoking UAC for Privilege Escalation...

    echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
    echo args = "ELEV " >> "%vbsGetPrivileges%"
    echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
    echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
    echo Next >> "%vbsGetPrivileges%"

    if '%cmdInvoke%'=='1' goto InvokeCmd 

    echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
    goto ExecElevation

:InvokeCmd
    echo args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
    echo UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
    "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
    exit

:gotPrivileges
    setlocal & cd /d %~dp0
    if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::-------------------------------------------------------------------


::---------------------------- Main Code ----------------------------
setlocal EnableExtensions
:: Debug input
::echo %batchName% Arguments: P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9

:: Get the path to the Windows temp folder and status file
if not defined tempFolder set "tempFolder=%windir%\Temp" else if "%tempFolder%"=="" set "tempFolder=%windir%\Temp"
set "telnetStatusFile=%tempFolder%\%tempFile%"

:: Get the date and time today
set "today=[%date:~4,2%/%date:~7,2%/%date:~10,4% %time:~0,8%]"

:: Check if Telnet Client feature is already enabled
dism /Online /Get-FeatureInfo /FeatureName:TelnetClient | find /i "State : Enabled" >nul
if !errorlevel! EQU 0 (
    set "telnetState=Enabled"
) else (
    set "telnetState=Disabled"
)

:: Create log string
set statusLog=!today! State : !telnetState!

:: Check if the Telnet status file exists
if exist "%telnetStatusFile%" (
    set "statusTimestamp="
    for /f "tokens=1,2 delims=[] " %%a in ('type "%telnetStatusFile%"') do (
        set "statusTimestamp=%%a %%b"
        set "statusDate=%%a"
    )

    :: Check if the file is outdated
    set "dateToday=%today:~1,10%"
    if not "!statusDate!" == "!dateToday!" (
        echo.
        echo Telnet feature status file is outdated. Updating...

        :: Update the file, logging the timestamp and the status
        echo %statusLog% > "%telnetStatusFile%"
        echo Done ^> %statusLog%
    )
) else (
    echo.
    echo Telnet feature status file doesn't exist. Creating...

    :: Create the file if missing, logging the timestamp and the status
    echo %statusLog% > "%telnetStatusFile%"
    echo Done ^> %statusLog%
)

:: Read the file for telnet status
set "statusTelnet="
for /f "tokens=5" %%a in ('type "%telnetStatusFile%"') do (
    set "statusTelnet=%%a"
)

:: Check if Telnet is installed already
echo.
if "!statusTelnet!" == "Enabled" (
    echo Telnet Client is already installed.
) else (
    if "!telnetState!" == "Enabled" (
        echo Telnet Client is already installed from previous session.
    ) else (
        echo Telnet Client is not installed. Installing...
        dism /Online /Enable-Feature /FeatureName:TelnetClient /NoRestart /Quiet
        echo Done.
    )
)

:: Show debug output (variables)
if "%debug%"=="1" (
    echo.
    echo [DEBUG] telnetInstalled = !telnetState!, today = !today!,
    echo [DEBUG] dateToday = %dateToday%,
    echo [DEBUG] statusTelnet = !statusTelnet!, statusLog = %statusLog%,
    echo [DEBUG] statusTimestamp = %statusTimestamp%, statusDate = %statusDate%,
    timeout /t 30
    goto End
)

:: Telnet Code
echo.
:Selection
    if [%1]==[] (
        echo [1] Star Wars
        echo [2] Freechess.org
        echo.
        set /p "input=Enter network index: "
    ) else (
        set "input=%1"
    )

    if "%input%"=="1" (
        echo Playing Star Wars...
        start /W telnet towel.blinkenlights.nl
        goto End
    )

    if "%input%"=="2" (
        echo Starting Freechess.org...
        start /W /MAX telnet freechess.org
        goto End
    )

    echo Invalid input.
    goto Selection

:: Uninstall Telnet if it was not installed previously
:End
    if "!statusTelnet!" == "Disabled" (
        echo.
        echo Uninstalling Telnet Client...
        dism /Online /Disable-Feature /FeatureName:TelnetClient /NoRestart /Quiet
        echo Done.
    )

::-------------------------------------------------------------------

echo.
echo Bye...
::timeout /t 2 > nul
del "%~f0" & exit