%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; If a wrong CRC comes in from a player, we try to
;;; broadcast a REMOVEPLAYER message to everyone.

cextern SavesDisabled

sstring str_PlayerOutOfSync, "Player has gone out of sync"
@LJNZ 0x005B4F5F, _Execute_DoList_dont_recon

section .bss
    OutOfSyncArray RESB 8

section .text

_Execute_DoList_dont_recon:
    mov  edx, [eax+0xc+0x6]     ;ID

    mov  eax, [PlayerPtr]
    mov  eax, [eax+0x20]

    cmp  edx, eax
    je   0x005B4F65

    cmp  byte [OutOfSyncArray+edx], 1
    je   0x005B4F65

    mov  eax, [HumanNode_ActiveCount]
    cmp  dword[HumanNode_ActiveCount], 3 ; Do regular recon if only 2 players
    jl   0x005B5329

    mov  byte [OutOfSyncArray+edx], 1

    push edx                    ; Store ID
    push esi
    push ebx

    sub  esp, 46                ; sizeof(EventClass)
    mov  ecx, esp
    push edx
    push dword 0x22             ; REMOVEPLAYER
    mov  eax, [PlayerPtr]
    mov  eax, [eax+0x20]        ; HouseClass.ID
    push eax
    call EventClass__EventClass_PlayerID

    push esp
    call EnqueueEvent
    add  esp, 50

    mov  edx, dword[esp+8]

    ; Calculate message duration
    mov eax, [Rules]
    fld qword [eax+0C68h]   ; Message duration in minutes
    fmul qword [0x006CB1B8] ; Frames Per Minute
    call Get_Message_Delay_Or_Duration ; Foat to int

    ; Push arguments
    push eax                ; Message delay/duration
    push 4046h              ; Very likely TextPrintType
    mov ecx, MessageListClass_this
    mov eax, [HouseClassArray_Vector]
    mov edx, [esp+8]            ; ID
    mov edx, [eax+edx*4]
    mov edx, [edx+10DFCh]
    push edx ; Color to use?
    lea edx, [str_PlayerOutOfSync]
    push edx
    push 0
    push 0
    call MessageListClass__Add_Message

    pop ebx
    pop esi

    lea eax, [esi+ebx]          ; Write SYNC file
    and eax, dword 0xFFF
    lea ecx, [eax+eax*2]
    shl ecx, 3
    sub ecx, eax
    lea ecx, [ecx*2+EventType_Offset]
    call Print_CRCs

    pop edx                     ; Retrieve ID
;    jmp  0x005B4F65
    jmp 0x005B4F72

; Hack the REMOVEPLAYER event
hack 0x00494EE4
    mov  dword [AutoSaveGame], -1
    mov  byte [SavesDisabled], 1
    mov  eax, [esi+0x6]
    cmp  byte [OutOfSyncArray+eax], 1
    jz   0x00494F1D

    mov  eax, [Frame]
    jmp  hackend
