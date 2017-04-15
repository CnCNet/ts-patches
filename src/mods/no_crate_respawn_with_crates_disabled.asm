%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Pre-placed crates and crates spawned from destroyed trucks re-spawned in multiplayer
; when they were picked up, even if the Crates setting was disabled. This fixes it.

hack 0x00457EAB
    mov eax, [SessionType]
    test eax, eax
    jz 0x00457ECE
    
    mov al, [Crates]
    test al, al
    jz 0x00457ECE
    
    jmp 0x00457EB4
    