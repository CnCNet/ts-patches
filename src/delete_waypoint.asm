%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"


hack 0x004EAF2A, 0x004EAF30
        jnz     hackend
        mov     ecx, [0x007E2284]
        mov     eax, [ecx+0xE0]      ; Selected Way Point
        cmp     eax, 0
        jl      .no_waypoint

        mov     ecx, [eax*4+ecx+0xE4]
        mov     edx, dword [ecx+0x28]
        dec     edx
        push    edx
        call    0x00673600

        mov     dword [0x0074950C], eax
        test    eax, eax
        jnz     hackend

.no_waypoint:
        jmp     0x004EAFDE
