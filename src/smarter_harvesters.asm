%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Improves the harvester AI in multiple ways.
; - Harvesters now prefer queuing for occupied refineries instead of heading
;   for free refineries if the free refineries are very far away and the
;   occupied refineries are close.
; - Harvesters no longer discriminate against Dock= buildings that are
;   specified last on the list.
; - Refineries now allow harvesters close to them to dock even if
;   they have been reserved by distant harvesters (this feature is
;   also known as queue jumping)
;
; ***********************************
; Author: Rampastring

; Dock building object pointers and distances
gint ClosestFreeRefinery, 0
gint ClosestFreeRefineryDistance, 0
gint ClosestPossiblyOccupiedRefinery, 0
gint ClosestPossiblyOccupiedRefineryDistance, 0


; UnitClass::Mission_Harvest, case FINDHOME
hack 0x00654EEE
    xor  eax, eax
    mov  [ClosestFreeRefinery], eax
    mov  [ClosestFreeRefineryDistance], eax
    mov  [ClosestPossiblyOccupiedRefinery], eax
    mov  [ClosestPossiblyOccupiedRefineryDistance], eax
    
    ; I'm not sure what these two instructions are for in the original code,
    ; have to see if not having that check will lead to problems later,
    ; but currently it seems doubtful because we replace the 0x00654F49
    ; logic as well
    ;cmp [ecx+268h], ebp
    ;jle 0x00654F49
    
    ; Check for free refineries
    push ClosestFreeRefineryDistance
    push ClosestFreeRefinery
    call Find_Closest_Refinery
    
    ; Check for non-free refineries - the game includes reserved refineries
    ; if ScenarioInit > 0
    mov eax, [ScenarioInit]
    inc eax
    mov [ScenarioInit], eax
    push ClosestPossiblyOccupiedRefineryDistance
    push ClosestPossiblyOccupiedRefinery
    call Find_Closest_Refinery
    mov eax, [ScenarioInit]
    dec eax
    mov [ScenarioInit], eax
    
    mov  eax, [ClosestFreeRefinery]
    cmp  eax, 0 ; ClosestFreeRefinery != NULL
    je   .Else
    cmp  eax, [ClosestPossiblyOccupiedRefinery] ; ClosestFreeRefinery == ClosestPossiblyOccupiedRefinery
    ; If the closest free refinery is truly the closest refinery, use it
    je   .Radio_Contact_Check
    ; If it's not the closest refinery, compare the distance between the refineries
    ; I have no idea about the units, but a suitable one can probably be found
    ; through trial-and-error.
    mov  eax, [ClosestPossiblyOccupiedRefineryDistance]
    add  eax, 1660000h ; Only prefer the free refinery if it's not farther
                       ; than 1660000h distance units away from the occupied refinery
    cmp  eax, [ClosestFreeRefineryDistance]
    jl   .Else
    
    
.Radio_Contact_Check:    
    ; If we got this far, then we want to contact the closest free refinery
    mov  edx, [esi]
    mov  eax, [ClosestFreeRefinery]
    push eax
    push 2 ; RADIO_HELLO
    mov  ecx, esi
    call dword [edx+218h] ; RadioClass::Transmit_Message
    cmp  eax, 1           ; Did the refinery reply with RADIO_ROGER?
    jne .Else
    ; The refinery accepted us, change status to HEADINGHOME and jump to original code (default case)
    mov  dword [esi+58h], 3 ; 3 = HEADINGHOME
    jmp 0x00655226
      
.Else:
    ; There was no free refinery, or if there was, it was so far away that it's
    ; a better idea to queue for a closer occupied refinery.
    ; Or there was a free refinery close, but it didn't like our radio message
    ; for some reason.
    mov  eax, [ClosestPossiblyOccupiedRefinery]
    cmp  eax, 0
    je   0x00655226 ; no refinery actually existed at all!
    ; Jump to original code, presumably telling the harvester to move near
    ; the occupied refinery
    ; The original code assumes edi to have a pointer to the refinery
    mov  edi, eax
    jmp  0x00654FAA
    
   

   

