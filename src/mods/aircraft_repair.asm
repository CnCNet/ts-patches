%include "macros/patch.inc"

; Makes all repair bays able to repair aircraft, not just the building listed in RepairBay=
; Fix by Iran

@SJMP 0x0040B917, 0x0040B929
