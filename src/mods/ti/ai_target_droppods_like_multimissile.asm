%include "macros/patch.inc"

; Makes the AI target the drop pod SW like it'd be firing a multi missile
; In other words, makes the AI kill you with drop pods instead of just defending its base
; Edits the switch jump table in HouseClass::AI_TryFireSW

@SET 0x004C9FA0, {db 0x0A}