; Function, takes two args: pointer to variable containing closest refinery,
; and pointer to variable containing the distance to the closest refinery
Find_Closest_Refinery:
    push ebx
    push edx
    push ebp
    mov  ebx, [esp+0Ch+4]
    
    mov  ecx, [esi+360h]
    xor  edi, edi
    xor  ebp, ebp
    
    ; Start of loop for seeking free refineries
    ; Loops through BuildingTypes specified in the harvester's Dock= 
.Loop_Start:
    mov  eax, [ecx+25Ch]
    push 0 ; the original had push ebp, but ebp was always 0 there
    push 0
    mov  ecx, [eax+edi*4]
    push ecx
    mov  ecx, esi
    mov  eax, [esi]
    call dword [eax+284h] ; this->Find_Docking_Bay
    cmp  eax, 0
    jne  .Check_Potential_Refinery
    ; The given dock building wasn't found, continue loop
    jmp  .Loop_Continue_Check
    
.Check_Potential_Refinery:
    mov  ebp, eax ; Save refinery pointer
    ; Get refinery distance
    push eax
    mov  ecx, esi
    call 0x00586CC0       ; ObjectClass::Get_XY_Distance_From
    
    mov  edx, [esp+0Ch+8] ; Fetch previous distance to best refinery
                          ; for future comparison and assignment
    
    ; Have we already found a refinery before?
    cmp  dword [ebx], 0
    je   .Assign_Best_Refinery
    
    ; If yes, then we should compare the distance
    ; between the old and new refineries
    cmp  eax, [edx]
    jl   .Assign_Best_Refinery
    jmp  .Loop_Continue_Check
    
.Assign_Best_Refinery:
    ; Update best refinery pointer, the address of which resides in ebx
    ; and distance variable, the address of which has been loaded to edx
    mov  [ebx], ebp
    mov  [edx], eax
    
.Loop_Continue_Check:
    xor  ebp, ebp
    mov  ecx, [esi+360h] ; Get UnitTypeClass instance
    inc  edi
    cmp  edi, [ecx+268h] ; Count of buildings specified in Dock=
    jl  .Loop_Start ; Jump if not all dock buildings have been checked for yet
    jmp .Loop_End

.Loop_End:
    mov  eax, 0 ; return 0, this function modifies the values behind the 
                ; pointer variables that it takes as arguments
    pop  ebp
    pop  edx
    pop  ebx
    retn 8h


; *****************************************************************************
; Queue jumping code starts here

gint OldHarvDistance, 0

