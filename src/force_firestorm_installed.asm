%include "TiberianSun.inc"
%include "macros/patch.inc"

;
; This patch forces the Firestorm addon to be "installed", allowing the
; game mode to be toggled by the spawner code.
;
; Author: CCHyper
;
_Force_Addon_Present:

; Set TS to be installed, and enabled.
mov     eax, 1
mov     [0x006F2638], eax ; InstalledMode
mov     [0x006F263C], eax ; EnabledMode

; Set FS to be installed.
mov     eax, [0x006F2638] ; InstalledMode
or      al, 2
mov     [0x006F2638], eax

retn


@LJMP 0x00407050, _Force_Addon_Present
