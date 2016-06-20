%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SpawnerActive
gbool AimableSams, 0

hack 0x0042ED42, 0x0042ED4C
        cmp DWORD[SpawnerActive], 1
        jne .regular

        cmp BYTE[AimableSams], 1
        jne .regular

        jmp .past_test_al
.regular:
        test al, al
        jz 0x0042ED60

.past_test_al:
        mov eax, [esi+0x220]
        jmp hackend

