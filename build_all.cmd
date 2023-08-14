@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin

if not exist "build" mkdir build

REM Standard Binaries
call build_tibsun.cmd
call build_singleplayer.cmd
call build_tsclient.cmd

REM Mod Binaries
call build_mod_dta.cmd
call build_mod_ti.cmd
call build_mod_to.cmd

pause
