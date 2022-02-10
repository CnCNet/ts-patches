@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean dtagame.exe
gmake -j4 dtagame.exe
move /Y dtagame.exe ./build/dtagame.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

gmake clean dtagame.exe
gmake -j4 WWDEBUG=1 dtagame.exe
move /Y dtagame.exe ./build/dtagame_debug.exe

pause

:exit
exit
