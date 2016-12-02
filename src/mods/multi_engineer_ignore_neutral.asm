%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Hack for capturing Neutral house structures as normal even with Multi Engineer enabled
; Also makes Multi Engineer work in singleplayer missions, as it's originally
; hardcoded to be disabled
; -------------------
; Author: Rampastring

sstring str_Neutral, "Neutral"

hack 0x004D35DF
    pushad ; Save registers so they don't get modified by function calls
    mov ecx, str_Neutral
    call HouseType_From_Name
    mov ecx, eax ; HouseType_From_Name returns a house ID, value in eax
    call 0x004C4730 ; House_Pointer_From_HouseType_Index
    
    ; Now we should have the pointer of the Neutral house in EAX
       
    mov ebx, [edi+0ECh] ; edi = pointer to TechnoClass of the building, 
                        ; edi+0EC = pointer to owning house of TechnoClass
                       
    cmp ebx, eax
    popad
    
    je 0x004D36E1 ; capture building in a regular way
    jmp 0x004D35EC ; normal code
