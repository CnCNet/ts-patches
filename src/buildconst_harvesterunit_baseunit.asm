; BuildConst, BuildRefinery, BuildWeapons, BaseUnit, and HarvesterUnit
; restrictions removed

; With this hack, the game will not only look at the first items of BuildConst,
; BuildRefinery, and HarvesterUnit even though both are lists reading multiple
; items. This also applies to BuildWeapons, which in some instances only checked
; the first two items.

; HarvesterUnit now fulfills two purposes: it defines all Harvesters and all
; BaseUnits. This hack has some limitations, though, but they can be worked
; around.

; Features:
; - When the AI concludes it needs to build a new harvester, it will build the
;   first item from HarvesterUnit= that has Harvester=yes and the house matches
;   Owner=.

; - Every item from BuildConst is now considered a construction yard. This means
;   it will allow AIs to start base building, units that deploy into one of
;   these will auto-deploy and so on.

; - BaseUnit= still remains a single item. When a BaseUnit= is to be created
;   (either as starting unit, as crate goodie, as reinforcement, or built from
;   a factory), the game now automatically replaces it with the first item from
;   HarvesterUnit= that has Harvester=no but an Owner= matching the house. If no
;   Harvester=no unit can be found, the actual BaseUnit= type is used (as it was
;   before).
;   A dummy BaseUnit type is required for this to work.

; Notes and Limitations:
; - All units with Harvester=no in the HarvesterUnit= list will keep the player
;   alive during Short Game matches.
; - All units with Harvester=yes in the HarvesterUnit= list are immune if
;   Harvester Truce is on. Such units won't keep the player alive even if Short
;   Game is off.
; - For each house, the first matching unit is taken from HarvesterUnit=. The
;   game will not randomly chose from any matching units.
; - Originally, there had to be one unit set as HarvesterUnit which was used for
;   every house. Now, every house needs to find at least one owned unit in this
;   list. Currently, there is no fallback to the first item.
; - The functions have been changed to not use the country's array index for
;   checking against Owner, but the ActsLike on the house itself. If used
;   together with the sideindex_improvements_v2, ActsLike defaults to the
;   country's array index and thus will give the same results if not overridden.

; Author: AlexB
; Date: 2016-07-21 to 2016-07-27: initial release
;       2019-04-27 Changed to use ActsLike

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/extern.inc"

section .data

cglobal AlexB_HarvesterUnit
AlexB_HarvesterUnit dd 0

cglobal AlexB_BuildRefinery
AlexB_BuildRefinery dd 0

section .text

; stdcall
; param 1: HouseClass pointer
; param 2: DynamicVectorClass<UnitTypeClass*> pointer
; param 3: what value Harvester= must have as bool
_FindFirstOwnedUnitTypeInVector:
    ; edx becomes the Owner mask
    mov ecx, [esp+4h]; param 1
    mov ecx, [ecx+0C0h]; HouseClass::ActsLike
    mov edx, 1
    shl edx, cl

    push ebx
    push esi
    mov eax, [esp+10h]; param 2
    mov ecx, [eax+4h]; VectorClass::Items
    mov eax, [eax+10h]; VectorClass::Count
    lea esi, [ecx+eax*4]; end

    cmp ecx, esi
    je .NotFound
    mov bl, [esp+14h]; param 3

  .LoopStart:
    mov eax, [ecx]
    cmp [eax+48Eh], bl; UnitTypeClass::Harvester
    jne .LoopEnd
    test [eax+360h], edx; TechnoTypeClass::Owner
    jne .Found

  .LoopEnd:
    add ecx, 4
    cmp ecx, esi
    jne .LoopStart

  .NotFound:
    xor eax, eax

  .Found:
    pop esi
    pop ebx
    ret 0Ch


; stdcall
; param 1: HouseClass pointer
; param 2: DynamicVectorClass<TechnoTypeClass*> pointer
_FindFirstOwnedTechnoTypeInVector:
    ; edx becomes the Owner mask
    mov ecx, [esp+4h]; param 1
    mov ecx, [ecx+0C0h]; HouseClass::ActsLike
    mov edx, 1
    shl edx, cl

    push esi
    mov eax, [esp+0Ch]; param 2
    mov ecx, [eax+4h]; VectorClass::Items
    mov eax, [eax+10h]; DynamicVectorClass::Count
    lea esi, [ecx+eax*4]; end
    jmp .LoopEnd

  .LoopStart:
    mov eax, [ecx]
    test [eax+360h], edx; TechnoTypeClass::Owner
    jne .Found
    add ecx, 4

  .LoopEnd:
    cmp ecx, esi
    jne .LoopStart
    xor eax, eax

  .Found:
    pop esi
    ret 08h


