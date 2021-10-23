%include "macros/patch.inc"

; DTA's AI is smarter at targeting MultiSpecial than ChemicalSpecial
; thanks to code added in to DTA's build of Vinifera.

; Makes the AI use the Chemical Missile SW like it'd be firing a Multi-Missile
; Edit the switch jump table in HouseClass::AI_TryFireSW

@SET 0x004C9F9C, {db 0x0A}
