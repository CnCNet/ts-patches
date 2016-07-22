@JMP 0x005DB49C _Start_Scenario_Force_Briefing_Screen

_Start_Scenario_Force_Briefing_Screen:
    cmp dword [SessionType], 0
    jnz     .Ret

    push    ecx
    
    call    0x0059CC40 ; loads bunch of resources
 

    MOV DWORD [0x809218],1
    MOV DWORD [0x809250],0x28
    MOV DWORD [0x808B6C],0x7F
    MOV DWORD [0x808B7C],0x23D05E         ;  UNICODE "ON EFFICIENCY"
    MOV DWORD [0x808B68],0x109010
    MOV DWORD [0x809248],0x00909090
    MOV DWORD [0x809244],0x00A0A7A0
    MOV DWORD [0x809230],0x244428         ;  UNICODE "l detonate the C4 when we attack the missile complex."
    MOV DWORD [0x8093A4],0x221B0B
    MOV DWORD [0x808E30],0x00443716



MOV ESI,0x0FF
MOV word [0x8093B4],SI
CALL 0x0048C0F0
MOV CX,AX
SHR word [0x8093B4],CL
CALL 0x0048C0E0
MOV CX,AX
MOV word [0x8093B6],SI
SHL word [0x8093B4],CL
CALL 0x0048C110
MOV CX,AX
SHR word [0x8093B6],CL
CALL 0x0048C100
MOV CX,AX
MOV word [0x8093B8],SI
SHL word [0x8093B6],CL
CALL 0x0048C130
MOV CX,AX
SHR word [0x8093B8],CL
CALL 0x0048C120
MOV CX,AX
SHL word [0x8093B8],CL


 
    
    ; load some stuff to get text color right on button
;    mov     ecx, 0
;    push    ecx
;    call    [0x006CA368]
;    push    eax
;    call    0x005912E0
    
    mov     ecx, [ScenarioStuff]
    call    0x005C0230

    
    pop     ecx
    
.Ret:
    pop     edi
    pop     esi
    pop     ebp
    mov     byte [0x007E48FC], 1
    jmp     0x005DB4A6