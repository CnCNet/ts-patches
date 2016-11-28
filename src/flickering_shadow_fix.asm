; Disable Flickering Shadow When Vehicles With Turrets Flash

; The shadow is originally hardcoded to not draw two out of every four game
; frames. This looks strange and is kinda inconsistent with infantry and units
; without turrets. This hack disables this feature.

; Author: AlexB
; Date: 2016-03-25, 2016-11-24

%include "macros/patch.inc"

@SET 0x0063587E, {and eax, DWORD 0}
