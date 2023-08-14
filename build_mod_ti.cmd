@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

set /P c=Generate Release executable [Y/N]?
if /I "%c%" EQU "N" goto :debug

if not exist "build\release" mkdir build\release

gmake clean
gmake -j4 tigame.exe
move /Y tigame.exe ./build/release/tigame.exe

:debug
set /P c=Generate Debug executable [Y/N]?
if /I "%c%" EQU "N" goto :vinifera

if not exist "build\debug" mkdir build\debug

gmake clean
gmake -j4 WWDEBUG=1 tigame.exe
move /Y tigame.exe ./build/debug/tigame.exe

:vinifera
set /P c=Generate Vinifera executable [Y/N]?
if /I "%c%" EQU "N" goto :exit

if not exist "build\vinifera" mkdir build\vinifera

gmake clean
gmake -j4 VINIFERA=1 tigame.exe
move /Y tigame.exe ./build/vinifera/tigame.exe

pause

:exit
exit
