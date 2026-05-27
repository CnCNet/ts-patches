%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
%include "patch.inc"

; Displays an error message to the user if the -SPAWN argument has not been provided.

section .bss
    SpawnArgFound           RESD 1

section .rdata
    str_SpawnArg        db "-SPAWN",0

	%ifdef MOD_DTA
    str_GameNameTitle   db "Dawn of the Tiberium Age",0
    str_PleaseRunClient db "Please run DTA.exe instead.",0
    %elifdef MOD_TI
    str_GameNameTitle   db "Twisted Insurrection",0
    str_PleaseRunClient db "Please run TwistedInsurrection.exe instead.",0
    %elifdef MOD_TO
    str_GameNameTitle   db "Tiberian Odyssey",0
    str_PleaseRunClient db "Please run TiberianOdyssey.exe instead.",0
    %elifdef MOD_RUBICON
    str_GameNameTitle   db "Rubicon",0
    str_PleaseRunClient db "Please run Rubicon.exe instead.",0
    %elifdef TSCLIENT
    str_GameNameTitle   db "Tiberian Sun",0
    str_PleaseRunClient db "Please run TiberianSun.exe instead.",0
    %else
    str_GameNameTitle   db "Tiberian Sun",0
    str_PleaseRunClient db "Please run the game client instead.",0
    %endif

hack 0x005FFDBF
    pushad

    call [_imp__GetCommandLineA]
    push str_SpawnArg
    push eax
    call stristr_
    add esp, 8
    xor ebx, ebx
    cmp eax, 0
    setne bl
    mov [SpawnArgFound], ebx
    popad

    cmp dword [SpawnArgFound], 1
    je .Normal_Code

    ; -SPAWN arg not found, display error message asking to run the client instead

    push 16 ; uType
    push str_GameNameTitle ; Title
    push str_PleaseRunClient ; Text
    push 0 ; hWnd
    call [0x006CA458] ; ds:MessageBoxA
    jmp 0x005FFCB0

.Normal_Code:
    call 0x00472540 ; Init_Language
    jmp 0x005FFDC4
