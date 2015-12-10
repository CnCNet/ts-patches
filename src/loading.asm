%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "INIClass_macros.asm"

@LJMP 0x006010C9, _WinMain_Read_SUN_INI_Read_Extra_Options
@LJMP 0x006010BA, _WinMain_Read_SUN_INI_Update_Video_Windowed_String_Reference

cextern IsNoCD
cextern NoWindowFrame
cextern UseGraphicsPatch

cextern INIClass_SUN_INI
cextern SetSingleProcAffinity

section .rdata
    str_Options: db "Options",0
    str_SingleProcAffinity: db "SingleProcAffinity",0
    str_Video: db "Video",0
    str_NoWindowFrame: db "NoWindowFrame",0
    str_UseGraphicsPatch: db "UseGraphicsPatch",0
    str_NoCD: db "NoCD",0
    str_Video_Windowed: db "Video.Windowed",0

section .text

_WinMain_Read_SUN_INI_Read_Extra_Options:
    call INIClass__GetBool
    
    pushad
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Options, str_SingleProcAffinity, 1
    cmp al, 1
    jnz .DoNotSetSingleProcAffinity
    call SetSingleProcAffinity
    
.DoNotSetSingleProcAffinity:

    INIClass_Get_Bool INIClass_SUN_INI, str_Video, str_NoWindowFrame, 0
    mov byte [NoWindowFrame], al
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Video, str_UseGraphicsPatch, 1
    mov byte [UseGraphicsPatch], al
    
    INIClass_Get_Bool INIClass_SUN_INI, str_Options, str_NoCD, 1
    cmp al, 0
    jz .Dont_Set_NoCD
    mov byte [IsNoCD], al
.Dont_Set_NoCD: 
    
    popad
    jmp 0x006010CE
    
_WinMain_Read_SUN_INI_Update_Video_Windowed_String_Reference:
    push str_Video_Windowed
    jmp 0x006010BF
