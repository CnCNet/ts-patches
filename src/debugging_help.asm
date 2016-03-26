%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Increase player disconnection timeout to max
@SET 0x00707FC4, dd 0x7FFFFFFF

hack 0x004E9D20, 0x004E9D28
        mov     eax, [MultiplayerDebug]
        test    al, al
        jz      .enable
        mov     DWORD [MultiplayerDebug],0
        jmp     .end
.enable:
        mov     DWORD [MultiplayerDebug],1
.end:
        ret
