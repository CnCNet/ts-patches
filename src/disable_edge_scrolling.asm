%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool DisableEdgeScrolling, false      ; Read from sun.ini in sun.ini.c
;;; Disable Edge scrolling
hack 0x005E9058, 0x005E905E
        mov     al, [DisableEdgeScrolling]
        test    al, al
        jnz     .no_scroll

        call    [edx+09Ch]
        jmp     hackend

.no_scroll:
        pop     eax
        pop     eax
        pop     ebx
        mov     eax, 0
        jmp     hackend

