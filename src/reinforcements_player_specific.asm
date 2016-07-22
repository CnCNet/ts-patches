;; @JMP 0x05DD9BB 0x005DD9C4 ; Call TeamTypes__Read_INI later
@JMP 0x0044B0CF _Get_HouseType_From_Index_Spawn_Fake
@JMP 0x00628600 _TeamTypeClass__Read_INI_Fake_House_Name_Skip
@JMP 0x005DDB2B _Read_Scenario_INI_Reinforcements_House_Hack
@JMP 0x005BF068 _Do_Reinforcements_Stuff_Skip_Null_House_TeamType

_Do_Reinforcements_Stuff_Skip_Null_House_TeamType:
    jz 0x005BF681
    
    mov eax, [edi+0x88]
    cmp eax, 0
    jz 0x005BF681
    
    mov eax, [edi+0A0h]
    jmp 0x005BF074

_Read_Scenario_INI_Reinforcements_House_Hack:
    pushad

    mov     esi, 0
    mov     ecx, [TeamTypesArray]
    
.Loop_TeamTypes_For_Reinforcements:

    mov     edx, [ecx+esi*4]


    mov     eax, [edx+0x88]
    cmp     eax, 0
    jz      .Next_Iter
    
    cmp     eax, 50
    jl      .Next_Iter
    cmp     eax, 60
    jg      .Next_Iter
    
    jmp     .Set_HouseType_For_Spawn
 
 .Next_Iter: 
    mov     ebx, [TeamTypesArray_Count]
    inc     esi
    cmp     esi, ebx
    jl      .Loop_TeamTypes_For_Reinforcements

    jmp    .Ret

.Ret:
    popad
    mov ecx, ebp
    call 0x006585C0
    jmp  0x005DDB30
    
.Set_HouseType_For_Spawn:
    sub eax, 50
    
    mov eax, [var.UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Set_To_Null
    
    mov edi, [HouseClassArray]
    mov eax, [edi+eax*4]
    
    mov [edx+0x88],  eax
    jmp .Next_Iter

.Set_To_Null:
    mov eax, 0
    mov [edx+0x88],  eax
    jmp .Next_Iter

_TeamTypeClass__Read_INI_Fake_House_Name_Skip:
    call 0x44B0A0
    cmp eax, 49
    jl .Normal_Code
    cmp eax, 60
    jg .Normal_Code
    
    jmp 0x00628611
    
.Normal_Code:
    jmp 0x00628605

_Get_HouseType_From_Index_Spawn_Fake:
    call Check_For_Reinforcements_Fake_HouseType_Name
    cmp eax, -1
    jz .Normal_Code
 
    jmp 0x0044B139
    
.Normal_Code:
    call HouseType_From_Name
    jmp 0x0044B0D4
    
    
Check_For_Reinforcements_Fake_HouseType_Name:
    push edi
    push ecx
    push ebx
    
    mov ebx, 50   
    mov edi, ecx
    
    strcmp_i ecx, str_Spawn1
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn2
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn3
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn4
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn5
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn6
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn7
    cmp eax, 0
    jz .Ret
    
    mov ecx, edi
    inc ebx
    strcmp_i ecx, str_Spawn8
    cmp eax, 0
    jz .Ret
    
    mov ebx, -1
    
.Ret:
    mov eax, ebx
    pop ebx
    pop ecx
    pop edi
    retn