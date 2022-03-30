%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Projectiles that have Degenerates=yes lose strength by 1 each frame.
; This is rather slow, so we want to make them degenerate faster!
; Author: Rampastring

hack 0x0044597E
    cmp  eax, 10    ; degeneration strength limit, 5 in the original
    jle  0x00445B5A ; returns from function
    sub  eax, 2     ; this is {dec eax} in the original
    jmp 0x00445988
