%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Hacks the AI so that when it enters fire-sale mode, it does not automatically sell
; all of its buildings if Short Game is enabled. Instead the AI checks if it has
; enough units left for doing an effective full charge. If it does, then it sells
; everything else, but leaves a single building standing to avoid getting defeated
; right away. If the AI does not have a significant number of units left, then
; it behaves as usual and sells everything.
; *******************
; Author: Rampastring


cextern LeaveABuilding
cextern ObjectCount

; don't push esi here, we do it in our hack code
@SET 0x004C3464, nop


; Hack beginning of HouseClass::IHouse::Fire_Sale to calculate our object count
hack 0x004C345B
    ; Return from the function if CurBuildings <= 0, re-implements code that we destroyed in the jump
    test eax, eax
    jle  0x004C34AD 

    push esi
    
    xor  eax, eax
    mov  [LeaveABuilding], al
    
    mov  al, [ShortGame]
    cmp  al, 1
    jmp  .Calculate_Object_Count 

.Original_Code:
    ; Short Game is disabled or we have too few units for them to form a respectable threat,
    ; go to regular fire-sale mode and sell everything
    mov  eax, [DynamicVectorClass_BuildingClass_ActiveCount]
    jmp  0x004C3465

.Calculate_Object_Count:
    ; Initialize object count to 0
    xor  eax, eax
    mov  [ObjectCount], eax
    
    ; Loop through units (vehicles), infantry and buildings and calculate their count,
    ; check if we still have enough forces available for attacking
    
    
    ; *************************************************************************
    ; Units
    ; *************************************************************************
    mov  eax, [UnitClassArray_Count]
    xor  esi, esi
    test eax, eax
    jle  .Check_Infantry
    
.Unit_Loop_Begin:
    mov  eax, [DynamicVectorClass_UnitClass_Array]
    mov  ecx, [eax+esi*4]
    test ecx, ecx
    jz   .Increment_Unit_Loop
    mov  al, [ecx+2Fh]   ; IsInLimbo?
    test al, al
    jnz  .Increment_Unit_Loop
    mov  eax, [ecx+0ECh] ; Owner
    lea  edx, [edi-14h]
    cmp  eax, edx
    jnz  .Increment_Unit_Loop
    ; Check Strength? if it resides at 0x28 for non-buildings as well
    ;mov  eax, [ecx+28h] ; Strength
    ;test eax, eax
    ;jle  .Increment_Unit_Loop
    
    mov  eax, [ObjectCount]
    inc  eax
    mov  [ObjectCount], eax
    
.Increment_Unit_Loop:
    mov  eax, [UnitClassArray_Count]
    inc  esi
    cmp  esi, eax
    jl   .Unit_Loop_Begin

    
    ; *************************************************************************
    ; Infantry
    ; *************************************************************************
.Check_Infantry:
    mov  eax, [DynamicVectorClass_InfantryClass_ActiveCount]
    xor  esi, esi
    test eax, eax
    jle  .Check_Buildings
    
.Infantry_Loop_Begin:
    mov  eax, [DynamicVectorClass_InfantryClass_Array]
    mov  ecx, [eax+esi*4]
    test ecx, ecx
    jz   .Increment_Infantry_Loop
    mov  al, [ecx+2Fh]   ; IsInLimbo?
    test al, al
    jnz  .Increment_Infantry_Loop
    mov  eax, [ecx+0ECh] ; Owner
    lea  edx, [edi-14h]
    cmp  eax, edx
    jnz  .Increment_Infantry_Loop
    ; Check Strength? if it resides at 0x28 for non-buildings as well
    ;mov  eax, [ecx+28h] ; Strength
    ;test eax, eax
    ;jle  .Increment_Infantry_Loop
    
    mov  eax, [ObjectCount]
    inc  eax
    mov  [ObjectCount], eax
    
.Increment_Infantry_Loop:
    mov  eax, [DynamicVectorClass_InfantryClass_ActiveCount]
    inc  esi
    cmp  esi, eax
    jl   .Infantry_Loop_Begin
    
    ; *************************************************************************
    ; Buildings
    ; *************************************************************************
.Check_Buildings:
    mov  eax, [DynamicVectorClass_BuildingClass_ActiveCount]
    xor  esi, esi
    test eax, eax
    jle  .Check_Object_Count
    
.Building_Loop_Begin:
    mov  eax, [DynamicVectorClass_BuildingClass_Array]
    mov  ecx, [eax+esi*4]
    test ecx, ecx
    jz   .Increment_Buildings_Loop
    mov  al, [ecx+2Fh]   ; IsInLimbo?
    test al, al
    jnz  .Increment_Buildings_Loop
    mov  eax, [ecx+0ECh] ; Owner
    lea  edx, [edi-14h]
    cmp  eax, edx
    jnz  .Increment_Buildings_Loop
    mov  eax, [ecx+28h] ; Strength
    test eax, eax
    jle  .Increment_Buildings_Loop
    ; TODO check that the building is crewed
    
    mov  eax, [ObjectCount]
    inc  eax ; Usually you get more than 1 infantry from selling buildings
    inc  eax
    mov  [ObjectCount], eax
    
.Increment_Buildings_Loop:
    mov  eax, [DynamicVectorClass_BuildingClass_ActiveCount]
    inc  esi
    cmp  esi, eax
    jl   .Building_Loop_Begin

.Check_Object_Count:
    mov  eax, [ObjectCount]
    ; 8 = Object count threshold, if we have at least this many objects then we
    ;     shouldn't surrender entirely, but leave a building standing
    cmp  eax, 8 
    jl   .FireSale
    mov  al, 1
    mov  [LeaveABuilding], al
    
.FireSale:
    jmp .Original_Code


; Hack a later part of HouseClass::IHouse::Fire_Sale to skip selling 
; a building if we have enough objects left for them to be a formidable threat
hack 0x004C3492
    mov  al, [LeaveABuilding]
    cmp  al, 1
    jl  .Sell_Building
    ; We skipped selling a building, we can set LeaveABuilding=false
    ; and still have 1 building left after selling everything else
    xor  al, al
    mov  [LeaveABuilding], al
    jmp  0x004C349C       ; index++ and for loop condition check
    
    
.Sell_Building:
    mov  eax, [ecx]
    push 1
    call dword [eax+170h] ; BuildingClass::Sell_Back
    jmp  0x004C349C       ; index++ and for loop condition check



    
    