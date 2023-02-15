%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Players skipping movies in multiplayer leads to disconnects.
; Prevent players from skipping movies in MP.
; *******************
; Author: Rampastring

cextern PlayMoviesInMultiplayer

hack 0x0066BB61
    cmp  byte [PlayMoviesInMultiplayer], 1
    je   0x0066BA30 ; don't allow skipping movie

    mov  ecx, [0x007482C0] ; WWKeyboardClass* Keyboard
    jmp  0x0066BB67 ; jump back to keyboard check
