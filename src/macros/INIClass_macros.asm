; args: <INIClass this>, <INI section string>, <INI key string>, <default value if missing>
%macro INIClass_Get_Int 4
    push %4 
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetInt
%endmacro

; args: <INIClass this>, <INI section string>, <INI key string>, <default value if missing>
%macro INIClass_Get_Bool 4
    push %4 
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetBool
%endmacro