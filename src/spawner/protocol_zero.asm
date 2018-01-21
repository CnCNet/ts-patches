%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern SpawnerActive
@CLEAR 0x00508B0C, 0x90, 0x00508B19
@CLEAR 0x005B1A2D, 0x90, 0x005B1A3B

;;; Use compressed packets for all protocols
@CLEAR 0x005B3751, 0x90, 0x005B3753
@CLEAR 0x005B3313, 0x90, 0x005B3319
