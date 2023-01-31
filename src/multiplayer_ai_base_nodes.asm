%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; This file contains hacks to various AI-related functions 
; to behave like in singleplayer if we are in co-op mode.
; *******************
; Author: Rampastring

cextern UseMPAIBaseNodes


; Hack HouseClass::AI_Building to behave like in singleplayer
; if we are in co-op mode
hack 0x004C128F
    cmp  dword [SessionType], 0
    jz   0x004C1554

    cmp  byte [UseMPAIBaseNodes], 0
    jnz  0x004C1554

    jmp  0x004C129D

; Hack AI base spacing stuff
hack 0x004CB9CC
    push esi
    push edi
    test eax, eax
    jz   .Return_One

    cmp  byte [UseMPAIBaseNodes], 0
    jnz  .Return_One

    jmp  0x004CB9DE

.Return_One:
    jmp  0x004CB9D2

