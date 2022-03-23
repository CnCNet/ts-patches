@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build\release" mkdir build\release

gmake clean singleplayer.exe
gmake -j4 singleplayer.exe
move /Y singleplayer.exe ./build/release/singleplayer.exe

set /P c=Generate debug executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\debug" mkdir build\debug

gmake clean singleplayer.exe
gmake -j4 WWDEBUG=1 singleplayer.exe
move /Y singleplayer.exe ./build/debug/singleplayer.exe

pause

:exit
exit
