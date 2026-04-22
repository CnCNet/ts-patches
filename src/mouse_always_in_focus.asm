%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern MouseAlwaysInFocus
cextern MouseInFocusOnce

hack 0x00685E7F

        cmp     byte [MouseAlwaysInFocus], 0
        je      .Reg

        cmp     byte [MouseInFocusOnce], 0
        mov     byte [MouseInFocusOnce], 1
        je      .Reg

        jmp     0x00685F30

.Reg:
        test    eax, eax
        setnz   al
        jmp     hackend
