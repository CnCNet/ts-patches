@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean togame.exe
gmake -j4 togame.exe
move /Y togame.exe ./build/togame.exe

gmake clean togame.exe
gmake -j4 WWDEBUG=1 STATS=1 togame.exe
move /Y togame.exe ./build/togame_debug.exe

pause
