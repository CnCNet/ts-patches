%define StripClass_Size 980
%define LEFT_STRIP 0x00749874
%define RIGHT_STRIP 0x00749C48

%define AddressList_length 8

; definitions of common structures
struc sockaddr_in
    .sin_family     RESW 1
    .sin_port       RESW 1
    .sin_addr       RESD 1
    .sin_zero       RESB 8
endstruc

struc ListAddress
    .port:      RESD 1
    .ip:        RESD 1
endstruc

struc NetAddress
    .port:      RESD 1
    .ip:        RESD 1
    .zero:      RESW 1
endstruc

struc SpawnAddress
    .pad1:      RESD 1
    .id:        RESD 1
    .pad2:      RESW 1
endstruc

%macro SpawnINI_Get_Int 3
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetInt
%endmacro 

%macro SpawnINI_Get_Bool 3
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetBool
%endmacro
   
%macro SpawnINI_Get_String 5
    push %5
    push %4
    push %3
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetString
%endmacro

%macro SpawnINI_Get_Fixed 4
    push %4
    push %3 
    push %2
    push %1
    mov ecx, var.INIClass_SPAWN
    call INIClass__GetFixed

%endmacro
