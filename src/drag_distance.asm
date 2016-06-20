%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gint DragDistance, 4

hack 0x00479353
        cmp     eax, dword[DragDistance]
        jle     0x00479397
        jmp     hackend
