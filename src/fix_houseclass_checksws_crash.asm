%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; The game crashes in "HouseClass_CheckSWs" at 0x004CB4BA if PlayerPtr is null.
; PlayerPtr can be null here when the game is clearing the scenario.
; This crash can happen if there is a disabled (powered-down) super-weapon building on the map
; and you load or restart the mission.
; *******************
; Author: Rampastring

hack 0x004CB4B5
    ; Stolen bytes
    call dword [edx+10h] 
    mov  edi, eax
    
    mov  eax, [PlayerPtr]
    test eax, eax         ; check if PlayerPtr is null
    jz   0x004CB58A       ; jump to end of loop where the game sets some (SW-related?) value,
                          ; as if the condition that the game needs PlayerPtr for wouldn't pass
    
    ; Original code
    jmp  0x004CB4BA

