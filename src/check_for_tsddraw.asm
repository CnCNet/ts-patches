%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern VideoWindowed
cextern UsingTSDDRAW

hack 0x0048B6C1, 0x0048B6CE
    cmp byte[UsingTSDDRAW], 0
    jz .out
    
    jmp hackend
    
.out:
    cmp byte[VideoWindowed], 1
    jnz hackend
    xor al, al
    jmp 0x0048B6D5
