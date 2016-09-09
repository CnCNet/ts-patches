%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

gbool ScrapMetal, false

sstring str_ScrapExplosion, "ScrapExplosion"

@LJMP 0x0063C4E1, UseScrapMetalExplosion

UseScrapMetalExplosion:
    cmp byte[ScrapMetal], 1
    jnz .out
    push str_ScrapExplosion
    jmp 0x0063C4E6
.out:
    push 0x006F6BEC
    jmp 0x0063C4E6
    