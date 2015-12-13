%include "macros/patch.inc"
%include "macros/datatypes.inc"

; hifi <3 CCHyper, he's a nice chap!

; - Disruptor tank drawing error that resulted in a Internal Error on some computers is fixed, hopefully...
@LJMP 0x006703C1, _sonic_beam_fix
_sonic_beam_fix:
    cdq
    xor     eax, edx
    sub     eax, edx
    cmp     eax, 9
    jl      .loc_out
    mov     eax, 9
.loc_out:
    jmp     0x6703C6

; - Cameo drawn over a factory BuildingType when infiltrated in the incorrect palette has now been fixed.
@LJMP 0x00428B00, _spy_cameo_palette
_spy_cameo_palette:
    mov     edx, 0x7481F0
    jmp     0x428B06

; - A human controlled AircraftType that is able to carry passengers would get it's target cell
;   corrupted, resulting in the Aircraft never landing. This is now fixed.
@SJMP 0x0040A56D, 0x0040A5C2
@SJMP 0x0040A669, 0x0040A6BA
