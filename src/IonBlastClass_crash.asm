%include "macros/patch.inc"
%include "macros/datatypes.inc"

;0x004EE9A8 - IonBlastClass - Force DetailLevel to 1

@SET 0x004EE7F0, { mov eax, 1 }
