%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

sstring SaveGameLoadPathWide,  "", 512
sstring SaveGameLoadPath,      "", 256

sstring str_SaveGameLoadFolder, "Saved Games\%s"
sstring str_SaveGameFolderFormat, "Saved Games\*.%3s"
sstring str_SaveGameFolderFormat2, "Saved Games\SAVE%04lX.%3s"
sstring str_SaveGamesFolder, "Saved Games"

;;@LJMP 0x00505A20, _Delete_Save_Game_Game_Folder_Format_String_Change
hack 0x00505A20
_Delete_Save_Game_Game_Folder_Format_String_Change:
    pushad

    mov     eax, [esp+4]

    push    eax
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad
    mov     eax, SaveGameLoadPath
    push    eax
    jmp     hackend

;@LJMP 0x005D4FFD, _Save_Game_Save_Game_Folder_Format_String_Change1
hack 0x005D4FFD
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
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad

    mov     esi, SaveGameLoadPath
    xor     edi, edi
    jmp     0x005D5003

.No_Change:
    popad
    xor     edi, edi
    jmp     0x005D5003

@SET 0x00504FFB, {push str_SaveGameFolderFormat2}

@SET 0x0050528E, {push str_SaveGameFolderFormat2}

hack 0x005D693C, 0x005D6942
_Load_Game_Save_Game_Folder_Format_String_Change1:
    lea     eax, [esp+0x24]

    pushad

    push    esi
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPathWide
    call    [0x006CA464] ; WsSprintfA
    add     esp, 0x0c

    popad

    mov     esi, SaveGameLoadPathWide
    push    0x40
    jmp     hackend

@SET 0x00505859, {push str_SaveGameFolderFormat}

@SET 0x00505503, {push str_SaveGameFolderFormat}

hack 0x005D7E96
_Read_SaveFile_Binary_Hack_Save_Games_Sub_Directory:
    push    esi

    pushad

    push    ecx
    push    str_SaveGameLoadFolder
    push    SaveGameLoadPath
    call    _sprintf
    add     esp, 0x0c

    popad

    mov     ecx, SaveGameLoadPath


    lea     eax, [esp+8]
    jmp     0x005D7E9B