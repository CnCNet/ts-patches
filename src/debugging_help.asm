%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Increase player disconnection timeout to max
@SET 0x00707FC4, dd 0x7FFFFFFF
;CLEAR 0x0631F29, 0x90, 0x00631F2B
;@SJZ 0x00474AC4, 0x00474B53

; Allow multiple instances
@LJMP 0x005FFC5F, 0x005FFCC5
