%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; A work-around for a crash in AnimClass::AI when a building rapidly switches between
; its damaged and non-damaged state. Some pointer gets corrupted and causes crashes,
; in DTA eax always seems to be 0x100 when it happens. This ugly hack does
; not fix the pointer getting corrupted, but it checks for the bad pointer
; and skips the rest of the AnimClass::AI logic, (at least hopefully) preventing the crash.
; *******************
; Author: Rampastring

hack 0x004159C5
    cmp  eax, 400000h
    jle  0x00415A33
    mov  ecx, [eax+128h]
    jmp  0x004159CB