; Hack BuildingClass::Receive_Message
; Skip check for returning RADIO_NEGATIVE if 
; (!ScenarioInit && In_Radio_Contact() && Contact_With_Whom() != from) for refineries
;hack 0x0042694A
;    cmp dword [SessionType], 0 ; GAME_NORMAL (aka campaign)
;    je .Singleplayer
;    
;    cmp dword [SessionType], 5 ; GAME_SKIRMISH
;    je .Singleplayer
;    
;    ; DO NOT run .Singleplayer code in multiplayer, it causes desyncs!
;    ; dropping of the old harvester is not synchronized between machines!
;    jmp .Original_Behaviour
;
;.Singleplayer:
;    mov  ecx, esi
;    mov  eax, [ecx+0x220] ; get BuildingTypeClass instance
;    mov  al,  [eax+81Bh]  ; BuildingTypeClass.Refinery
;    cmp  al, 0
;    jz   .Original_Behaviour
;    jmp  0x0042697B ; Skip check
;    
;.Original_Behaviour:
;    mov  eax, [ScenarioInit]
;    test eax, eax
;    jnz  0x00426962
;    mov  eax, [esi+78h] ; Get object in radio contact
;    test eax, eax
;    jz   0x00426962
;    cmp  eax, edi
;    jnz  0x00426BFD
;    jmp  0x00426962
;
;
;    
;
;; Queue jumping, part 2
;; Hack refinery-specific code in BuildingClass::Receive_Message
;hack 0x00426A71
;    mov  eax, [ScenarioInit]
;    test eax, eax
;    jnz  0x0042707B ; Return RADIO_ROGER if ScenarioInit is set
;    
;    mov  eax, [esi+04Ah] ; Is_Something_Attached
;    test eax, eax
;    jnz  .Cont
;    
;    ; We're not free, ghost them by returning RADIO_STATIC
;    pop  edi
;    pop  esi
;    pop  ebx
;    mov  eax, 0
;    pop  ebx
;    add  esp, 44h
;    retn 0Ch
;    
;.Cont:
;    ; Clear old memory
;    xor  eax, eax
;    mov  [OldHarvDistance], eax
;
;    ; Get object we're in radio contact with
;    mov  eax, [esi+78h]
;    test eax, eax
;    jz   .Return_OK
;    
;    cmp dword [SessionType], 0 ; GAME_NORMAL (aka campaign)
;    je .Singleplayer
;    
;    cmp dword [SessionType], 5 ; GAME_SKIRMISH
;    je .Singleplayer
;    
;    ; DO NOT run .Singleplayer code in multiplayer, it causes desyncs!
;    ; dropping of the old harvester is not synchronized between machines!
;    jmp .Return_Negative
;
;.Singleplayer
;    
;    mov  ebx, eax ; Save reference to ebx
;    
;    ; Get distance to object we're in contact with
;    mov  ecx, esi         ; "this" pointer
;    push eax              ; Pointer to object in contact
;    call 0x00586CC0       ; ObjectClass::Get_XY_Distance_From
;    
;    mov  [OldHarvDistance], eax
;    
;    mov  ecx, esi         ; "this" pointer
;    push edi              ; Pointer to object who sent us the radio message
;    call 0x00586CC0       ; ObjectClass::Get_XY_Distance_From
;    
;    add  eax, 1660000h    ; "random" value, as before
;    cmp  eax, [OldHarvDistance]
;    jge  .Return_Negative
;    
;    ; Drop the old harvester and return RADIO_ROGER
;    mov  edx, [esi]
;    push ebx          ; old harvester
;    push 3            ; RADIO_OVER_OUT (hopefully so also in TS)
;    mov  ecx, esi
;    call dword [edx+218h] ; RadioClass::Transmit_Message
;    jmp .Return_OK
;    
;.Return_Negative:
;    jmp 0x0042696C  ; Returns RADIO_NEGATIVE and exits the function properly as specified by the calling convention
;
;.Return_OK:
;    jmp 0x004269BD  ; Returns RADIO_ROGER and exits the function properly as specified by the calling convention


; Hack FootClass::Mission_Enter to make harvesters seek for a new refinery to
; unload into when their existing refinery dumps them
hack 0x004A49A3
    mov  edx, [esi]
    mov  ecx, esi
    call [edx+2Ch] ; What_Am_I()
    cmp  eax, 1    ; RTTI_UNIT
    je   .Check_For_Harvester
    jmp  .Original_Code
    
.Check_For_Harvester:
    mov  edx, esi
    mov  eax, [edx+360h] ; UnitClass->Class
    mov  cl, [eax+48Eh]  ; UnitTypeClass.Harvester
    test cl, cl
    je   .Original_Code
    
    ; We're a harvester, try to find a new refinery instead of going idle
    mov  eax, [esi]       ; UnitClass::vtbl
    mov  ecx, esi         ; Unit pointer
    push 9                ; MISSION_HARVEST
    call dword [eax+158h] ; MissionClass::Assign_Mission
    jmp 0x004A49B1
    
.Original_Code:
    ; Replace instructions that our jump destroyed
    mov  edx, [esi]
    push 1
    push 0
    mov  ecx, esi
    call dword [edx+354h] ; Enter_Idle_Mode
    jmp  0x004A49B1

