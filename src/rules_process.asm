;
; Implementation of RulesClass::Process in ASM to allow additional section loading.
;
; Author: CCHyper (13.01.2020)
;

%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"
%include "TiberianSun.inc"

sstring str_INI_Weapons, "Weapons"

%define INIClass_EntryCount 0x004DC6A0
%define INIClass_GetEntry 0x004DC8D0
%define INIClass_GetString 0x004DDF60

%define WeaponTypeClass_FindOrMake 0x006817E0

; arg_0 = INIClass instance. 
sfunction RulesClass_WeaponTypes
    sub esp, 0x20 ; stack size.
    push ebx
    push esi
    push edi
    mov edi, [esp+0x30] ; arg_0
    push str_INI_Weapons
    mov ecx, edi
    call INIClass_EntryCount
    
    mov ebx, eax ; entry count stored in EBX.
    xor esi, esi
    test ebx, ebx
    jle .out

.loop:
    lea eax, [esp+0x0C] ; buffer[32]
    push 32 ; buffer size.
    push eax
    push 0x0074CC5C ; NULL
    
    push esi
    push str_INI_Weapons
    mov ecx, edi
    call INIClass_GetEntry
    
    push eax
    push str_INI_Weapons
    mov ecx, edi
    call INIClass_GetString
    
    test eax, eax
    jz .can_loop

    lea ecx, [esp+0x0C] ; buffer[32]
    call WeaponTypeClass_FindOrMake

.can_loop:
    inc esi
    cmp esi, ebx
    jl .loop

.out:
    xor eax, eax
    pop edi
    test ebx, ebx
    pop esi
    pop ebx
    setnle  al
    add esp, 0x20
    retn 4

hack 0x005C6710
RulesClass_Process_patch_1:
    push ebx
    push ebp
    push esi
    mov esi, [esp+0x10]
    push edi
    
    ; ESI = INIClass instance.
    ; EBP = 'this' pointer.
    
    mov ebp, ecx

    push esi
    mov ecx, ebp
    call 0x005C9530  ; RulesClass::Colors()
    
    push esi
    mov ecx, ebp
    call 0x005CC490  ; RulesClass::Houses()
    
    push esi
    mov ecx, ebp
    call 0x005CC5E0  ; RulesClass::Sides()
    
    push esi
    mov ecx, ebp
    call 0x005CC9D0  ; RulesClass::OverlayTypes
    
    push esi
    mov ecx, ebp
    call RulesClass_WeaponTypes
    
    push esi
    mov ecx, ebp
    call 0x005CC780  ; RulesClass::SuperWeaponTypes
    
    push esi
    mov ecx, ebp
    call 0x005CCB20  ; RulesClass::Warheads()
    
    push esi
    mov ecx, ebp
    call 0x005CC960  ; RulesClass::SmudgeTypes
    
    push esi
    mov ecx, ebp
    call 0x005CC860  ; RulesClass::TerrainTypes
    
    push esi
    mov ecx, ebp
    call 0x005CC7F0  ; RulesClass::BuildingTypes
    
    push esi
    mov ecx, ebp
    call 0x005CC500  ; RulesClass::VehicleTypes
    
    push esi
    mov ecx, ebp
    call 0x005CC570  ; RulesClass::AircraftTypes()
    
    push esi
    mov ecx, ebp
    call 0x005CC420  ; RulesClass::InfantryTypes()
    
    push esi
    mov ecx, ebp
    call 0x005CCA40  ; RulesClass::Animations()
    
    push esi
    mov ecx, ebp
    call 0x005CCAB0  ; RulesClass::VoxelAnims()
    
    push esi
    mov ecx, ebp
    call 0x005CCB90  ; RulesClass::Particles()
    
    push esi
    mov ecx, ebp
    call 0x005CCC00  ; RulesClass::ParticleSystems()
    
    push esi
    mov ecx, ebp
    call 0x005CE040  ; RulesClass::JumpjetControls()
    
    push esi
    mov ecx, ebp
    call 0x005CC260  ; RulesClass::MultiplayerDefualts()
    
    push esi
    mov ecx, ebp
    call 0x005CCC70  ; RulesClass::AI()
    
    push esi
    mov ecx, ebp
    call 0x005CDCA0  ; RulesClass::Powerups()
    
    push esi
    mov ecx, ebp
    call 0x005CDDD0  ; RulesClass::Land_Types()
    
    push esi
    mov ecx, ebp
    call 0x005CDEB0  ; RulesClass::IQ()
    
    push esi
    mov ecx, ebp
    call 0x005C9630  ; RulesClass::General()
    
    push esi
    mov ecx, ebp
    call 0x005D1800  ; RulesClass::Objects()
    
    push esi
    mov ecx, ebp
    call 0x005CC3D0  ; RulesClass::Maximums()
    
    push esi
    mov ecx, ebp
    call 0x005CE190  ; RulesClass::Difficulty()
    
    push esi
    mov ecx, ebp
    call 0x005C8600  ; RulesClass::CrateRules()
    
    push esi
    mov ecx, ebp
    call 0x005C8850  ; RulesClass::CombatDamage()
    
    push esi
    mov ecx, ebp
    call 0x005C6CF0  ; RulesClass::AudioVisual()
    
    push esi
    mov ecx, ebp
    call 0x005C6A60  ; RulesClass::SpecialWeapons()
    
    mov ecx, esi
    call 0x00644EB0  ; TiberiumClass::Process_INI()
    
    pop edi
    pop esi
    pop ebp
    pop ebx
    retn 4
