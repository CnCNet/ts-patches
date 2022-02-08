@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean singleplayer.exe
gmake -j4 singleplayer.exe
move /Y singleplayer.exe ./build/singleplayer.exe

gmake clean singleplayer.exe
gmake -j4 WWDEBUG=1 singleplayer.exe
move /Y singleplayer.exe ./build/singleplayer_debug.exe

pause
