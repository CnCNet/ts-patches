%include "macros/patch.inc"

; Make the AI use the EMPulse SW like it'd be firing a multi missile
; Edit the switch jump table in HouseClass::AI_TryFireSW

@SET 0x004C9F8C, {db 0x0A}
