@JMP 0x005DEBCD _Create_Units_Selectable_Spawning_Locations
@JMP 0x005DEAF7 _Create_Units_First_Spawn_EDI_Patch
@JMP 0x005DE8CB _Create_Units_Set_Selected_Spawn_Locations
@JMP 0x005DEAD7 _Create_Units_First_Spawn_Check_If_Not_Selected

_Create_Units_First_Spawn_Check_If_Not_Selected:
    call 0x005BE080 ;    RandomClass::operator()(int,int) 
;    pushad

    cmp dword [var.IsSpectatorArray+0*4], 1
    jz .Ret

    cmp dword [var.SpawnLocationsArray+0*4], -1
    jnz .First_Spawn_Selected
  
    cmp dword [var.SpawnerActive], 0
    jz .Ret
  
    mov esi, 0
  
.Loop:  
    cmp     esi, 7
    jg      .Ret
  
    mov     edi, DWORD [var.SpawnLocationsArray+esi*4]
    cmp     edi, eax
    jz     .Find_Another_Spawn
    
    inc     esi
    jmp     .Loop
    
.Ret:
;    popad
    jmp 0x005DEADC
    
.Find_Another_Spawn:
;    popad
    jmp 0x005DEAC2
    
.First_Spawn_Selected:
    mov eax, [var.SpawnLocationsArray+0*4]
    jmp 0x005DEADC

_Create_Units_Set_Selected_Spawn_Locations:
    mov [esp+0x90], ecx
    mov [esp+0x94], ecx ; clear more spawn spots used
;    pushad
    
    cmp dword [var.SpawnerActive], 0
    jz .Ret
    
    mov esi, 0
    
.Loop:
    cmp esi, 7
    jg  .Ret
    
    mov edi, DWORD [var.SpawnLocationsArray+esi*4] ; Get the waypoint value for spawn loc multi1...multi2 (in esi)
    cmp edi, -1 ; check if there's a spawn location set for this player
    jz  .Dont_Set_Spawn_As_Used
    mov byte [esp+edi+0x90], 1 ; if so, set spawn location selected
 
.Dont_Set_Spawn_As_Used:
    inc esi
    jmp .Loop
    
.Ret:    
;    popad
    xor     ebp, ebp
    jmp     0x005DE8DB

_Create_Units_First_Spawn_EDI_Patch:
    mov edi, eax ; EAX has spawn that is being used
    jmp 0x005DEBCD

_Create_Units_Selectable_Spawning_Locations:
    cmp dword [var.SpawnerActive], 0
    jz .Normal_Code

    ; edi contains the currently used spawn 
    mov byte [esp+edi+0x90], 1 ; Set the currenly used spawn as used
 
    mov eax, [esp+0x24] ; House number to generate for
        
    cmp dword [var.SpawnLocationsArray+eax*4], -1
    jz .Set_Normal_Spawn_Then_Normal_Code
    
;    mov dword [var.UsedSpawnsArray+4*edi], -1 ; COMMENTED OUT TO FIX PRE-PLACED SPAWNS ISSUE, MIGHT CREATE NEW ISSUES

    mov edx, eax
    
    mov eax, dword [var.SpawnLocationsArray+eax*4]
    mov byte [esp+edi+0x90], 0 ; Set the spawn the gamed wanted to use as unused
    mov byte [esp+eax+0x90], 1 ; Set the spawn we want to use as used
    
    
    mov dword [var.UsedSpawnsArray+4*eax], edx
    
    mov dword edx, [esp+0x7C]  ; SpawnLocationsArray
    mov dword edx, [edx+eax*4] ; Get our spawn location
    
    mov dword [esp+0x20], edx ; Set spawn location to use
    

    
.Normal_Code:
    mov edi, [esp+0x10] ; HouseClass to generate for
    xor edx, edx
    jmp 0x005DEBD3
    
.Set_Normal_Spawn_Then_Normal_Code:
    mov dword [var.UsedSpawnsArray+4*edi], eax
    jmp .Normal_Code
    
    