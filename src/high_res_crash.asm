%include "macros/patch.inc"
%include "macros/datatypes.inc"

; limit the height of the sidebar to max 1052 (equals 1920*1200 -> 19 icons). The game goes out of bounds with more icons and starts to corrupt memory

hack 0x005F2766
    cmp eax, 1052
    jbe .noChange
    mov eax, 1052
    
.noChange:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend


hack 0x005F60D7
    cmp eax, 1052
    jbe .noChange
    mov eax, 1052
    
.noChange:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend
