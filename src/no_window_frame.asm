%include "macros/patch.inc"
%include "macros/datatypes.inc"

cglobal NoWindowFrame

@LJMP 0x00686210, SetNoWindowFrame

section .bss
    NoWindowFrame resb 1

section .text

SetNoWindowFrame:
    cmp byte [NoWindowFrame], 1
    jnz .out
    push 0x860A0000
    jmp 0x00686215
    
.out:
    push 0x02CA0000
    jmp 0x00686215
