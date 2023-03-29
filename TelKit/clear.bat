@echo off
set "tempFolder=%temp%"
set "tempFile=TelnetStatus"
del "%tempFolder%\%tempFile%"
timeout /t 10 /nobreak