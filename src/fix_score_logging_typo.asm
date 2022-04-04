%include "macros/patch.inc"

; Fixes Westwood typo in DTA/TI/TS.log score logging,
; they write "Losser" instead of "Loser"

@SET 0x0070538B, {db 0x65}
@SET 0x0070538C, {db 0x72}
@SET 0x0070538D, {db 0x00}

