@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean tigame.exe
gmake -j4 tigame.exe
move /Y tigame.exe ./build/tigame.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

gmake clean tigame.exe
gmake -j4 WWDEBUG=1 tigame.exe
move /Y tigame.exe ./build/tigame_debug.exe

pause

:exit
exit
