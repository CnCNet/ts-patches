@echo off
REM
REM cnc-patch environment config
REM
set PATH=%PATH%;C:\win-builds-next-32\bin
gmake clean
gmake
pause
