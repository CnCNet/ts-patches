extern LoadLibraryA
extern GetProcAddress
extern GetCurrentProcess

global var.SetProcessAffinityMask
global SetSingleProcAffinity

section .rdata
    str_kernel32dll: db "kernel32.dll",0
    str_SetProcessAffinityMask: db "SetProcessAffinityMask",0

section .bss
    var.SetProcessAffinityMask: resd 1

section .text

SetSingleProcAffinity:
    pushad
    push str_kernel32dll
    call [LoadLibraryA]
    test eax, eax
    jz .out
    push str_SetProcessAffinityMask
    push eax
    call [GetProcAddress]
    test eax, eax
    jz .out
    mov [var.SetProcessAffinityMask], eax
    push 1
    call [GetCurrentProcess]
    push eax
    call [var.SetProcessAffinityMask]
.out:
    popad
    retn
