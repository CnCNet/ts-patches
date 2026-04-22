%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern ScrollDelay

sint LastScrollTick, 0

hack 0x005E8DEA, 0x005E8DF0  ; don't call the scroll function too often (edge - ScrollClass_Do_Scroll_5E8DD0)
    mov ecx, dword[0x0074C254]

    pushad
    call ScrollAllowed
    cmp al, 1
    popad
    jz hackend
    
    jmp 0x005E9179


hack 0x005E968B, 0x005E9691  ; don't call the scroll function too often (right click - ScrollClass::Mouse_Right_Held(int,int))
    mov al, byte[edi+0x1D18]

    pushad
    call ScrollAllowed
    cmp al, 1
    popad
    jz hackend
    
    jmp 0x005E99A3
    
    
sfunction ScrollAllowed
    cmp dword[ScrollDelay], 0
    jnz .delay
    
    mov al, 1
    retn
    
.delay:
    call [_imp__timeGetTime]
    cmp dword[LastScrollTick], 0
    jz .yes
    mov edx, eax
    sub edx, dword[LastScrollTick]
    
    cmp edx, dword[ScrollDelay]
    jbe .no

.yes:
    mov dword[LastScrollTick], eax
    mov al, 1
    retn

.no:
    xor al, al
    retn

    