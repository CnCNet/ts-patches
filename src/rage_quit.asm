%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

%define VK_F4 0x00000073
@LJNZ 0x00685E3E, _Handle_ALT_F4_Rage_Quit

section .text
_Handle_ALT_F4_Rage_Quit:
        cmp dword ecx, VK_F4
        jnz 0x00685FA0          ; Go to Keyboard stuff

        call Queue_Exit
        jmp 0x00685E44          ; Return 0 from Windows_Procedure

hack 0x00685E50
_Handle_X_Close:
        call Queue_Exit
        retn
