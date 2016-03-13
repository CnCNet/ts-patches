%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; These values are 1/60th of a second.
@SET 0x005DB794, {mov ecx, 1200}
@SET 0x00707FC4, dd 0x4b0
