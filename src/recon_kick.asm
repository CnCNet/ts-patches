%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; If a wrong CRC comes in from a player, we try to
;;; broadcast a REMOVEPLAYER message to everyone.

@LJNZ 0x005B4F5F, _Execute_DoList_dont_recon

section .bss
    OutOfSyncArray RESB 8

section .text

_Execute_DoList_dont_recon:
    mov  edx, [eax+0xc+0x6]     ;ID

    cmp  byte [OutOfSyncArray+edx], 1
    je   0x005B4F65

    mov  byte [OutOfSyncArray+edx], 1

    pusha
    sub  esp, 46                ; sizeof(EventClass)
    mov  ecx, esp
    push edx
    push dword 0x22             ; REMOVEPLAYER
    mov  eax, [PlayerPtr]
    mov  eax, [eax+0x20]        ; HouseClass.ID
    push eax
    call EventClass__EventClass_PlayerID

    push esp
    call EnqueueEvent
    add  esp, 50

    call MapSnapshot_Execute
    popa

    jmp  0x005B4F65

; Hack the REMOVEPLAYER event
hack 0x00494EE4
    mov  dword [AutoSaveGame], -1
    mov  eax, [esi+0x6]
    cmp  byte [OutOfSyncArray+eax], 1
    jz   0x00494F1D

    mov  eax, [Frame]
    jmp  hackend
