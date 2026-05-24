%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

%ifdef SPAWNER

; Prevents saving multiplayer games manually when not all players are present.
; SavesDisabled is set to 1 in recon_kick.asm when the REMOVEPLAYER event is executed.
; Author: Rampastring

cextern SavesDisabled
cextern IsDoingMPSaveNextFrame

sstring str_CantSaveWithoutAllPlayers, "All players need to be present for saving multiplayer games."

section .text

hack 0x00494DCE

    mov ax, [SavesDisabled]
    cmp ax, 1

    jne .Post_Players_Present_Check

    pushad

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
    lea edx, [str_CantSaveWithoutAllPlayers]
    push edx
    push 0
    push 0
    call MessageListClass__Add_Message

    popad

    jmp 0x00494EB3

.Post_Players_Present_Check:

    ; Don't save mid-frame in multiplayer to prevent saves from getting corrupted
    ; We instead save after the game's main loop
    mov  byte [IsDoingMPSaveNextFrame], 1
    jmp  0x00494EB3 ; exit function

; original Westwood code
;    mov eax, dword [0x007E4940]
;    xor edi, edi
;    cmp eax, edi
;    jnz 0x00494E9C
;    jmp 0x00494DDD

%endif ; SPAWNER
