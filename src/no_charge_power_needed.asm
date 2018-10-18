%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; When Charges=Yes, this patch allows the structure to shoot even on low power
@CLEAR 0x00435271, 0x90, 0x00435287
