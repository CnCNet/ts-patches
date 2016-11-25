%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "ini.inc"

cglobal IsSpectatorArray
cglobal SpectatorStuffInit
cglobal Load_Spectators_Spawner

cextern INIClass_SPAWN
cextern SpawnerActive

@LJMP 0x005DE8F9, _Create_Units_Dont_Create_For_Dead_Houses
@LJMP 0x005B9CFE, _sub_5B9B90_Set_Up_Spectator_Player_Stuff
@LJMP 0x004BC608, _HouseClass__AI_Spectator_Stuff
@LJMP 0x00633E76, _TechnoClass__Visual_Character_Spectator_Stuff
@LJMP 0x00438520, _BuildingClass__Visual_Character_Spectator_Stuff
@LJMP 0x004C968E, _sub_4C9560_Spectator_Stuff
@LJMP 0x005DE717, _Create_Units_Dont_Count_Spectators_When_Counting_Players
@LJMP 0x004BF71B, _HouseClass__MPlayer_Defeated_Ignore_Spectator_In_Skirmish
@LJMP 0x00479974, _DisplayClass__Encroach_Shadow_Spectator

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

section .text

_DisplayClass__Encroach_Shadow_Spectator:

    mov eax, [PlayerPtr]
    mov eax, [eax+0x20]
    cmp dword [IsSpectatorArray+eax*4], 1
    jz 0x004799F7

    call 0x0051E270
    jmp 0x00479979

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
    mov ecx, [PlayerPtr]
    test ecx, ecx
    jz 0x00438549

    mov ecx, [PlayerPtr]
    mov ecx, [ecx+0x20]
    cmp dword [IsSpectatorArray+ecx*4], 1
    jz 0x004384DF

    mov ecx, [PlayerPtr]
    jmp 0x0043852A

_TechnoClass__Visual_Character_Spectator_Stuff:
    mov ecx, [PlayerPtr]
    mov ecx, [ecx+0x20]
    cmp dword [IsSpectatorArray+ecx*4], 1
    jz 0x00633EAC

    mov ecx, [PlayerPtr]
    test ecx, ecx
    jz 0x00633CFE
    jmp 0x00633E84

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

_Create_Units_Dont_Create_For_Dead_Houses:
    mov     edx, [HouseClassArray_Vector]
    mov     esi, [edx+ecx*4]

    cmp byte [esi+0x0CB], 1
    jz 0x005DEF1D ; if dead jump to next unit

    jmp 0x005DE902

_sub_5B9B90_Set_Up_Spectator_Player_Stuff:
    cmp dword [SpawnerActive], 1
    jne .Ret

    mov byte [SpectatorStuffInit], 0

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

hack 0x0062C6CE
_TechnoClass_Draw_Health_Boxes_unit_draw_pips:
    pop  ecx
    mov  edx, [ecx+0x20]
    mov  eax, [IsSpectatorArray+edx*4]
    test eax, eax
    jnz  hackend

    push ecx
    mov  ecx, [ebx+0xEC]
    call 0x004BDA20             ; HouseClass::Is_Ally()

    jmp  hackend

hack 0x0062CA26
_TechnoClass_Draw_Health_Boxes_bldg_draw_pips:
    pop  ecx
    mov  edx, [ecx+0x20]
    mov  eax, [IsSpectatorArray+edx*4]
    test eax, eax
    jnz  hackend

    push ecx
    mov  ecx, [ebx+0xEC]
    call 0x004BDA20             ; HouseClass::Is_Ally()

    jmp  hackend
