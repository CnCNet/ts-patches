@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

set /P c=Generate Release executable [Y/N]?
if /I "%c%" EQU "N" goto :debug

if not exist "build\release" mkdir build\release

gmake clean
gmake -j4 tsclientgame.exe
move /Y tsclientgame.exe ./build/release/tsclient.exe

:debug
set /P c=Generate Debug executable [Y/N]?
if /I "%c%" EQU "N" goto :vinifera

if not exist "build\debug" mkdir build\debug

gmake clean
gmake -j4 WWDEBUG=1 tsclientgame.exe
move /Y tsclientgame.exe ./build/debug/tsclient.exe

:vinifera
set /P c=Generate Vinifera executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\vinifera" mkdir build\vinifera

gmake clean
gmake -j4 VINIFERA=1 tsclientgame.exe
move /Y tsclientgame.exe ./build/vinifera/tsclient.exe

pause

:exit
exit
