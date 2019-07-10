%include "TiberianSun.inc"
%include "macros/patch.inc"

; Team number display on units can be repositioned to avoid overlapping with pips.
; Values are set to position it on top-right instead of default bottom-left.
; 
; Credits: Tuc0 for the original hack

; X axis, default 04.
@SET 0x00637D27, {sub ecx, byte 0x08}

; Y axis when there is pips, default -5 (FFFFFFFB)
@SET 0x00637CE3, {mov ebx, 0xFFFFFFE2}

; Y axis when there is no pips, default -1
hack 0x00637CCA, 0x00637CCF
		mov ecx, esi
		mov ebx, 0xFFFFFFE2
        jmp   hackend

