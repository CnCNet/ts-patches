%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; http://www.ppmforums.com/viewtopic.php?t=38895
; # Units in Guard mode will no longer chase after enemies that move out of firing range
@CLEAR 0x004A1AA8, 0x90, 0x004A1AAA