; stdcall
; param 1: BuildingClass pointer
_IsBuildConstBuilding:
    mov eax, [esp+4]; param 1
    push DWORD [eax+220h]; BuildingClass::Type
    call _IsBuildConstType
    ret 4


; stdcall
; param 1: BuildingTypeClass pointer
_IsBuildConstType:
    ;pushad
    push ecx
    push edx
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    add ecx, 5B0h; RulesClass::BuildConst
    lea eax, [esp+0Ch]; param 1
    push eax
    mov edx, [ecx]; DynamicVectorClass::vtbl
    call [edx+10h]; DynamicVectorClass::FindItemIndex
    cmp eax, -1
    jz .NoBuildConst
    ;popad
    pop edx
    pop ecx
    mov al, 1
    ret 4
  .NoBuildConst:
    ;popad
    pop edx
    pop ecx
    xor al, al
    ret 4


; stdcall
; param 1: TechnoTypeClass pointer
; param 2: whether the HarvesterUnit's DeploysInto type should be checked
_IsBaseUnitOrDeployed:
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    push ebx
    push esi

    mov bl, BYTE [esp+10h]; param 2
    mov esi, DWORD [esp+0Ch]; param 1

    mov eax, [ecx+760h]; RuleClass::BaseUnit
    test bl, bl
    je .BaseUnitTypeNormal
    mov eax, [eax+274h]; TechnoTypeClass::DeploysInto
  .BaseUnitTypeNormal:
    cmp eax, esi
    je .IsBaseUnit

    mov eax, DWORD [ecx+768h]; RulesClass::HarvesterUnit::Items
    mov ecx, DWORD [ecx+774h]; RulesClass::HarvesterUnit::Count
    lea edx, [eax+ecx*4]
    cmp eax, edx
    je .IsNoBaseUnit

  .LoopStart:
    mov ecx, DWORD [eax]

    ; require Harvester=no
    cmp BYTE [ecx+48Eh], 0; UnitTypeClass::Harvester
    jne .LoopEnd

    ; either use param 1 directly or get the DeploysInto= type
    test bl, bl
    je .TypeNormal

    add ecx, 274h; TechnoTypeClass::DeploysInto
    jmp .TypeEnd

  .TypeNormal:
    mov ecx, eax

  .TypeEnd:
    cmp DWORD [ecx], esi
    je .IsBaseUnit

  .LoopEnd:
    add eax, 4
    cmp eax, edx
    jne .LoopStart

  .IsNoBaseUnit:
    xor al, al
    pop esi
    pop ebx
    ret 08h

  .IsBaseUnit:
    mov al, 1
    pop esi
    pop ebx
    ret 08h


; Register building as ConYard
hack 0x0042AA76
_BuildingClassPutBuildConst:
    push esi; param 1
    call _IsBuildConstBuilding
    test al, al
    jz 0x0042AACF
    jmp 0x0042AA8B


; Remove ConYard building from old owner
hack 0x0042F958
_BuildingClassChangeOwnerBuildConst1:
    push esi; param 1
    call _IsBuildConstBuilding
    test al, al
    jz 0x0042F9A2
    jmp 0x0042F968


; BuildingClassChangeOwnerBuildConst2
@LJMP 0x0042FACC, 0x0042FAEF


; Add ConYard building to new owner
hack 0x0042FCA1
_BuildingClassChangeOwnerBuildConst3:
    push esi; param 1
    call _IsBuildConstBuilding
    test al, al
    jz 0x0042FCF8
    jmp 0x0042FCB6


