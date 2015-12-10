%include "macros/datatypes.inc"

cextern LoadLibraryA
cextern GetProcAddress
cextern GetCurrentProcess

sstring str_kernel32dll, "kernel32.dll"
sstring str_SetProcessAffinityMask, "SetProcessAffinityMask"
sint SetProcessAffinityMask, 0

gfunction SetSingleProcAffinity
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
    mov [SetProcessAffinityMask], eax
    push 1
    call [GetCurrentProcess]
    push eax
    call [SetProcessAffinityMask]
.out:
    popad
    retn
