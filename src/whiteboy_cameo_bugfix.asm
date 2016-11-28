; Fixing the 75 Cameo Issue

; The game keeps cameos in a fixed size array of 75 items per cameo list, but
; allows to add one more element, overruning the buffer. This prevents more than
; 75 cameos from appearing in a sidebar column and thus crashing the game.

; Author: AlexB
; Date: 2016-01-24, 2016-11-24

%include "macros/patch.inc"

@SJGE 0x005F463B, 0x005F46A1; jg -> jge short loc_5F46A1
