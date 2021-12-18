@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean dtagame.exe
gmake -j4 dtagame.exe
move /Y dtagame.exe ./build/dtagame.exe

gmake clean dtagame.exe
gmake -j4 WWDEBUG=1 dtagame.exe
move /Y dtagame.exe ./build/dtagame_debug.exe

pause