; Every harvester unit with Harvester Truce enabled is subtracted
hack 0x004BCF3A
_HouseClassUpdateHarvesterUnit1:
    push ebx

    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    mov eax, DWORD [ecx+768h]; RulesClass::HarvesterUnit::Items
    mov ecx, DWORD [ecx+774h]; RulesClass::HarvesterUnit::Count

    lea ecx, [eax+ecx*4]
    cmp eax, ecx
    je .Done

  .LoopStart:
    mov ebx, DWORD [eax]
    cmp BYTE [ebx+48Eh], 0; UnitTypeClass::Harvester
    je .LoopEnd

    mov edx, DWORD [ebx+478h]; UnitTypeClass::ArrayIndex
    cmp edx, DWORD [esi+340h]; HouseClass::OwnedVehicleTypes::Capacity
    jge .LoopEnd

    mov ebx, DWORD [esi+33Ch]; HouseClass::OwnedVehicleTypes::Items
    mov edx, DWORD [ebx+edx*4]
    sub edi, edx

  .LoopEnd:
    add eax, 4
    cmp eax, ecx
    jne .LoopStart

  .Done:
    pop ebx
    jmp 0x004BCF5C


; Special handling when the house's harvester is built, with minor optimization
hack 0x004BD0BC
_HouseClassUpdateHarvesterUnit2:
    mov ecx, [esi+448h]; HouseClass::UnitTypeToProduce
    test ecx, ecx
    js 0x004BD0E5

    mov edx, DWORD [0x0074C488]; RulesClass::Instance
    add edx, 764h; RulesClass::HarvesterUnit
    push 1; param 3
    push edx; param 2
    push esi; param 1
    call _FindFirstOwnedUnitTypeInVector
    mov edx, eax
    mov eax, ecx
    jmp 0x004BD0CF


; Any con yard suffices check to play EVA messages
hack 0x004BCD5D
_HouseClassUpdateBuildConst:
    push ebx
    push edi

    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    mov eax, DWORD [ecx+5B4h]; RulesClass::BuildConst::Items
    mov ecx, DWORD [ecx+5C0h]; RulesClass::BuildConst::Count

    lea edi, [eax+ecx*4]
    cmp eax, edi
    je .NoConYard
    mov ebx, DWORD [esi+370h]; HouseClass::OwnedAndPresentBuildingTypes::Capacity

  .LoopStart:
    mov ecx, [eax]
    mov edx, [ecx+478h]; BuildingTypeClass::ArrayIndex
    cmp edx, ebx
    jge .LoopEnd
    mov ecx, [esi+36Ch]; HouseClass::OwnedAndPresentBuildingTypes::Items
    cmp DWORD [ecx+edx*4], 0
    jg .ConYard

  .LoopEnd:
    add eax, 4
    cmp eax, edi
    jne .LoopStart

  .NoConYard:
    pop edi
    pop ebx
    jmp 0x004BCE0B

  .ConYard:
    pop edi
    pop ebx
    jmp 0x004BCD85


; Support any BuildConst building as Con Yard
hack 0x004C12C1
_HouseClassAIBaseConstructionUpdateBuildConst:
    mov esi, eax; save
    push eax; param 1
    call _IsBuildConstType
    test al, al
    mov eax, esi; restore
    jz 0x004C12D5
    jmp 0x004C1554


; Support any BuildConst building as prereq
hack 0x004C5977
_HouseClassHasPrerequisitesForBuildConst:
    push ecx; param 1
    call _IsBuildConstType
    test al, al
    jnz 0x004C5B62
    jmp 0x004C5985


; Select owned from BuildConst as first building of the base plan
hack 0x004C5E20
_HouseClassGenerateBasePlanBuildConst:
    mov esi, [esp+14h]; this
    mov eax, DWORD [0x0074C488]; RulesClass::Instance
    add eax, 5B0h; RulesClass::BuildConst
    push eax; param 2 vector
    push esi; param 1 house
    call _FindFirstOwnedTechnoTypeInVector
    mov esi, eax
    jmp 0x004C5E28


; Any BuildConst building uses AIIonCannonMCVValue
hack 0x004CA222
_HouseClassFireIonCannonBuildConst:
    mov edx, eax; save
    mov esi, [ecx+274h]; TechnoTypeClass::DeploysInto
    push esi; param 1
    call _IsBuildConstType
    test al, al
    mov eax, edx; restore
    jnz 0x004CA232
    jmp 0x004CA240


hack 0x004CA9A1
_sub4CA880BuildConst:
    mov esi, eax; save
    push ecx; param 1
    call _IsBuildConstBuilding
    test al, al
    mov eax, esi; restore
    jnz 0x004CA9A9
    jmp 0x004CA9B7


