@JMP 0x00658658 _UnitClass__Read_INI_Get_HouseType_From_Name_SpawnX
@JMP 0x00434843 _BuildingClass__Read_INI_Get_HouseType_From_Name_SpawnX
@JMP 0x004D7B9A _InfantryClass__Read_INI_Get_HouseType_From_Name_SpawnX
@JMP 0x006585C0 _UnitClass__Read_INI_SpawnX_Get_UnitClassArray_Count_In_Prologue
@JMP 0x006589C8 _UnitClass__Read_INI_SpawnX_Fix_UnitClassArray_Loop_Condition
;@JMP 0x005DD92A _Read_Scenario_INI_Dont_Load_Custom_Houses_List_In_Multiplayer
@JMP 0x0043485F 0x00434874 ; jump past check in BuildingClass::Read_INI() preventing multiplayer building spawning for player
@JMP 0x006589ED _UnitClass__Read_INI_SpawnX_Fix_Up_LinkedTo_UnitClassArray_Index
@JMP 0x00658A05 _UnitClass__Read_INI_SpawnX_Fix_UnitClassArray_Loop_Condition2
@JMP 0x006589E1 _UnitClass__Read_INI_SpawnX_Fix_Up_LinkedTo_UnitClassArray_Index2

_UnitClass__Read_INI_SpawnX_Fix_Up_LinkedTo_UnitClassArray_Index2:
    mov edx, ecx
    add edx, [var.OldUnitClassArrayCount]
    mov edx, [esi+edx*4]
    cmp eax, 0FFFFFFFFh
    jmp 0x006589E7

_UnitClass__Read_INI_SpawnX_Fix_UnitClassArray_Loop_Condition2:
    mov edi, [UnitClassArray_Count]
    sub edi, [var.OldUnitClassArrayCount]
    jmp 0x00658A0B


; Need to add OldArrayCount to the current index stored in EAX
_UnitClass__Read_INI_SpawnX_Fix_Up_LinkedTo_UnitClassArray_Index:
    add eax, [var.OldUnitClassArrayCount]
    mov eax, [esi+eax*4]
    mov [edx+364h], eax ; LinkedTo?
    jmp 0x006589F6



;_Read_Scenario_INI_Dont_Load_Custom_Houses_List_In_Multiplayer:
;    cmp dword [SessionType], 0
;    jnz .Ret

;    call Read_Scenario_Houses

;.Ret:
;    jmp 0x005DD92F

; loop check needs to be i < UnitClassArray_Count - OldUnitClassArray_Count
_UnitClass__Read_INI_SpawnX_Fix_UnitClassArray_Loop_Condition:
    mov edi, [UnitClassArray_Count]
    sub edi, [var.OldUnitClassArrayCount]
    jmp 0x006589CE
    
_UnitClass__Read_INI_SpawnX_Get_UnitClassArray_Count_In_Prologue:
    push eax

    mov dword eax, [UnitClassArray_Count]
    mov dword [var.OldUnitClassArrayCount], eax
    
    pop eax
    sub esp, 192
    jmp 0x006585C6

_InfantryClass__Read_INI_Get_HouseType_From_Name_SpawnX:
    call Check_For_Spawn_Fake_HouseType_Name
    cmp eax, -1
    jz .Normal_Code
    
    mov eax, [var.UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Normal_Code
    
    mov esi, [HouseClassArray]
    mov eax, [esi+eax*4]

    mov edi, eax
    jmp 0x004D7BD5

.Normal_Code:
    call HouseType_From_Name
    jmp 0x004D7B9F

_BuildingClass__Read_INI_Get_HouseType_From_Name_SpawnX:
    call Check_For_Spawn_Fake_HouseType_Name
    push eax
    cmp eax, -1
    
    jz .Normal_Code
    
    mov eax, [var.UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Normal_Code
    
    mov esi, [HouseClassArray]
    mov eax, [esi+eax*4]
    
    mov esi, eax
    pop esi
    mov ecx, esi
    jmp 0x00434851


.Normal_Code:
    pop eax
    call HouseType_From_Name
    jmp 0x00434848 

_UnitClass__Read_INI_Get_HouseType_From_Name_SpawnX:
    call Check_For_Spawn_Fake_HouseType_Name
    cmp eax, -1
    jz .Normal_Code
    
    mov eax, [var.UsedSpawnsArray+eax*4]
    cmp eax, -1
    jz .Normal_Code
    
    mov esi, [HouseClassArray]
    mov eax, [esi+eax*4]
    
    mov esi, eax
    push str_Delim ; ","
    push ebx             ; Str
    call _strtok
    add esp, 8
    mov ecx, eax        ; Str2
    call 0x0065BB30
    mov edi, eax
    cmp edi, 0FFFFFFFFh
    mov eax, esi
    jmp 0x00658686
    
    
.Normal_Code:
    call HouseType_From_Name
    jmp 0x0065865D
    
Check_For_Spawn_Fake_HouseType_Name:
    push ebx
    push edi
    mov ebx, 0
    
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
    mov ecx, edi
    mov eax, ebx
    pop edi
    pop ebx
    retn