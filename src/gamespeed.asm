%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Set Game Speed 6 to 52 FPS rather than 45 FPS
@SET 0x005B1AAA, dd 0x34
