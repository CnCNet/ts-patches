@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean tigame.exe
gmake -j4 tigame.exe
move /Y tigame.exe ./build/tigame.exe

gmake clean tigame.exe
gmake -j4 WWDEBUG=1 tigame.exe
move /Y tigame.exe ./build/tigame_debug.exe

pause
