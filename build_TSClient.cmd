@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean tsclientgame.exe
gmake -j4 tsclientgame.exe
move /Y tsclientgame.exe ./build/tsclient.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

gmake clean tsclientgame.exe
gmake -j4 WWDEBUG=1 tsclientgame.exe
move /Y tsclientgame.exe ./build/tsclient_debug.exe

pause

:exit
exit
