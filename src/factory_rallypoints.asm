; Factory Rally Point Enhancements

; Factories can set rally points when holding the Alt key. This hack allows to
; set rally points without holding the Alt key instead. This will interfere with
; Mobile War Factories, which use the Alt-less click for undeploying.

; Author: AlexB
; Date: 2016-11-24

%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern AltToRally

; undeploy with alt, rally point without
hack 0x00631F23, 0x00631F2B
    mov  al, byte[esp+0x11]     ; Is alt down?

    xor  al, byte[AltToRally]   ; Flip alt behavior
    test al, al
    jz   hackend

    jmp  0x00631F3A
