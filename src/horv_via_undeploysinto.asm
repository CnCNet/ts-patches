%include "macros/patch.inc"

; This hack allows specifying different "harvester without back" units
; for different harvesters via the UndeploysInto= key
; With this we're able to have unique refineries and harvesters for TD and RA factions

; Credits to AlexB for the original hack

@SET 0x00653D89, {mov cl, [esi+36Dh]}
@SET 0x00653D8F, {test cl, cl}
@SET 0x00653D93, {mov eax, [eax+278h]}
@SET 0x00653D99, nop
@SET 0x00653D9A, nop
