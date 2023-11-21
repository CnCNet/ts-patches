%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cextern UsedSpawnsArray

sstring str_Hard, "Difficulty: Hard"
sstring str_Medium, "Difficulty: Medium"
sstring str_Easy, "Difficulty: Easy"

; 0x40 = first parameter, 0x24 = second parameter, 0x28, third parameter, 0x2C = fourth parameter, 0x30 = fifth parameter
; the trigger action type should be 0 (as set map INI) for the extended triggers added, determines how the rest of the
; INI line is read for the rest of the trigger
; [Actions] 01000000=1,7,1,01000005,0,0,0,0,A
; [Actions] TRIGGER_ACTION_ID=AMOUNT_OF_ACTIONS,TRIGGER_ACTION_ID,TRIGGER_ACTION_TYPE,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,WAYPOINT_LETTER(?)
@LJMP 0x006198C7, _Trigger_Action_Extend_Change_House

_Trigger_Action_Extend_Change_House:
    mov eax, ecx
    call Spawn_Index50_To_House_Pointer

    cmp eax, -1 ; no house associated with spawn, skip changing house
    jz .Ret_Function

    cmp eax, 0
    jnz .Ret ; HouseClass pointer associated with spawn location, return this pointer

    ; normal code
    call 0x004C4730 ; House_Pointer_From_HouseType_Index

.Ret:
    jmp 0x006198CC

.Ret_Function:
    mov al, 1
    jmp 0x006198E3


