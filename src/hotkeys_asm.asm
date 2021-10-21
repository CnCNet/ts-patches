%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern HookInitCommands

; Re-implement function return procedure to make it add ts-patches hotkeys before returning
; Author: Rampastring
hack 0x004E703C
    call HookInitCommands
    ; Return from function
    pop  esi
    pop  ebx
    add  esp, 0Ch
    retn

