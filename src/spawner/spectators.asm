%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "ini.inc"

cglobal IsSpectatorArray
cglobal SpectatorStuffInit
cglobal Load_Spectators_Spawner

cextern INIClass_SPAWN
cextern SpawnerActive

section .bss
    IsSpectatorArray           RESD 8
    SpectatorStuffInit         RESB 1

section .rdata
    str_Multi1          db "Multi1",0
    str_Multi2          db "Multi2",0
    str_Multi3          db "Multi3",0
    str_Multi4          db "Multi4",0
    str_Multi5          db "Multi5",0
    str_Multi6          db "Multi6",0
    str_Multi7          db "Multi7",0
    str_Multi8          db "Multi8",0
    str_IsSpectator     db "IsSpectator",0


hack 0x00479974
_DisplayClass__Encroach_Shadow_Spectator:

    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Coach
    test al, al
    jnz  .Reg

    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Spectator
    test al, al
    jnz  0x004799F7

 .Reg:
    call 0x0051E270
    jmp 0x00479979

hack 0x004BF71B
_HouseClass__MPlayer_Defeated_Ignore_Spectator_In_Skirmish:

    cmp [PlayerPtr], eax
    jnz .Normal_Code

    cmp dword [SessionType], 5
    jnz .Normal_Code

    push eax
    mov eax, [eax+0x20]

    cmp dword [IsSpectatorArray+eax*4], 1
    pop eax

    jz .Dont_Count

.Normal_Code:
    cmp byte [eax+0CBh], 0
    jmp 0x004BF722

.Dont_Count:
    jmp 0x004BF74A

hack 0x005DE717
_Create_Units_Dont_Count_Spectators_When_Counting_Players:
    lea  eax, [edx+ecx]

    push ebx
    push esi

    mov esi, 0
    mov ebx, 0

.Loop:
    cmp dword [IsSpectatorArray+esi*4], 0
    jz .Next_Iter

    inc ebx

.Next_Iter:
    inc esi
    cmp esi, 8
    jl .Loop


.Out_Loop:
    sub eax, ebx

    pop esi
    pop ebx

    cmp edi, eax
    jmp 0x005DE71C

hack 0x004C968E
_sub_4C9560_Spectator_Stuff:
    cmp dword [PlayerPtr], esi
    jnz .Ret

    mov esi, [PlayerPtr]
    mov esi, [esi+0x20]
    cmp dword [IsSpectatorArray+esi*4], 1
    jz .Ret

    call 0x005BC080
    jmp 0x004C9693

.Ret:
    add esp, 4
    jmp 0x004C9693

_BuildingClass__Visual_Character_Spectator_Stuff:
@CALL 0x0043852B, HouseClass__Is_Ally_Or_Spec_HH
@CALL 0x00438540, HouseClass__Is_Ally_Or_Spec_HH

_TechnoClass__Visual_Character_Spectator_Stuff:
@CALL 0x00633E85, HouseClass__Is_Ally_Or_Spec_HH
@CALL 0x00633E9F, HouseClass__Is_Ally_Or_Spec_HH

hack 0x004BC608
_HouseClass__AI_Spectator_Stuff:
    call 0x004C9560

    cmp dword [PlayerPtr], esi
    jnz .Ret

    cmp byte [SpectatorStuffInit], 0
    jnz .Ret


    mov ecx, [PlayerPtr]
    mov ecx, [ecx+0x20]
    cmp dword [IsSpectatorArray+ecx*4], 0
    jz .Ret

    mov byte [0x00749808], 1

    push 1
    mov ecx, MouseClass_Map
    call 0x005BBEE0

    mov byte [SpectatorStuffInit], 1

.Ret:
    jmp 0x004BC60D

hack 0x005DE8F9
_Create_Units_Dont_Create_For_Dead_Houses:
    mov     edx, [HouseClassArray_Vector]
    mov     esi, [edx+ecx*4]

    cmp byte [esi+0x0CB], 1
    jz 0x005DEF1D ; if dead jump to next unit

    jmp 0x005DE902

hack 0x005B9CFE
_sub_5B9B90_Set_Up_Spectator_Player_Stuff:
    cmp dword [SpawnerActive], 1
    jne .Ret

    mov byte [SpectatorStuffInit], 0

    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Coach
    test al, al
    jnz .Ret

    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Spectator
    test al, al
    jz  .Ret

    mov ecx, dword [PlayerPtr]
    cmp byte [ecx+0x0CB], 1
    jnz .Ret

    mov dword [Message_Input_Player_Dead], 1

    mov ecx, MouseClass_Map
    call 0x0051E0A0

.Ret:
    pop edi
    pop esi
    pop ebp
    add esp, 14h
    jmp 0x005B9D04

section .text

Load_Spectators_Spawner:
    SpawnINI_Get_Bool str_IsSpectator, str_Multi1, 0
    mov dword [IsSpectatorArray+0], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi2, 0
    mov dword [IsSpectatorArray+4], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi3, 0
    mov dword [IsSpectatorArray+8], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi4, 0
    mov dword [IsSpectatorArray+12], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi5, 0
    mov dword [IsSpectatorArray+16], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi6, 0
    mov dword [IsSpectatorArray+20], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi7, 0
    mov dword [IsSpectatorArray+24], eax

    SpawnINI_Get_Bool str_IsSpectator, str_Multi8, 0
    mov dword [IsSpectatorArray+28], eax

    retn

_TechnoClass_Draw_Health_Boxes_unit_draw_pips:
@CALL 0x0062C6CE, HouseClass__Is_Ally_Or_Spec_HH

_TechnoClass_Draw_Health_Boxes_bldg_draw_pips:
@CALL 0x0062CA26, HouseClass__Is_Ally_Or_Spec_HH

_BuildingClass_Draw_Overlays_draw_power:
@CALL 0x00428A23, HouseClass__Is_Ally_Or_Spec_HH

@LJZ 0x00428A88, _Draw_Overlays_spectator_spy
section .text
_Draw_Overlays_spectator_spy:
    jnz  0x00428A8E

    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Coach
    test al, al
    jnz  .is_ally

    mov ecx, [PlayerPtr]
    call HouseClass__Is_Spectator
    test al, al
    jnz  0x00428A8E

    jmp  0x00428B13

 .is_ally:
    mov  eax, [esi+0xE0]
    push eax
    mov  ecx, [PlayerPtr]
    call HouseClass__Is_Ally_HH
    test al, al
    jnz  0x00428A8E

    jmp  0x00428B13
