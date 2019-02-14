%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;; Units in Area Guard mode will revert to regular Guard mode when you press S
@SET 0x00494ABC, { cmp dword eax, 2 } ; ABSTRACT_AIRCRAFT
@LJZ 0x00494ABF, 0x00495110           ; jump out
@LJMP 0x00494AC5, 0x00494AE3

;;; Don't move back to the previous cell when G is pressed.
@CLEAR 0x004E95E2, 0x90, 0x004E95EB
@SET 0x004E95E2, { push dword 0 }
