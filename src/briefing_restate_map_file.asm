%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern FileClass__Is_Available

@LJMP 0x005C0930, _Restate_Briefing_Jump_To_Map_Briefing_First
@LJMP 0x005C0AA4, _Restate_Briefing_Jump_To_Mission_INI_Briefing_Next
@LJMP 0x005C0975, _Restate_Briefing_Else_Jump_Over_Reading_Briefing_Text

_Restate_Briefing_Else_Jump_Over_Reading_Briefing_Text:
    call    FileClass__Is_Available
    cmp     al, 1
    jnz     0x005C0ADD
    jmp     0x005C0982

_Restate_Briefing_Jump_To_Mission_INI_Briefing_Next:
    lea     edx, [esi+94Ch]
    cmp byte dl, 0
    jz      0x005C0935
    jmp     0x005C0AAA

_Restate_Briefing_Jump_To_Map_Briefing_First:
    call    0x00449A10
    jmp     0x005C0A90
