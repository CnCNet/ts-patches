%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; 0047C89B - wrong Tiberium patch on a slope

; temporary workaround, don't draw faulty overlay
hack 0x0045592D, 0x00455933
    and ecx, 0x000000FF
    cmp cl, 4
    ja 0x00455B26
    jmp hackend

    
hack 0x00455A3E
    mov ebp, -2
    cmp al, 4
    ja 0x00455B26
    jmp hackend
