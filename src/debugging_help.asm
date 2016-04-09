%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; Increase player disconnection timeout to max
@SET 0x00707FC4, dd 0x7FFFFFFF
