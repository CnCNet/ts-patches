%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"


gint LastRenderTime, 0
gint WFPRenderInterval, 16

;;; Hack GscreenClass::Render, inspect the return pointer. If it's within Wait_for_players, then throttle
;;; Wait_For_Players function 5B2320 - 5B3235
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

    push 1
    call [_imp__Sleep]
    retn

 .Render:
    mov  dword[LastRenderTime], eax

 .Reg:
    sub esp, 8
    mov eax, [0x0074C5EC]       ;Composite surface
    jmp hackend


;;; Don't let TS free-run in Wait For Players. Instead we throttle to 333 per second
hack 0x005B3021
    push 3
    call [_imp__Sleep]

    jmp  0x005B2431


hack 0x006A5136, 0x006A513C
    add esp, 8
    push dword[MouseIntervalResolution]
    push dword[MouseRenderInterval]
    call [_imp__timeSetEvent]
    jmp hackend
