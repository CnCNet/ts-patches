%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; http://www.ppmforums.com/viewtopic.php?t=37620
;;; A bug where the Armor crate weakens the unit instead of powering it up
@SET 0x00458C01, fmul qword [esp+0x38]

;;; Allow a unit to get multiple powerups
@CLEAR 0x00457E74, 0x90, 0x00457E7A
@CLEAR 0x00458BF9, 0x90, 0x00458BFB
@SET 0x00458C07, fadd qword [ecx+0B0h]
