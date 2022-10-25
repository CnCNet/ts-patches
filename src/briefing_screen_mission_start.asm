%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

cglobal PlayerSide
cglobal SkipBriefingOnMissionStart

sstring str_Hard, "Difficulty: Hard"
sstring str_Medium, "Difficulty: Medium"
sstring str_Easy, "Difficulty: Easy"

section .bss
    PlayerSide                 RESD 1
    SkipBriefingOnMissionStart RESB 1

    
section .text


    ; arg: pointer to message
%macro Print_Message 1
    ; Calculate message duration
    mov eax, [Rules]
    fld qword [eax+0C68h]   ; Message duration in minutes
    fmul qword [0x006CB1B8] ; Frames Per Minute
    call Get_Message_Delay_Or_Duration ; Float to int

    ; Push arguments
    push eax                ; Message delay/duration
    push 4046h              ; Very likely TextPrintType
    mov ecx, MessageListClass_this
    push 4
    lea edx, [%1]
    push edx
    push 0
    push 0
    call MessageListClass__Add_Message
%endmacro


; Do_Restart_Disable_Briefing_Screen_Skip
;
; When the spawner loads a saved game on startup, 
; it first starts a normal session on the mission to
; initialize some internal game systems.
; The mission briefing screen is forcefully displayed normally,
; but we want to skip it when we're loading the game on session start.
; However, if the user restarts the mission after loading,
; we want to display the briefing screen on restart.
;
; Author: Rampastring (rest of the code in this file is mostly by Iran)
hack 0x005DCEE1
    mov byte [SkipBriefingOnMissionStart], 0
    call 0x00643F20 ; ThemeClass::Queue_Song(ThemeType)
    jmp  0x005DCEE6


; _Start_Scenario_Print_Difficulty_And_Force_Briefing_Screen:
hack 0x005DB49C

    cmp dword [SessionType], 0
    jnz     .Ret

    ; Don't print difficulty or display briefing screen if we're going to load a saved game
    cmp byte [SkipBriefingOnMissionStart], 1
    je  .Ret
    
    ; Print difficulty
	pushad
    mov ecx, [Scen]
    mov eax, dword [ecx+0x60C]  ; Scenario.CDifficulty (aka DifficultyModeComputer)

    cmp eax, 0
    je .Print_Hard
    
    cmp eax, 1
    je .Print_Medium
    
    Print_Message str_Easy
    jmp .Briefing
	
.Print_Medium:
    Print_Message str_Medium
	jmp .Briefing
    
.Print_Hard:
    Print_Message str_Hard
	
.Briefing:

	popad
    
	; Force briefing screen

    push    ecx
    
    call    0x0059CC40 ; loads bunch of resources
 

    MOV DWORD [0x809218],1
    MOV DWORD [0x809250],0x28
    MOV DWORD [0x808B6C],0x7F
    ;MOV DWORD [0x808B7C],0x23D05E         ;  UNICODE "ON EFFICIENCY"
    MOV DWORD [0x808B68],0x109010
    MOV DWORD [0x809248],0x00909090
    MOV DWORD [0x809244],0x00A0A7A0
    MOV DWORD [0x809230],0x244428         ;  UNICODE "l detonate the C4 when we attack the missile complex."
    MOV DWORD [0x8093A4],0x221B0B
    MOV DWORD [0x808E30],0x00443716

    cmp dword [PlayerSide], 0
    jz .Default_Color
    
    cmp dword [PlayerSide], 1
    jz .Default_Color
    
    cmp dword [PlayerSide], 2
    jz .Allied_Color
    
    cmp dword [PlayerSide], 3
    jz .Soviet_Color
    
.Default_Color:
 
    ; For GDI and Nod (sides 0 and 1) we'll use the vanilla TS color
    mov dword [0x00808B7C], 0FF70h
    jmp .out
    
.Allied_Color:
   
    ; For Allies, we use 76,163,255, also known as 0FFA349h
    mov dword [0x00808B7C], 0FFA349h
    jmp .out
   
.Soviet_Color:

    ; For Soviet, we use 255,0,0
    mov dword [0x00808B7C], 0FFh

.out:
    
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
    
    mov     ecx, [Scen]
    call    0x005C0230

    
    pop     ecx
    
.Ret:
    pop     edi
    pop     esi
    pop     ebp
    mov     byte [0x007E48FC], 1
    jmp     0x005DB4A6
