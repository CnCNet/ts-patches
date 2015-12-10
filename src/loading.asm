%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "patch.inc"

sstring str_Video_Windowed, "Video.Windowed"

hack 0x006010C9 ; _WinMain_Read_SUN_INI_Read_Extra_Options:
    call INIClass__GetBool
    
    pushad
    call LoadSunIni
    popad
    jmp hackend
    
@SET 0x006010BA, push str_Video_Windowed ; _WinMain_Read_SUN_INI_Update_Video_Windowed_String_Reference
