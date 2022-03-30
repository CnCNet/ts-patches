%include "macros/patch.inc"

; Harvester pip count 5 (including it here just so it can be changed easily)
@SET 0x0063D48E, {mov eax, 5}

; Change max passenger pip count to 20
@SET 0x0063D487, {cmp ecx, 20}

; Mobile EMP charge pip count?
@SET 0x0063D494, {mov eax, 8}

