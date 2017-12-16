%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

%define VK_F4 0x00000073
@LJNZ 0x00685E3E, _Handle_ALT_F4_Rage_Quit

section .text
_Handle_ALT_F4_Rage_Quit:
        cmp dword ecx, VK_F4
        jnz 0x00685FA0          ; Go to Keyboard stuff

        pusha
        call Queue_RemovePlayer
        call Queue_Exit
        popa
        jmp 0x00685E44          ; Return 0 from Windows_Procedure

hack 0x00685E50
_Handle_X_Close:
        pusha
        call Queue_RemovePlayer
        call Queue_Exit
        popa
        jmp hackend

section .text
Queue_RemovePlayer:
        sub  esp, 46                ; sizeof(EventClass)
        mov  ecx, esp
        mov  eax, [PlayerPtr]
        mov  eax, [eax+0x20]        ; HouseClass.ID
        push eax
        push dword 0x22             ; REMOVEPLAYER
        push eax
        call EventClass__EventClass_PlayerID

        mov  ecx, esp
        call EventClass__EnqueueEvent
        add  esp, 50
        retn
