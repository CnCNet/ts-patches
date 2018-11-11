%include "macros/patch.inc"
%include "macros/datatypes.inc"

; hard-coded power=17 for Vinifera at 0x00644DCA

hack 0x00644DCA, 0x00644DD4
    cmp dword[esi+0x84], 100
    je  .hardcode

    jmp hackend

 .hardcode:
    mov dword[esi+0x84], 17
    jmp hackend
