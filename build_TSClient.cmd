@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build\release" mkdir build\release

gmake clean
gmake -j4 tsclientgame.exe
move /Y tsclientgame.exe ./build/release/tsclient.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\debug" mkdir build\debug

gmake clean
gmake -j4 WWDEBUG=1 tsclientgame.exe
move /Y tsclientgame.exe ./build/debug/tsclient.exe

pause

:exit
exit