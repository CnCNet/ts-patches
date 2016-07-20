%include "macros/patch.inc"

; Fixes [Basic]Theme= so it does not stop playing
; music after the track has been played once
; AlexB's original hack: http://ppmforums.com/viewtopic.php?p=547837#547837

@CALL 0x005DB3FD, 0x00643F20