; input eax = Spawn index with value 50 for Spawn1, 51 for Spawn2 etc
; output HouseClass pointer associated with that spawn, 0 if not a valid index or -1 if no HouseClass is associated with spawn location
Spawn_Index50_To_House_Pointer:
    push edi
    push edx

    cmp eax, 50
    jl  .Return_Zero
    cmp eax, 60
    jg  .Return_Zero

    sub eax, 50

    mov eax, [UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Ret

    mov edi, [HouseClassArray_Vector]
    mov eax, [edi+eax*4]

    jmp .Ret

.Return_Zero:
    mov eax, 0

.Ret:
    pop edx
    pop edi
    retn


; Function. Silently deletes all objects that have a tag that is attached to a trigger.
; Takes a pointer to TriggerClass instance in eax.
TAction_Remove_Object:
    push ebx
    push ebp
    push esi
    push edi

    xor  edx, edx
    mov  ebx, eax ; Store TriggerClass pointer in ebx

.Loop_Begin:
    mov  eax, [0x007E4830] ; DynamicVectorClass<TechnoClass>.ActiveCount
    test eax, eax
    jle  .out

    xor  ebp, ebp
    xor  edi, edi

.Loop_Body:
    mov  eax, [0x007E4824]    ; DynamicVectorClass<TechnoClass>.Vector
    mov  esi, [eax+edi*4]     ; Fetch object instance from vector
    mov  al, byte [esi+35h]   ; ObjectClass.IsActive
    test al, al
    jz   .Loop_End
    mov  al, byte [esi+2Ch]   ; ObjectClass.IsDown
    test al, al
    jz   .Loop_End
    mov  al, byte [esi+2Fh]   ; ObjectClass.IsInLimbo
    test al, al
    jnz  .Loop_End
    mov  ecx, dword [esi+24h] ; ObjectClass.Tag
    test ecx, ecx
    jz   .Loop_End
    push ebx
    call 0x0061E860           ; TagClass_IsAttachedToTrigger
                              ; "this" parameter is already in ecx because we moved the tag to ecx earlier
    test al, al
    jz   .Loop_End

    ; Tag matches, remove object from the game world
    mov  ecx, esi          ; "this" ptr
    mov  eax, [esi]        ; vtable
    call dword [eax+0xE4]  ; Delete this game object

    dec  edi         ; decrease index variable

    mov  ebp, 1      ; mark that we destroyed something, will cause another iteration of the entire loop
                     ; Westwood also did this in their TAction_Destroy_Object code, not sure why though

    mov  edx, 1      ; we use edx as return value. 1 = we removed something, 0 = we couldn't find anything to remove

.Loop_End:
    mov  eax, [0x007E4830] ; DynamicVectorClass<TechnoClass>.ActiveCount
    inc  edi
    cmp  edi, eax
    jl   .Loop_Body
    test ebp, ebp
    jne  .Loop_Begin

.out:
    mov  eax, edx
    pop  edi
    pop  esi
    pop  ebp
    pop  ebx
    retn


; New actions
    
hack 0x0061913B ; Extend trigger action jump table
    cmp edx, 105
    jz .Give_Credits_Action
    cmp edx, 106
    jz .Enable_ShortGame_Action
    cmp edx, 107
    jz .Disable_ShortGame_Action
    cmp edx, 108
    jz .Print_Difficulty_Action
    cmp edx, 109
    jz .Blow_Up_House_Action
    cmp edx, 110
    jz .Make_Attached_Objects_Elite
    cmp edx, 111
    jz .Enable_AllyReveal_Action
    cmp edx, 112
    jz .Disable_AllyReveal_Action
    cmp edx, 113
    jz .Create_AutoSave_Action
    cmp edx, 114
    jz .Remove_Attached_Objects_Action

    cmp edx, 68h
    ja 0x0061A9C5 ; default
    jmp 0x00619141 ; use original switch jump table
    
; New actions below

; ********************
; *** Give credits ***
; ********************
.Give_Credits_Action:
    mov eax, [esi+40h] ; first parameter
    
    cmp eax, 50
    jl .Get_House_Pointer ; give credits to a regular house instead of a SpawnX house
    
    call Spawn_Index50_To_House_Pointer
    
    cmp eax, -1 ; no house associated with spawn location
    jz .Out

    cmp eax, 0
    jnz .Give_Credits
    
.Get_House_Pointer:    
    call 0x004C4730 ; House_Pointer_From_HouseType_Index
    
.Give_Credits:
    ; At this point we should have the house pointer in EAX
    mov ebx, [esi+24h] ; second parameter, number of credits to give
    mov ecx, [eax+1A4h] ; move current number of credits to ecx
    add ecx, ebx
    mov [eax+1A4h], ecx
    
.Out:
    jmp 0x0061A9C5 ; default
    
; **********************************
; *** Enable / disable ShortGame ***
; **********************************
.Enable_ShortGame_Action:
    mov byte [ShortGame], 1
    jmp 0x0061A9C5 ; default

.Disable_ShortGame_Action:
    mov byte [ShortGame], 0
    jmp 0x0061A9C5

; ******************************
; *** Print Difficulty Level ***
; ******************************
    
    ; arg: pointer to message
%macro Print_Message 1
    ; Calculate message duration
    mov eax, [Rules]
    fld qword [eax+0C68h]   ; Message duration in minutes
    fmul qword [0x006CB1B8] ; Frames Per Minute
    call Get_Message_Delay_Or_Duration ; Float to int

    ; Push arguments
    push eax                ; Message delay/duration
    push 4046h              ; Very likely TextPrintType
    mov ecx, MessageListClass_this
    push 4
    lea edx, [%1]
    push edx
    push 0
    push 0
    call MessageListClass__Add_Message
%endmacro
   
.Print_Difficulty_Action:
    mov eax, dword [SelectedDifficulty]

    cmp eax, 2
    je .Print_Hard
    
    cmp eax, 1
    je .Print_Medium
    
    Print_Message str_Easy
    jmp 0x0061A9C5
    
.Print_Medium:
    Print_Message str_Medium
    jmp 0x0061A9C5
    
.Print_Hard:
    Print_Message str_Hard
    jmp 0x0061A9C5
    
; ******************************
; ***      Blow Up House     ***
; ******************************

.Blow_Up_House_Action:
    mov eax, [esi+40h] ; first parameter
    
    cmp eax, 50
    jl .Get_House_Pointer_Blow_Up_House ; not a spawn house, find the regular house
    
    call Spawn_Index50_To_House_Pointer
    
    cmp eax, -1 ; no house associated with spawn location
    jz .Out2

    cmp eax, 0
    jnz .Blow_Up
    
.Get_House_Pointer_Blow_Up_House:    
    call 0x004C4730 ; House_Pointer_From_HouseType_Index
    
.Blow_Up:
    ; We should have the house pointer in EAX
	push eax
	mov ecx, eax
	call HouseClass__Blowup_All
	pop ecx
    call HouseClass__MPlayer_Defeated

.Out2:
    jmp 0x0061A9C5 ; default

; ***********************************
; *** Make Attached Objects Elite ***
; ***********************************

; Loops through all Technos (buildings/units/infantry/aircraft) and turns
; ones attached to this trigger elite
.Make_Attached_Objects_Elite:

.Loop_Start:
    xor  bl, bl
    xor  edi, edi
    mov  eax, [0x007E4830] ; DynamicVectorClass_TechnoClass_ActiveCount
    test eax, eax
    jz   .PostLoop
    mov  ebp, [esp+1CCh]   ; Get TriggerClass* pointer

.Loop_MainBody:
    mov  eax, [0x007E4824]  ; DynamicVectorClass_TechnoClass_Entries
    mov  esi, [eax+edi*4]   ; get object pointer to esi

    ; Check some unknown object properties, WW does this in most trigger actions
    ; for example, look at 0061C40D (in function that performs the "Destroy Attached Objects" trigger action)
    mov  eax, [esi+28h]
    test eax, eax
    jle  .Loop_Increment
    mov  al, [esi+35h]
    test al, al
    jz   .Loop_Increment
    mov  al, [esi+2Ch]
    test al, al
    jz   .Loop_Increment
    mov  al, [esi+2Fh]
    test al, al
    jnz  .Loop_Increment
    mov  ecx, [esi+24h]
    test ecx, ecx
    jz   .Loop_Increment

    push ebp             ; TriggerClass* pointer
    call 0x0061E860      ; TagClass::IsAttachedToTrigger
    test al, al
    jz   .Loop_Increment

    lea  ecx, [esi+0A8h] ; Get VeterancyClass of object
    push 1               ; enable elite status
    call 0x00664520      ; VeterancyClass::Set_Elite

.Loop_Increment:
    mov  eax, [0x007E4830] ; DynamicVectorClass_TechnoClass_ActiveCount
    inc  edi
    cmp  edi, eax
    jl   .Loop_MainBody
    test bl, bl
    jnz  .Loop_Start

.PostLoop:
    jmp  0x0061A9C5 ; default

; ***********************************
; *** Enable / disable AllyReveal ***
; ***********************************
.Enable_AllyReveal_Action:
    mov  eax, [Rules]
    mov  byte [eax+0F4Fh], 1
    jmp  0x0061A9C5 ; default

.Disable_AllyReveal_Action:
    mov  eax, [Rules]
    mov  byte [eax+0F4Fh], 0
    jmp  0x0061A9C5 ; default


; ***********************************
; ***      Create Auto-Save       ***
; ***********************************
.Create_AutoSave_Action:
    mov  eax, [Frame]
    inc  eax
    mov  [NextAutoSave], eax
    jmp  0x0061A9C5 ; default

; ***********************************
; ***   Delete Attached Object    ***
; *** (just vanish, NOT destroy!) ***
; ***********************************
.Remove_Attached_Objects_Action:
    mov  eax, [esp+1CCh] ; get TriggerClass pointer to eax
    call TAction_Remove_Object
    jmp  0x0061A9C5 ; default

