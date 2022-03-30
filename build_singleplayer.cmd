@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

set /P c=Generate Release executable [Y/N]?
if /I "%c%" EQU "N" goto :debug

if not exist "build\release" mkdir build\release

gmake clean
gmake SINGLEPLAYER=1
move /Y game.exe ./build/release/singleplayer.exe

:debug
set /P c=Generate Debug executable [Y/N]?
if /I "%c%" EQU "N" goto :vinifera

if not exist "build\debug" mkdir build\debug

gmake clean
gmake SINGLEPLAYER=1 WWDEBUG=1
move /Y game.exe ./build/debug/singleplayer.exe

:vinifera
set /P c=Generate Vinifera executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\vinifera" mkdir build\vinifera

gmake clean
gmake SINGLEPLAYER=1 VINIFERA=1
move /Y game.exe ./build/vinifera/singleplayer.exe

pause

:exit
exit
