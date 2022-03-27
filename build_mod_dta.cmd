@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build\release" mkdir build\release

gmake clean
gmake -j4 dtagame.exe
move /Y dtagame.exe ./build/release/dtagame.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\debug" mkdir build\debug

gmake clean
gmake -j4 WWDEBUG=1 dtagame.exe
move /Y dtagame.exe ./build/debug/dtagame.exe

pause

:exit
exit
