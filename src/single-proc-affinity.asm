%include "macros/datatypes.inc"
%include "TiberianSun.inc"

sstring str_kernel32dll, "kernel32.dll"
sstring str_SetProcessAffinityMask, "SetProcessAffinityMask"
sint SetProcessAffinityMask, 0

gfunction SetSingleProcAffinity
    push str_kernel32dll
    call [_imp__LoadLibraryA]
    test eax, eax
    jz .out
    push str_SetProcessAffinityMask
    push eax
    call [_imp__GetProcAddress]
    test eax, eax
    jz .out
    mov [SetProcessAffinityMask], eax
    push 1
    call [_imp__GetCurrentProcess]
    push eax
    call [SetProcessAffinityMask]
    
.out:
    retn
