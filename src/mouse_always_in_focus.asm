%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool MouseAlwaysInFocus, 0
hack 0x00685E96
        cmp     byte [MouseAlwaysInFocus], 0
        je      .Reg

        add     esp, 4
        jmp     0x00685F30

.Reg:
        call    0x004082D0
        jmp     hackend
