%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cglobal ResponseTimeFunc

;; From ts 2.03 0x004F13C9
;; Converts CommBufferClass::Avg_ResponseTime() into something, maybe Milliseconds
section .text

ResponseTimeFunc:
    mov  eax, [esp+0x4]
    lea  eax, [eax+eax*4]
    lea  eax, [eax+eax*4]
    lea  ecx, [eax+eax*4]       ;Multiply by 125
    shl  ecx, 3                 ;Multiply by 8

    mov  eax, 88888889h
    imul ecx
    add  edx, ecx
    sar  edx, 5
    mov  ecx, edx
    shr  ecx, 1Fh
    add  edx, ecx

    mov  eax, edx
    ret
