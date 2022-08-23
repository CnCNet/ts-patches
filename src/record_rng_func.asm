%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern record_rng_ii           ; Defined in log_more_oos.c
cextern record_rng_void

gbool NoRNG, 0

%ifndef VINIFERA

hack 0x005BE080, 0x005BE086
        push ecx
        call record_rng_ii
        pop ecx
 .Reg:
        mov eax, [esp+4]
        mov edx, ecx
        jmp hackend

hack 0x005BE08B
        cmp byte [NoRNG], 1
        jl .Reg
        
        cmp dword [Frame], 10
        jl .Reg
        
        ; return min
        pop ebp
        retn 8

 .Reg:
        cmp eax, ecx
        mov ebp, eax
        jz  0x005BE11B
        jle 0x005BE09B
        jmp 0x005BE097
        
hack 0x005BE030
        push ecx
        call record_rng_void
        pop ecx
.Reg:
        mov eax, [ecx+0]
        mov edx, [ecx+4]
        jmp hackend

hack 0x0005BE04B
        cmp byte [NoRNG], 1
        jl .Reg
        
        cmp dword [Frame], 10
        jl .Reg
        
        ; return 0
        mov eax, 0
        pop esi
        retn

 .Reg:
        mov eax, [ecx+edx*4+8]
        inc edx
        inc esi
        jmp 0x005BE051

%endif
