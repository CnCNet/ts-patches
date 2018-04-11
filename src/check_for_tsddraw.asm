%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern VideoWindowed
cextern UsingTSDDRAW

hack 0x0048B6C1, 0x0048B6CA
    cmp byte[UsingTSDDRAW], 0
    jnz hackend

    cmp byte[VideoWindowed], 1
    jnz 0x0048B6CE

    jmp hackend
