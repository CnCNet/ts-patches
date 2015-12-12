
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

%macro SpawnINI_Get_Int 3
    push %3 
    push %2
    push %1
    mov ecx, INIClass_SPAWN
    call INIClass__GetInt
%endmacro 

%macro SpawnINI_Get_Bool 3
    push %3 
    push %2
    push %1
    mov ecx, INIClass_SPAWN
    call INIClass__GetBool
%endmacro
   
%macro SpawnINI_Get_String 5
    push %5
    push %4
    push %3
    push %2
    push %1
    mov ecx, INIClass_SPAWN
    call INIClass__GetString
%endmacro

%macro SpawnINI_Get_Fixed 4
    push %4
    push %3 
    push %2
    push %1
    mov ecx, INIClass_SPAWN
    call INIClass__GetFixed
%endmacro
