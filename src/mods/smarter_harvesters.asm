%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Improves the harvester AI.
; Harvesters now prefer queuing for occupied refineries instead of heading
; for free refineries if the free refineries are very far away and the
; occupied refineries are close.
; Also, harvesters no longer discriminate against Dock= buildings that are
; specified last on the list.
; *******************
; Author: Rampastring

; Dock building object pointers
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
    cmp  eax, 1            ; Did the refinery reply with RADIO_ROGER?
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
    ; Have we already found a refinery before?
    cmp  dword [ebx], 0
    je   .Assign_Best_Refinery
    ; If yes, then we should compare the distance
    ; between the old and new refineries
    push eax
    mov  ecx, esi
    call 0x00586CC0       ; ObjectClass::Get_XY_Distance_From
    mov  edx, [esp+0Ch+8] ; Fetch previous distance
    cmp  eax, [edx]
    jl   .Assign_Best_Refinery
    jmp  .Loop_Continue_Check
    
.Assign_Best_Refinery:
    mov  [ebx], ebp
    push eax
    mov  ecx, esi
    call 0x00586CC0       ; ObjectClass::Get_XY_Distance_From
    mov  edx, [esp+0Ch+8] ; Fetch distance variable for updating
    mov  [edx], eax
    
.Loop_Continue_Check:
    xor  ebp, ebp
    mov  ecx, [esi+360h]    
    inc  edi
    cmp  edi, [ecx+268h]
    jl  .Loop_Start ; Jump if not all dock buildings have been checked for yet
    jmp .Loop_End

.Loop_End:
    mov  eax, [ebx]
    pop  ebp
    pop  edx
    pop  ebx
    retn 8h

