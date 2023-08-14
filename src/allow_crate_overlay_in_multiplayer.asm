%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Allows crate overlays to be placed on the map in multiplayer games.
; Author: Rampastring

@SET 0x0058BFCB, {db 0xEB} ; change jz to jmp
