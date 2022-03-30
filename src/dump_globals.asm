%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Makes the game dump global variables to the log file when a game is over.
; Author: Rampastring

sstring str_GlobalVariables, "Global variables: %s"

; Hack Do_Win to call our function
hack 0x005DC966
    call 0x00643F20 ; ThemeClass::Queue_Song(ThemeType)
    mov  ecx, [ScenarioStuff]
    call ScenarioClass__Dump_Globals
    jmp 0x005DC96B
    
section .text
ScenarioClass__Dump_Globals:
    push ebp
    mov  ebp, esp
    sub  esp, 400h ; reserve 1024 bytes from the stack
    
    push esi
    push ebx
    push edi
    mov  esi, ecx ; move "this" pointer to esi
    
    xor  eax, eax ; init eax to be the global counter

.LoopBegin
    ; code for getting a global's value from Vinifera C++ disassembly
    ; (Scen->GlobalFlags[i].Value)
    mov   edx, esi
    imul  ecx, eax, 29h
    movzx ebx, byte [edx+ecx+0D90h]

    mov  ecx, eax
    add  ecx, eax ; multiply ecx by 2 (info of each global takes up two characters)

    mov  byte [esp+ecx+21], 2Ch ; write a comma (',' 2Ch) to the buffer
    test ebx, ebx
    jle  .Write_Zero

    mov  byte [esp+ecx+20], 31h ; write '1' to the buffer
    jmp .Post_Write

.Write_Zero:
    mov  byte [esp+ecx+20], 30h ; write '0' to the buffer

.Post_Write:    
    inc eax
    cmp eax, 50 ; the game has 50 global variable slots
    jl  .LoopBegin
    
    ; write CR LF + zero to null-terminate the string
    mov  ecx, eax
    add  ecx, eax ; multiply ecx by 2
    mov  byte [esp+ecx+19], 0Dh ; CR
    mov  byte [esp+ecx+20], 0Ah ; LF
    mov  byte [esp+ecx+21], 0

    ; WWDebug_Printf handles formatting the string for us
    lea  eax, [esp+20]
    push eax
    push str_GlobalVariables
    call WWDebug_Printf
    add  esp, 8 ; clean off WWDebug_Printf's arguments from the stack
    
    pop  edi
    pop  ebx
    pop  esi
    mov  esp, ebp
    pop  ebp
    retn
