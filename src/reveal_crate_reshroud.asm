%include "macros/patch.inc"

; Picking up a second "map reveal" crate normally unshrouds the map - this fixes it
@CLEAR 0x00458104, 0x90, 0x00458109
