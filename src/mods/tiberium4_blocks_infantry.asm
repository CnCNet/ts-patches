; Infantry Cannot Walk Over Tiberium 4

; OverlayTypes indexes 27 to 38 (fourth Tiberium images) are hardcoded to be
; impassable by infantry. This hack removes this.

; Author: AlexB
; Date: 2016-11-24

%include "macros/patch.inc"

@SJMP 0x004D54E7, 0x004D5507; jmp short loc_4D5507
