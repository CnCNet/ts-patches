%include "macros/patch.inc"

; Vinifera replaces DirectDraw with SDL, so loading a community ddraw wrapper is
; unnecessary and potentially harmful.
;
; Remove the DDRAW.dll descriptor by shifting the remaining descriptors forward
; and terminating the shortened import table in its new final slot.
%ifdef VINIFERA
@PATCH 0x006EC104
    ; DSOUND.dll
    dd 0x002EC1B4, 0, 0, 0x002ED7B8, 0x002CA04C

    ; VERSION.dll
    dd 0x002EC638, 0, 0, 0x002ED806, 0x002CA4D0

    ; COMCTL32.dll
    dd 0x002EC18C, 0, 0, 0x002ED898, 0x002CA024

    ; Import table terminator
    dd 0, 0, 0, 0, 0
@ENDPATCH
%endif
