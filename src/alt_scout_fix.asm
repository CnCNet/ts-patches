;@JMP 0x00631F15 _TechnoClass_WhatAction_NoRallyPlaceInShroud

_TechnoClass_WhatAction_NoRallyPlaceInShroud:
        mov     edx, [edi]
        mov     ecx, edi
        call    dword [edx+220h]
 
        test    al, al
        jz      0x00631F4C
 
        mov     al, [esp+11h]
        test    al, al
        jz      0x00631F3A
 
        mov     ebx, [esp+2Ch]
        push    1
        push    ebx
        mov     ecx, 0x00748348
        call    0x0051E380      ;MapClass::Is_Unshrouded()
 
        test    al, al
        jnz     .lct_NoMove
 
        .lct_Out:
        jmp     0x00631F2B
 
        .lct_NoMove:
        pop     edi
        pop     esi
        pop     ebp
        mov     eax, 2 ;NOMOVE
        pop     ebx
        add     esp, 18h
        retn    0Ch