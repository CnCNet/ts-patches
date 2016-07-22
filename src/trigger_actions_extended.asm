; 0x40 = first parameter, 0x24 = second parameter, 0x28, third parameter, 0x2C = fourth parameter, 0x30 = fifth parameter
; the trigger action type should be 0 (as set map INI) for the extended triggers added, determines how the rest of the
; INI line is read for the rest of the trigger
; [Actions] 01000000=1,7,1,01000005,0,0,0,0,A
; [Actions] TRIGGER_ACTION_ID=AMOUNT_OF_ACTIONS,TRIGGER_ACTION_ID,TRIGGER_ACTION_TYPE,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,WAYPOINT_LETTER(?)
@JMP 0x006198C7 _Trigger_Action_Extend_Change_House

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
    
    mov eax, [var.UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Ret
    
    mov edi, [HouseClassArray]
    mov eax, [edi+eax*4]
    
    jmp .Ret

.Return_Zero:
    mov eax, 0

.Ret:
    pop edx
    pop edi
    retn