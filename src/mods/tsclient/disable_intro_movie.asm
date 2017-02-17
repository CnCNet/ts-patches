%include "macros/patch.inc"

; The game is hardcoded to display INTRO.VQA before loading the mission in some cases
; This hack disables the behaviour

@SET 0x006FE164, {db "B"}
