; doesnt work

;@JMP    0x004BBC2D _Who_Can_Build_Me_NCO_Bug_Fix

_Who_Can_Build_Me_NCO_Bug_Fix:
    mov     edi, [esp+0x30]
    mov     ebp, ecx

    mov     ecx, [PlayerPtr]
    mov     ecx, [ecx+24h]
    mov     ecx, [ecx+64h]
    mov     eax, 1
    shl     eax, cl
    mov     ecx, [edi+0x360]
    test    ecx, eax
    jz      0x004BBC43 ; return false
    

    mov     al, byte [esp+0x34]
    test    al, al
    jnz     0x004BC127
    jmp     0x004BBC39
