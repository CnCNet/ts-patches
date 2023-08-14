%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Makes the game save screenshots into a sub-directory

sstring str_Screenshots, "Screenshots\SCRN%04d.pcx"

@SET 0x004EAC41, push str_Screenshots