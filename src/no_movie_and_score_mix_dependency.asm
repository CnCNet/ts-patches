%include "macros/patch.inc"
%include "macros/datatypes.inc"

@CLEAR 0x004E45D8, 0x004E45DB
@SET 0x004E45D8, { mov al, 1 } ;Disable MoviesXX.mix check

@SJMP 0x004E44A7, 0x004E44B6 ;Disable Scores.mix check
