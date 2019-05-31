%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cglobal AutoSurrender

cextern SpawnerActive

@CLEAR 0x004B6D04, 0x90, 0x004B6D0D
@LJMP 0x004B6D04, ForceSurrenderOnAbort
@LJMP 0x00494F08, AutoSurrenderOnConnectionLost

@CLEAR 0x0046283A, 0x90, 0x00462842 ; Temporary solution, need to find out if we are dead
@LJMP 0x0046283A, SurrenderDialogOkClick ; Temporary solution, need to find out if we are dead
@LJMP 0x004627F3, SurrenderDialogOkClick2 ; Temporary solution, need to find out if we are dead

section .bss
    MeSurrendered                RESB 1
    AutoSurrender                RESB 1

section .text

ForceSurrenderOnAbort:
    cmp dword[SpawnerActive], 1
    jnz .out
    cmp dword[SessionType], 3
    jnz .out
    cmp byte[MeSurrendered], 1 ; This should check if we are dead and if that's the case jmp .out
    jz .out
    mov dword[0x7E4940], 2
    jmp 0x004B6D2A

.out:
    cmp dword[SessionType], 4
    jne 0x004B6D20
    jmp 0x004B6D0D

AutoSurrenderOnConnectionLost:
    cmp dword[SpawnerActive], 1
    jnz .out
    cmp dword[SessionType], 3
    jnz .out
    cmp byte[AutoSurrender], 1
    jnz .out
    jmp 0x00494F16

.out:
    cmp eax, 4
    jne 0x00494F28
    jmp 0x00494F0D


SurrenderDialogOkClick:
    mov byte[MeSurrendered], al 
    test eax, eax
    je 0x004628E3
    jmp 0x00462842

SurrenderDialogOkClick2:
    mov byte[MeSurrendered], 1
    mov eax, dword[0x7E2284]
    jmp 0x004627F8
