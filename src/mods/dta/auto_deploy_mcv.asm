%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

gbool AutoDeployMCV, false

; Makes starting units (the MCV on some scenarios) automatically deploy on game start

hack 0x005DEE42
    mov edx, dword[EBP]
    cmp byte[AutoDeployMCV], 1
    jnz .out
    push 15
    jmp 0x005DEE47
.out:
    push 5
    jmp 0x005DEE47
