%include "TiberianSun.inc"
%include "macros/patch.inc"

; Team/group number display on units/buildings can be repositioned to avoid overlapping with pips.
; Y axis can be changed separately when the units/buildings have pips of ammo/passengers/storage etc.

; Credits: Tuc0 for the original hack

; X axis, default 0x04. Right 0xEC, Fix 0x07
@SET 0x00637D27, {sub ecx, byte 0x07}

; Y axis when there is pips, default -5 (0xFFFFFFFB), Top 0xFFFFFFE2, Fix 0xFFFFFFF4
@SET 0x00637CE3, {mov ebx, 0xFFFFFFF4}

; Y axis when there is no pips, default -1 (0xFFFFFFFF), Top 0xFFFFFFE2, Fix 0xFFFFFFFC
hack 0x00637CCA, 0x00637CCF
		mov ecx, esi
		mov ebx, 0xFFFFFFFC
        jmp   hackend



; Font default 0x49 - last digit is for font type/size like 8 or 9
; @SET 0x00637D1F, {push byte 0x48}

; Color Default 0x00 LightGold. Rules.ini [Colors] 0-based index * 2, also +1. 
; NeonGreen = 37 * 2 = 0x4A, also 0x4B, DarkOrange = 0x1C or 0x1D
; @SET 0x00637D1B, {push byte 0x1D}

