%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern Anticheat1
cextern AntiCheatArray

@LJMP 0x005D6B92, _Load_Game_Post_Load_Game_Hook
@LJMP 0x005D4FF5, _Save_Game_Pre_Save_Game_Hook

_Save_Game_Pre_Save_Game_Hook:
    mov byte bl, [0x007E2500]
    mov eax, [Scen]
    mov byte [eax+0x1D91], bl
     
;    push (StripClass_Size * 2)
;    push LEFT_STRIP
;    call memcpy
;    add esp, 0x0c    
     
    call 0x004082D0
    jmp 0x005D4FFA

_Load_Game_Post_Load_Game_Hook:
    mov eax, [Frame]
    add eax, [AutoSaveGame]
    
    mov [NextAutoSave], eax
    
    mov eax, [Scen]
    mov al, byte [eax+0x1D91]
    mov byte [0x007E2500], al

    mov ecx, MouseClass_Map
    call 0x005F3E20
    
    call 0x004082D0
    jmp 0x005D6B97
