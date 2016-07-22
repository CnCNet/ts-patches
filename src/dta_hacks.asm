@JMP 0x005D7E96 _Read_SaveFile_Binary_Hack_Save_Games_Sub_Directory
@JMP 0x00505503 _Get_SaveFile_Info_Save_Game_Folder_Format_String_Change
@JMP 0x00505859 _sub_505840_Save_Game_Folder_Format_String_Change
@JMP 0x005D693C _Load_Game_Save_Game_Folder_Format_String_Change1
@JMP 0x005D4FFD _Save_Game_Save_Game_Folder_Format_String_Change1
;@JMP 0x0050528E _sub505270_Save_Game_Folder_Format_String_Change
@JMP 0x00504FFB _LoadOptionsClass__Process_Save_Game_Folder_Format_String_Change
@JMP 0x00505A20 _Delete_Save_Game_Game_Folder_Format_String_Change


_Delete_Save_Game_Game_Folder_Format_String_Change:
    pushad

    mov     eax, [esp+4]
    
    push    eax
    push    str_SaveGameLoadFolder
    push    var.SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c
    
    popad
    mov     eax, var.SaveGameLoadPath
    push    eax
    jmp     0x00505A25
    

_Save_Game_Save_Game_Folder_Format_String_Change1:
    lea     eax, [esp+0x2C]

    pushad
    
    push    str_SaveGamesFolder
    push    esi
    call    stristr_
    add     esp, 8
    
    cmp     eax, 0
    jnz     .No_Change
     
    push    esi
    push    str_SaveGameLoadFolder
    push    var.SaveGameLoadPathWide   
    call    _sprintf
    add     esp, 0x0c
    
    popad
    
    mov     esi, var.SaveGameLoadPathWide  
    xor     edi, edi
    jmp     0x005D5003
    
.No_Change:
    popad
    xor     edi, edi
    jmp     0x005D5003

_LoadOptionsClass__Process_Save_Game_Folder_Format_String_Change:
    push    str_SaveGameFolderFormat2
    jmp     0x00505000

_sub505270_Save_Game_Folder_Format_String_Change:
    push    str_SaveGameFolderFormat2
    jmp     0x00505293

_Load_Game_Save_Game_Folder_Format_String_Change1:
    lea     eax, [esp+0x24]

    pushad
     
    push    esi
    push    str_SaveGameLoadFolder
    push    var.SaveGameLoadPathWide   
    call    [0x006CA464] ; WsSprintf
    add     esp, 0x0c
    
    popad
    
    mov     esi, var.SaveGameLoadPathWide  
    push    40h
    jmp     0x005D6942

_sub_505840_Save_Game_Folder_Format_String_Change:
    push    str_SaveGameFolderFormat
    jmp     0x0050585E

_Get_SaveFile_Info_Save_Game_Folder_Format_String_Change:
    push    str_SaveGameFolderFormat
    jmp     0x00505508

_Read_SaveFile_Binary_Hack_Save_Games_Sub_Directory:
    push    esi

    pushad
   
    push    ecx
    push    str_SaveGameLoadFolder
    push    var.SaveGameLoadPathWide   
    call    [0x006CA464] ; WsSprintf
    add     esp, 0x0c
    
    popad
    
    mov     ecx, var.SaveGameLoadPathWide
     
    lea     eax, [esp+8]
    jmp     0x005D7E9B