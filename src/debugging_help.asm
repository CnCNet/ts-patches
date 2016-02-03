%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Increase player disconnection timeout to max
@SET 0x00707FC4, dd 0x7FFFFFFF
sstring str_MapSnapshot, "MapSnapshot.map"

hack 0x004E9D20, 0x004E9D28
        xor     edx, edx
        mov     dl, 1
        mov     ecx, str_MapSnapshot
        call    0x005DDFE0
        ret
