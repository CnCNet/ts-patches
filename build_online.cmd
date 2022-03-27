@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build\release" mkdir build\release

gmake clean
gmake -j4 STATS=1 online.exe
move /Y online.exe ./build/release/online.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\debug" mkdir build\debug

gmake clean
gmake -j4 WWDEBUG=1 STATS=1 online.exe
move /Y online.exe ./build/debug/online.exe

pause

:exit
exit
