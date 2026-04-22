%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern ScrapMetal

sstring str_ScrapExplosion, "ScrapExplosion"

hack 0x0063C4E1 ; UseScrapMetalExplosion
    cmp byte[ScrapMetal], 1
    jnz .out
    push str_ScrapExplosion
    jmp 0x0063C4E6
.out:
    push 0x006F6BEC
    jmp 0x0063C4E6
    