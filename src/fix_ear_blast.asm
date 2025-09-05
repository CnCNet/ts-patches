%include "macros/patch.inc"

; Fixes an audio glitch sometimes happening in the multiplayer score screen in DTA
; Author: Rampastring, with a tip from ZivDero

; Hack MultiScore to immediately kill the audio engine
hack 0x005685CE
    mov  ecx, 0x007A2448   ; audio object
    call 0x00488380        ; kill audio
    jmp  0x005685DF
