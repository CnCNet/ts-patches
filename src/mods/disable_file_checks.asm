%include "macros/patch.inc"
%include "macros/datatypes.inc"

sstring str_CacheMIX2, "CACHE.MIX"

; Disable check for MULTI.MIX, force function to return al=1
@SJMP 0x004E42EE, 0x004E42FD ; jmp short loc_4E42FD

; Remove need for MAPS%02d.MIX, check for Cache.mix instead
@SET 0x0044EB1E, push str_CacheMIX2
@SET 0x004E41D0, push str_CacheMIX2

; Disable check for Scores.mix 
; (music will still be read, but the game won't crash if the MIX file isn't found)
@SJMP 0x004E44A5, 0x004E44B6 ; jmp short
