%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;; Dropships need to have ammo in order to paradrop their cargo
;; This sets ammo count to cargo/5 rounded up.

hack 0x00408A1F, 0x00408A25
    push ebx
    mov  eax, [esi+0xA0]        ; Cargo Count
    add  eax, 4                 ; Round up
    cdq
    mov  ebx, 5
    idiv ebx
    pop  ebx
    mov  [esi+0x134], eax       ; Ammo
    jmp  hackend
