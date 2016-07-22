@JMP 0x006010C9 _WinMain_Read_SUN_INI_Read_Extra_Options
@JMP 0x006010BA _WinMain_Read_SUN_INI_Update_Video_Windowed_String_Reference
           
_WinMain_Read_SUN_INI_Read_Extra_Options:
    call INIClass__GetBool
    
    pushad
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Options, str_SingleProcAffinity, 1
    cmp al, 1
    jnz .DoNotSetSingleProcAffinity
    call SetSingleProcAffinity
    
.DoNotSetSingleProcAffinity:

    INIClass_Get_Bool INIClass_SUN_INI, str_Video, str_NoWindowFrame, 0
    mov byte [var.NoWindowFrame], al
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Video, str_UseGraphicsPatch, 1
    mov byte [var.UseGraphicsPatch], al
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Options, str_NoCD, 1
    cmp al, 0
    jz .Dont_Set_NoCD
    mov byte [var.IsNoCD], al
.Dont_Set_NoCD: 
    
    popad
    jmp 0x006010CE
    
_WinMain_Read_SUN_INI_Update_Video_Windowed_String_Reference:
    push str_Video_Windowed
    jmp 0x006010BF