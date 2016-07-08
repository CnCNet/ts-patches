%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool MouseAlwaysInFocus, 0
hack 0x00685E7F
        cmp     byte [MouseAlwaysInFocus], 0
        je      .Reg

        jmp     0x00685F30

.Reg:
        test    eax, eax
        setnz   al
        jmp     hackend
