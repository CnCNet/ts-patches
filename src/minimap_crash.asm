; Minimap crash because of stale pointer

; For some yet unknown reason, infantry sometimes enters harvesters. When this
; happens, the infantry is removed from the map, unlinking itself from the
; radar. Before being destroyed, it might be added back again, but it's not
; removed when actually destroyed later on. This fixes only the symptom.

; Author: AlexB
; Date: 2016-07-21

%include "macros/patch.inc"
%include "macros/hack.inc"

section .text

hack 0x0063A440
_MinimapCrash:
    mov al, [esi+2Fh]; ObjectClass::InLimbo
    test al, al
    jz .Ok
    xor bl, bl

  .Ok:
    mov al, [esi+207h]; TechnoClass::IsRadarTracked
    jmp 0x0063A446
