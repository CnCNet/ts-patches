%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool IsNoCD, false

hack 0x004754A0, 0x004754A6
    cmp byte[IsNoCD], 1
    jnz .out
    xor eax, eax
    cmp edi, 1
    jnz .ret
    inc eax
	
.ret:
    retn

.out:
    sub esp, 0x148
    jmp hackend

    
hack 0x004756E4
    cmp byte[IsNoCD], 1
    jnz .out
    cmp eax, dword[0x711A00]
    jnz 0x0047578F
    jmp 0x004756F2

.out:
    cmp eax, -1
	jle 0x004756FE
    jmp hackend

    
hack 0x0047578F, 0x00475795
    cmp byte[IsNoCD], 1
    jnz .out
    cmp eax, edi
    jnz 0x004756F2
    mov dword[0x711A00], eax
    jmp 0x004757AC

.out:
    mov ecx, dword[esp+0x10]
    test ecx, ecx
    jmp hackend

    
hack 0x004AB8FB
    cmp byte[IsNoCD], 1
    jnz .out
    cmp eax, 3
    jnz 0x004AB91E
    jmp hackend

.out:
    cmp eax, 5
    jnz 0x004AB91E
    jmp hackend
