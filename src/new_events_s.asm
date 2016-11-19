%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"


@LJA 0x004942A0, _EventClass__Execute_Extended

[section .text]
_EventClass__Execute_Extended:
    push esi
    call Switch_NewEvents

    jmp 0x00495110
