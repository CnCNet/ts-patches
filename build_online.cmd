@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean online.exe
gmake -j4 STATS=1 online.exe
move /Y online.exe ./build/online.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

gmake clean online.exe
gmake -j4 WWDEBUG=1 STATS=1 online.exe
move /Y online.exe ./build/online_debug.exe

pause

:exit
exit
