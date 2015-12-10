%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Disable the options menu opening animation
@LJMP 0x00593EDD, 0x005942CC
@LJMP 0x00593EE5, 0x005942CC
