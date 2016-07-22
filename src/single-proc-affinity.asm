
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
