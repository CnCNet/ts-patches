%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

%define MOVIES_MAX 3
hack 0x004E45CA
        add     esp, 8
        inc     ebp
        cmp     ebp, MOVIES_MAX
        jle     0x004E453E

        mov     eax, [0x0074A0F8]
        sub     esp, 8
        jmp     hackend
