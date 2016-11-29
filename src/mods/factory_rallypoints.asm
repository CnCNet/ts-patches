; Factory Rally Point Enhancements

; Factories can set rally points when holding the Alt key. This hack allows to
; set rally points without holding the Alt key instead. This will interfere with
; Mobile War Factories, which use the Alt-less click for undeploying.

; Author: AlexB
; Date: 2016-11-24

%include "macros/patch.inc"

; undeploy + set rally point without alt
@SET 0x00631F29, nop
@SET 0x00631F2A, nop

; undeploy with alt, rally point without
;@SJNZ 0x00631F29, 0x00631F3A
