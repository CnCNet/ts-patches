@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build\release" mkdir build\release

gmake clean togame.exe
gmake -j4 togame.exe
move /Y togame.exe ./build/release/togame.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\debug" mkdir build\debug

gmake clean togame.exe
gmake -j4 WWDEBUG=1 STATS=1 togame.exe
move /Y togame.exe ./build/debug/togame.exe

pause

:exit
exit
