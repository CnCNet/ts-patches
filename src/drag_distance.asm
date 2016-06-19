%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cglobal DragDistance

section .bss
        DragDistance     RESD 1


hack 0x00479353
        cmp     eax, dword[DragDistance]
        jle     0x00479397
        jmp     hackend
