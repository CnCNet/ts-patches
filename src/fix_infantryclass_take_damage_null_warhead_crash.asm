%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; A work-around for a crash in InfantryClass::Take_Damage when
; the warhead is null, sometimes seen in DTA despite that everything
; in the INI configuration files appears to be as they should.
; *******************
; Author: Rampastring

hack 0x004D2451
    cmp  edi, 0
    je   0x004D254A ; return
    mov  al, [edi+0D5h]
    test al, al
    jz   0x004D2522
    jmp  0x004D245F
