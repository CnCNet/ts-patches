@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin
gmake WWDEBUG=1 STATS=1 clean tibsun.exe
pause
