@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

gmake clean tsclient.exe
gmake -j4 tsclientgame.exe
move /Y tsclientgame.exe ./build/tsclient.exe

gmake clean tsclient.exe
gmake -j4 WWDEBUG=1 tsclient.exe
move /Y tsclient.exe ./build/tsclient_debug.exe

pause
