%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"


cextern LastRenderTime
cextern WFPRenderInterval

;;; Hack GscreenClass::Render, inspect the return pointer. If it's within Wait_for_players, then throttle
;;; Wait_For_Players function 5B2320 - 5B3235
%if 0
hack 0x004B95A0, 0x004B95A8
    cmp dword[esp], 0x005B2320
    jl  .Reg

    cmp dword[esp], 0x005B3235
    jg  .Reg

    push ecx
    call [_imp__timeGetTime]
    pop  ecx

    mov  edx, dword[LastRenderTime]
    add  edx, dword[WFPRenderInterval]
    cmp  eax, edx
    jge .Render

    retn

 .Render:
    mov  dword[LastRenderTime], eax

 .Reg:
    sub esp, 8
    mov eax, [0x0074C5EC]       ;Composite surface
    jmp hackend
%endif

hack 0x006A5136, 0x006A513C
    add esp, 8
    push dword[MouseIntervalResolution]
    push dword[MouseRenderInterval]
    call [_imp__timeSetEvent]
    jmp hackend
