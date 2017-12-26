%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern record_rng_ii           ; Defined in log_more_oos.c
cextern record_rng_void

hack 0x005BE080, 0x005BE086
        push ecx
        call record_rng_ii
        pop ecx
 .Reg:
        mov eax, [esp+4]
        mov edx, ecx
        jmp hackend

hack 0x005BE030
        push ecx
        call record_rng_void
        pop ecx
.Reg:
        mov eax, [ecx+0]
        mov edx, [ecx+4]
        jmp hackend
