%include "macros/patch.inc"
%include "macros/datatypes.inc"

; limit the height of the sidebar to max 1116 (20 icons). The game goes out of bounds with more icons and starts to corrupt memory

hack 0x005F2766
    cmp eax, 1116
    jbe .noChange
    mov eax, 1116
    
.noChange:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend


hack 0x005F60D7
    cmp eax, 1116
    jbe .noChange
    mov eax, 1116
    
.noChange:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend
