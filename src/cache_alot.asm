%include "TiberianSun.inc"
%include "macros/patch.inc"

%macro CacheMixFile 1
    hack %1
    call 0x00559A10

    test eax, eax
    jz   hackend

    push eax
    push 0
    mov  ecx, eax
    call 0x00559F30

    pop eax
    jmp hackend
%endmacro

%if 0
hack 0x004E3EE8
    call 0x00559A10

    test eax, eax
    jz   hackend

    push eax
    xor  edx, edx
    lea  ecx, [esp+0x18]
    call 0x00559E90

    pop eax
    jmp hackend
%endif

CacheMixFile 0x0044EC9B         ; SCORES01.MIX

CacheMixFile 0x004E450E         ; SCORES01.MIX

CacheMixFile 0x0044EBFA         ; SCORES.MIX
CacheMixFile 0x004E4481         ; SCORES.MIX

CacheMixFile 0x0044EBA6         ; MULTI.MIX
CacheMixFile 0x004E42C8         ; MULTI.MIX

CacheMixFile 0x004E40C1         ; LOCAL.MIX

;CacheMixFile 0x004E4032         ; TIBSUN.MIX

;CacheMixFile 0x004E3EE8         ; EXPAND%02d.MIX

CacheMixFile 0x004E3D83         ; PATCH.MIX

CacheMixFile 0x004E43F4         ; SOUNDS.MIX

CacheMixFile 0x004E4367         ; SOUNDS01.MIX

CacheMixFile 0x004E418E         ; CONQUER.MIX

;CacheMixFile 0x004E7CA3         ; ISOTEMP.MIX

CacheMixFile 0x004E840F         ; SIDECD%02d.MIX, E%02dSCD%02d.MIX

CacheMixFile 0x004E8348         ; SIDENC%02d.MIX

CacheMixFile 0x004E8254         ; E%02dSNC%02d.MIX

CacheMixFile 0x004E8157         ; SIDEC%02d.MIX

CacheMixFile 0x004E805C         ; E%02dSC%02d.MIX

CacheMixFile 0x004E86AE         ; SPEECH%02d.MIX

CacheMixFile 0x004E859E         ; E%02dVOX%02d.MIX

;@SJMP 0x0055A0CD, 0x0055A12A
;@SJMP 0x0055A011, 0x0055A02C
%if 0
hack 0x0055A0D8, 0x0055A0DE
    add esp, 4
    mov [ebp+0x24], ebx
    mov [ebp+0x12], bl
    jmp hackend
%endif
