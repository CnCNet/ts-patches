%include "macros/patch.inc"

; Fix for difficulty getting reset on singleplayer mission restart
; Author: Rampastring

; When the user restarted the first mission of a campaign (or a single 
; non-campaign mission) through Options -> Abort Mission -> Restart,
; their difficulty level got reseted to Normal from whatever they 
; had selected in the mission selector.
; This happened regardless of whether the original game's mission selector 
; menu or the client's menu was used.

@CLEAR 0x0049399E, 0x90, 0x004939AA
