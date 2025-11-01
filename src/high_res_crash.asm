%include "macros/patch.inc"
%include "macros/datatypes.inc"

; limit the height of the sidebar to max 1052 (equals 1920*1200 -> 19 icons). The game goes out of bounds with more icons and starts to corrupt memory
cextern InfoPanel
cextern BottomInfoPanel         ; Gets set in sidebar.c

hack 0x005F2766
    cmp eax, 1052
    jbe .noChange
    mov eax, 1052

.noChange:
    cmp dword[InfoPanel], -1
    je .reg

    cmp dword[BottomInfoPanel], 0
    jz  .reg

    sub eax, 153                ; For info panel

.reg:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend


hack 0x005F60D7
    cmp eax, 1052
    jbe .noChange
    mov eax, 1052

.noChange:
    cmp dword[InfoPanel], -1
    je .reg

    cmp dword[BottomInfoPanel], 0
    jz  .reg

    sub eax, 153               ; For info panel
.reg:
    mov dword[0x0074C24C], eax ; SidebarHeightStuff
    jmp hackend
