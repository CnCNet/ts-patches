@JMP 0x00509383 _Main_Loop_Auto_SS
@JMP 0x004EAC39 _ScreenCaptureCommand__Activate_AutoSS_File_Name

; TODO NEED TO CHECK FOR SESSION == 3 AND SPAWNER ACTIVE

_Main_Loop_Auto_SS:
    cmp dword [var.SpawnerActive], 1 ; only do Auto-SS when spawner is active
    jnz .Ret

    cmp dword [SessionType], 3 ; only do Auto-SS in LAN mode
    jnz .Ret

    cmp dword [Frame], 0
    jz .Ret
    
    mov edx, 0
    mov ebx, 3600 ; divive by 3600, 60 FPS means every 60 secs
    mov eax, [Frame]
    
    idiv ebx
    
    cmp dx, 254 ; frame to first do SS and the remainder of the division
    jnz .Ret

    mov dword [var.DoingAutoSS], 1
    call 0x004EAB00 ; screen capture
    mov dword [var.DoingAutoSS], 0
    
.Ret:
    call 0x005094A0; Sync_Delay(void)
    jmp 0x00509388
    
_ScreenCaptureCommand__Activate_AutoSS_File_Name:
    lea ecx, [esp+0x114]
    
    cmp dword [var.DoingAutoSS], 1
    jnz .Normal_Code

.AutoSS_File_Name:
    
    push 0 
    push str_AutoSSDir
    call [0x006CA0D0] ; CreateDirectoryA
    
    lea ecx, [esp+0x114]

    push esi
    push dword [Frame]
    push dword [GameIDNumber]
    push str_AutoSSFileNameFormat ; "AutoSS\\AutoSS-%d-%d_%d.PCX"
    push ecx
    call _sprintf
    add esp, 0x14 ; AFTER PUSHING
    jmp 0x004EAC4F

.Normal_Code:
    jmp 0x004EAC40
    
; var.DoingAutoSS