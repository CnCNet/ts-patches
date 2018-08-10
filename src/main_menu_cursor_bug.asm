%include "TiberianSun.inc"
%include "macros/patch.inc"

; prevent slow downs in main menu caused by constant hide/show cursor function calls

@CLEAR 0x004B7812, 0x90, 0x004B7815 ; hide cursor
@CLEAR 0x004B7824, 0x90, 0x004B7827 ; show cursor
