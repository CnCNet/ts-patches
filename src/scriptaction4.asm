%include "TiberianSun.inc"
%include "macros/patch.inc"

; Script action 4 : Move to Cell.. (4,cell#) uses leftover logic from RA1 to compute coordinates.
; Original formula: cell# = x + (y * 128)
; This patch converts the formula to: cell# = x + (y * 1000)
; Making it similar to waypoint/celltag computations, so that larger map coordinates are supported.

; Credits: E1 Elite

hack 0x00622B2C
    mov eax, ecx
    mov ebp, 0x000003E8
    cdq
    idiv ebp
    mov eax, 0x10624DD3
    mov [esp+10h], dx
    imul ecx
    sar edx, 0x06
    mov eax, edx
    shr eax, 0x1F
    add edx, eax
    mov [esp+12h], dx
    mov ecx, 0x00748348
    lea eax, [esp+10h]
    push eax
    call 0x0050F280
    jmp 0x00622B11