; No BuildConst buildings are checked for owner
hack 0x00587BE4
_ObjectTypeClassFindFactoryBuildConst:
    push esi; param 1
    call _IsBuildConstBuilding
    test al, al
    jnz 0x00587BFA
    jmp 0x00587C0B


; Auto deploy units that deploy into a a BuildConst if AutoBaseBuilding is on
; (only if the AI doesn't have a construction yard in non-campaign matches)
hack 0x0064E0D7
_UnitClassUpdateBuildConst:
    mov eax, [edx+274h]; TechnoTypeClass::DeploysInto
    push eax; param 1
    call _IsBuildConstType
    test al, al
    jnz 0x0064E0EC
    jmp 0x0064E134


; Randomly move unit to find a place to deploy
hack 0x00655287
_UnitClassMiHuntBuildConst:
    push eax; param 1
    call _IsBuildConstType
    test al, al
    jnz 0x006552B0
    jmp 0x00655297


; Offset for deployed building placement
hack 0x0065607A
_UnitClassGetCursorOverObjectBuildConst:
    mov edi, eax; save
    push ebp; param 1
    call _IsBuildConstType
    test al, al
    mov eax, edi; restore
    jnz 0x00656084
    jmp 0x006560A3


; Auto deploy units that deploy into a a BuildConst if AutoBaseBuilding is on
hack 0x00656751
_UnitClassMiGuardStickyBuildConst:
    mov edx, [esi+360h]; UnitClass::Type
    mov edx, [edx+274h]; TechnoTypeClass::DeploysInto
    push edx; param 1
    call _IsBuildConstType
    test al, al
    jnz 0x00656770
    jmp 0x006567FD


; Replace BaseUnit with the first non-Harvester a player owns
hack 0x0064D4B0
_UnitClassCTORBaseUnit:
    push ecx; save
    mov eax, [esp+8]; pType
    test eax, eax
    je .Ret

    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    cmp eax, [ecx+760h]; RuleClass::BaseUnit
    jne .Ret

    push 0; param 3 harvester
    lea eax, [ecx+764h]; RulesClass::HarvesterUnit
    push eax; param 2 vector
    push DWORD [esp+14h]; param 1
    call _FindFirstOwnedUnitTypeInVector
    test eax, eax
    je .Ret

    ; replace type
    mov [esp+8], eax

  .Ret:
    pop ecx; restore
    mov eax, [esp+8]
    sub esp, 0Ch
    jmp 0x0064D4B7


; Short Game supports all base units
hack 0x004BCEE7
_HouseClassUpdateBaseUnit:
    push edi; save

    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    mov eax, DWORD [ecx+760h]; RuleClass::BaseUnit
    mov eax, DWORD [eax+478h]; UnitTypeClass::ArrayIndex
    cmp eax, DWORD [esi+340h]; HouseClass::OwnedVehicleTypes::Capacity
    jge .SkipBaseUnit

    mov edi, DWORD [esi+33Ch]; HouseClass::OwnedVehicleTypes::Items
    cmp DWORD [edi+eax*4], 0
    jg .BaseUnit

  .SkipBaseUnit:
    mov eax, DWORD [ecx+768h]; RulesClass::HarvesterUnit::Items
    mov ecx, DWORD [ecx+774h]; RulesClass::HarvesterUnit::Count
    lea edi, [eax+ecx*4]
    cmp eax, edi
    je .NoBaseUnit

  .LoopStart:
    mov ecx, DWORD [eax]

    ; require Harvester=yes
    cmp BYTE [ecx+48Eh], 0; UnitTypeClass::Harvester
    jne .LoopEnd

    mov edx, DWORD [ecx+478h]; UnitTypeClass::ArrayIndex
    cmp edx, DWORD [esi+340h]; HouseClass::OwnedVehicleTypes::Capacity
    jge .LoopEnd

    mov ecx, DWORD [esi+33Ch]; HouseClass::OwnedVehicleTypes::Items
    cmp DWORD [ecx+edx*4], 0
    jg .BaseUnit

  .LoopEnd:
    add eax, 4
    cmp eax, edi
    jne .LoopStart

  .NoBaseUnit:
    pop edi; restore
    jmp 0x004BCF60

  .BaseUnit:
    pop edi; restore
    jmp 0x004BCF6E


; Treat all deployed HarvesterUnits with Harvester=no as ConYards
hack 0x004E985F
_CenterBaseCommandClassExecuteBaseUnit1:
    push 1; param 2 check DeploysInto
    push DWORD [esi+220h]; BuildingClass::Type
    call _IsBaseUnitOrDeployed
    test al, al
    je 0x004E98A5
    jmp 0x004E9879


; Support all HarvesterUnits with Harvester=no as BaseUnit
hack 0x004E9988
_CenterBaseCommandClassExecuteBaseUnit2:
    push 0; param 2 check directly
    push DWORD [esi+360h]; BuildingClass::Type
    call _IsBaseUnitOrDeployed
    test al, al
    jne 0x004E99A8
    jmp 0x004E999C


; Check the house's BaseUnit when deciding whether to give it to the player
hack 0x00457D90
_CellClassCrateCollectedLists1:
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    push ecx
    push 0; param 3
    add ecx, 764h; RulesClass::HarvesterUnit
    push ecx; param 2
    push DWORD [ebx+0ECh]; param 1 TechnoClass::Owner
    call _FindFirstOwnedUnitTypeInVector
    pop ecx
    test eax, eax
    jnz .Ok
    mov eax, [ecx+760h]; RulesClass::BaseUnit
  .Ok:
    jmp 0x00457D9C


; Check house specific BuildRefinery and HarvesterUnit when deciding whether to
; give harvester
hack 0x00458148
_CellClassCrateCollectedLists2:
    push eax
    add eax, 764h; RulesClass::HarvesterUnit
    push 1; param 3
    push eax; param 2
    push DWORD [ebx+0ECh]; param 1 TechnoClass::Owner
    call _FindFirstOwnedUnitTypeInVector
    mov [AlexB_HarvesterUnit], eax
    pop eax
    add eax, 5E8h; RulesClass::BuildRefinery
    push eax
    push DWORD [ebx+0ECh]; param 1 TechnoClass::Owner
    call _FindFirstOwnedTechnoTypeInVector
    jmp 0x00458150


@SET 0x00458172, {lea eax, [AlexB_HarvesterUnit]}
@SET 0x0045819B, {lea ecx, [AlexB_HarvesterUnit]}


; If the type is Harvester=no, do not apply Harvester Truce
hack 0x0045F3F4
_DamageArea2HarvesterUnit:
    cmp BYTE [eax+48Eh], 0; UnitTypeClass::Harvester
    jz 0x0045F41C
    mov esi, DWORD [0x0074C488]; RulesClass::Instance
    jmp 0x0045F3FA


; Count the harvesters of the house
hack 0x004A7A45
_TechnoClassFindTiberiumCloseHarvesterUnit:
    push ecx
    push 1; param 3
    add ecx, 764h; RulesClass::HarvesterUnit
    push ecx; param 2
    mov ecx, [edi+0ECh]; TechnoClass::Owner
    push ecx; param 1
    call _FindFirstOwnedUnitTypeInVector
    pop ecx
    test eax, eax
    jnz .Done
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    add ecx, 768h; RulesClass::HarvesterUnit::Items
    mov eax, [ecx]
  .Done:
    jmp 0x004A7A4D


; All harvesters are immune to Vehicle Thieves in Harvester Truce
; (fixes original bug: logic checked unit pointer, not type pointer)
hack 0x004D7284
_InfantryClassGetCursorOverObjectHarvesterUnit:
    mov edx, [esi]; UnitClass::vtbl
    mov ecx, esi
    call [edx+88h]; ObjectClass::GetType
    push eax
    mov edx, [esi]; UnitClass::vtbl
    mov ecx, esi
    call [edx+2Ch]; ObjectClass::WhatAmI
    cmp eax, 1
    pop esi; this fixes the bug
    jnz .NoHarv
    cmp BYTE [esi+48Eh], 0; UnitTypeClass::Harvester
    jz .NoHarv
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    jmp 0x004D728A
  .NoHarv:
    jmp 0x004D7258


; Only check Harvester=yes units for Harvester Truce
hack 0x0062D30D
_TechnoClassCanAutoTargetObjectHarvesterUnit:
    mov ebp, eax
    mov edx, [esi]; UnitClass::vtbl
    mov ecx, esi
    call [edx+2Ch]; ObjectClass::WhatAmI
    cmp eax, 1
    mov eax, ebp
    jnz .NoHarv
    cmp BYTE [eax+48Eh], 0; UnitTypeClass::Harvester
    jz .NoHarv
    mov ebp, DWORD [0x0074C488]; RulesClass::Instance
    jmp 0x0062D313
 .NoHarv:
    jmp 0x0062D336


; Only send Harvester=yes units on Harvest mission
hack 0x0062F0C8
_TechnoClassUpdateHarvesterUnit:
    xor edx, edx
    mov ebp, [edi+360h]; UnitClass::Type
    cmp BYTE [ebp+48Eh], 0; UnitTypeClass::Harvester
    jz .NoHarv
    mov edx, [ecx+774h]; RulesClass::HarvesterUnit::Count
  .NoHarv:
    jmp 0x0062F0CE


; Prevent limpets from attaching to harvesters with Harvester Truce on
hack 0x0064FA91
_UnitClassReceiveDamageHarvesterUnit:
    xor edx, edx
    mov edi, [esi+360h]; UnitClass::Type
    cmp BYTE [edi+48Eh], 0; UnitTypeClass::Harvester
    jz .NoHarv
    mov edx, [ecx+774h]; RulesClass::HarvesterUnit::Count
  .NoHarv:
    jmp 0x0064FA97


; Support all BuildWeapons, and the house's BuildRefinery and HarvesterUnit
hack 0x004C0D0C
_sub4C0CF0Lists1:
    ;push ebx
    push ebp
    ;push edi
    xor bl, bl
    mov edi, DWORD [0x0074C488]; RulesClass::Instance
    lea eax, [edi+5E8h]; RulesClass::BuildRefinery
    push eax; param 2
    push esi; param 1
    call _FindFirstOwnedTechnoTypeInVector
    mov [AlexB_BuildRefinery], eax
    mov ebp, eax
    mov eax, [ebp+478h]; BuildingTypeClass::ArrayIndex
    cmp eax, DWORD [esi+370h]; RulesClass::OwnedAndPresentBuildingTypes::Capacity
    jge .InvalidBuildRefinery
    mov ecx, [esi+36Ch]; RulesClass::OwnedAndPresentBuildingTypes::Items
    mov ecx, [ecx+eax*4]
    jmp .CheckBuildRefinery
  .InvalidBuildRefinery:
    xor ecx, ecx
  .CheckBuildRefinery:
    test ecx, ecx
    jg .HasBuildRefinery
    mov bl, 1
    jmp .Done
  .HasBuildRefinery:
    mov ecx, [edi+640h]; RulesClass::BuildWeapons::Items
    mov eax, [edi+64Ch]; RulesClass::BuildWeapons::Capacity
    lea edi, [ecx+eax*4]
    cmp ecx, edi
    je .HasNoBuildWeapons
    mov bl, 1
  .LoopStart:
    mov eax, [ecx]
    mov edx, [eax+478h]; BuildingTypeClass::ArrayIndex
    cmp edx, DWORD [esi+370h]; RulesClass::OwnedAndPresentBuildingTypes::Capacity
    jge .InvalidBuildWeapons
    mov eax, [esi+36Ch]; RulesClass::OwnedAndPresentBuildingTypes::Items
    mov eax, [eax+edx*4]
    jmp .CheckBuildWeapons
  .InvalidBuildWeapons:
    xor eax, eax
  .CheckBuildWeapons:
    test eax, eax
    jg .HasBuildWeapons
    add ecx, 4
    cmp ecx, edi
    jne .LoopStart
    jmp .Done
  .HasBuildWeapons:
    xor bl, bl
  .HasNoBuildWeapons:
    push 1; param 3 harvester
    mov edi, DWORD [0x0074C488]; RulesClass::Instance
    lea eax, [edi+764h]; RulesClass::HarvesterUnit
    push eax; param 2
    push esi; param 1
    call _FindFirstOwnedUnitTypeInVector
    mov [AlexB_HarvesterUnit], eax
    mov ebp, eax
  .Done:
    xor bl, 1
    mov BYTE [esp+17h], bl
    mov ecx, ebp
    ;pop edi
    pop ebp
    ;pop ebx
    jmp 0x004C0D8B


@SET 0x004C0F64, {lea ecx, [AlexB_HarvesterUnit]}
@SET 0x004C0FB5, {lea edx, [AlexB_BuildRefinery]}
@SET 0x004C1056, {lea ecx, [AlexB_BuildRefinery]}


; Use the BuildRefinery for this house
hack 0x004C0A7E
_sub4C0A40Lists1:
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    lea ecx, [ecx+5E8h]; RulesClass::BuildRefinery
    push ecx; param 2
    push ebx; param 1
    call _FindFirstOwnedTechnoTypeInVector
    mov [AlexB_BuildRefinery], eax
    mov edx, eax
    jmp 0x004C0A8B


; Use the HarvesterUnit for this house
hack 0x004C0AE9
_sub4C0A40Lists2:
    mov ecx, DWORD [0x0074C488]; RulesClass::Instance
    lea ecx, [ecx+764h]; RulesClass::HarvesterUnit
    push 1; param 3
    push ecx; param 2
    push ebx; param 1
    call _FindFirstOwnedUnitTypeInVector
    mov [AlexB_HarvesterUnit], eax
    mov ecx, eax
    mov eax, [ebx+448h]; HouseClass::UnitTypeToProduce
    jmp 0x004C0AFD


@SET 0x004C0ACD, {lea edi, [AlexB_BuildRefinery]}
@SET 0x004C0BE0, {lea ecx, [AlexB_BuildRefinery]}
@SET 0x004C0C66, {lea ecx, [AlexB_BuildRefinery]}
@SET 0x004C0B7B, {lea edx, [AlexB_HarvesterUnit]}


; Use the BuildRefinery and HarvesterUnit for this house
hack 0x004BAEE3
_sub4BAED0Lists1:
    push eax
    mov edx, DWORD [0x0074C488]; RulesClass::Instance
    push edx
    lea ebp, [edx+764h]; RulesClass::HarvesterUnit
    push 1; param 3
    push ebp; param 2
    push esi; param 1
    call _FindFirstOwnedUnitTypeInVector
    mov [AlexB_HarvesterUnit], eax
    pop edx
    lea ebp, [edx+5E8h]; RulesClass::BuildRefinery
    push ebp; param 2
    push esi; param 1
    call _FindFirstOwnedTechnoTypeInVector
    mov [AlexB_BuildRefinery], eax
    pop eax
    jmp 0x004BAEE9


; Use the BuildWeapons for this house
hack 0x004BAFCA
_sub4BAED0Lists2:
    ; edx, ebp
    mov edx, DWORD [0x0074C488]; RulesClass::Instance
    lea edx, [edx+63Ch]; RulesClass::BuildWeapons
    push edx; param 2
    push esi; param 1
    call _FindFirstOwnedTechnoTypeInVector
    mov ecx, eax
    push esi; recreated
    jmp 0x004BAFD3


@SET 0x004BAEF0, {lea eax, [AlexB_BuildRefinery]}
@SET 0x004BAF0A, {lea ecx, [AlexB_HarvesterUnit]}
@SET 0x004BAF29, {lea ecx, [AlexB_BuildRefinery]}
@SET 0x004BAF47, {lea edx, [AlexB_HarvesterUnit]}


; Support full BuildRefinery and HarvesterUnit for rebuilding harvesters
hack 0x004C166D
_HouseClassAIUnitProductionLists:
    mov edx, DWORD [0x0074C488]; RulesClass::Instance
    push edx;
    lea eax, [edx+5E8h]; RulesClass::BuildRefinery
    push eax; param 2
    push ebp; param 1
    call _FindFirstOwnedTechnoTypeInVector
    mov [AlexB_BuildRefinery], eax
    pop edx
    lea eax, [edx+764h]; RulesClass::HarvesterUnit
    push 1; param 3 harvester
    push eax; param 2 DynamicVectorClass<UnitTypeClass*>*
    push ebp; param 1 HouseClass*
    call _FindFirstOwnedUnitTypeInVector
    mov [AlexB_HarvesterUnit], eax
    mov edx, eax
    jmp 0x004C167A

@SET 0x004C1694, {lea edx, [AlexB_BuildRefinery]}
@SET 0x004C1710, {lea edx, [AlexB_HarvesterUnit]}
