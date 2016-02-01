%include "TiberianSun.inc"
%include "macros/patch.inc"

;;; Harvester truce makes harvesters Immune during Multiplayer games.
@PATCH 0x005DD580
_set_specialclass_bitfield_for_harvtruce:
        mov     eax, [SpecialClass__Special]
        or      eax, edx
        cmp     byte [HarvesterTruce], 1
        jne     .lct_no_harv_truce
        or      eax, 0x400
.lct_no_harv_truce:
        mov     [SpecialClass__Special], eax
        nop
        nop
@ENDPATCH
