%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool IsNoCD, true

hack 0x004754A0, 0x004754A6
    cmp byte[IsNoCD], 1
    jnz .out
    cmp edi, 1
    je .is1
    xor edi, edi
.is1:
    mov eax, edi
    retn
    
.out:
    sub esp, 0x148
    jmp hackend

    
hack 0x004756E4
    cmp byte[IsNoCD], 1
    jnz .out
    cmp eax, dword[0x711A00]
    jne 0x0047578F
    jmp 0x004756F2

.out:
    cmp eax, -1
    jle 0x004756FE
    jmp hackend

    
hack 0x0047578F, 0x00475795
    cmp byte[IsNoCD], 1
    jnz .out
    mov dword[0x711A00], eax
    cmp eax, edi
    jne 0x004756F2
    jmp 0x004757AC
    
.out:
    mov ecx, dword[esp+0x10]
    test ecx, ecx
    jmp hackend

    
hack 0x004AB8FB
    cmp byte[IsNoCD], 1
    jnz .out
    cmp eax, 3
    jne 0x004AB91E
    jmp hackend

.out:
    cmp eax, 5
    jne 0x004AB91E
    jmp hackend

    
hack 0x005DB2D4, 0x005DB2DC
    cmp byte[IsNoCD], 1
    jnz .out
    cmp al, 1
    mov dword[0x7E3EC0], ecx
    jne 0x005DB327
    cmp ebx, -1
    je 0x005DB327
    mov eax, dword[0x7E2438]
    cmp dword[eax+0x7F8], 1
    jne 0x005DB327
    mov eax, dword[eax+0x1DA4]
    mov ecx, dword[0x7E2234]
    mov edx, dword[eax*4+ecx]
    mov ecx, 0x006FE164
    push 1
    push 1
    push 1
    add ebx, 0x30
    mov byte[ecx+4], bl
    or edx, 0xFFFFFFFF
    sub ebx, 0x30
    call 0x00563670
    jmp 0x005DB327

.out:
    cmp al, 1
    mov dword[0x7E3EC0], ecx
    jmp hackend
