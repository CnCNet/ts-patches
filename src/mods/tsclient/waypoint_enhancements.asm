%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"


;;; Allow the waypoint loops to be created without holding down the shift key
@SET 0x005E8B7F, { dw 0x9090 }  ; Skip the check for Shift key being held down

;;; After a waypoint node is deleted, move the current waypoint pointer to the next waypoint node
;;; This results in way easier to delete waypoints
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

;;; Move the waypoint when you click it.
; @LJMP 0x00478E7E, 0x00478E8C
; Commented as it was also activating/toggled firestorm defense.
