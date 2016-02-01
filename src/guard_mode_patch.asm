%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; http://www.ppmforums.com/viewtopic.php?t=38895
@CLEAR 0x004A1AA8, 0x90, 0x004A1AAA
@SJMP 0x00494AB5, 0x00494AE1
