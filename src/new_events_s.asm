%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern PlayerEventCounts
cextern PlayerEventLastFrame

;@LJA 0x004942A0, _EventClass__Execute_Extended

section .text

_EventClass__Execute_Extended:
    push esi
    call Extended_Events

    jmp 0x00495110

hack 0x004942A0, 0x004942A6
    ja  _EventClass__Execute_Extended

    push ecx
    mov ebp, PlayerEventLastFrame ; Discounting army movements and other noise
    mov ecx, [ebp+edi*4]
    cmp ecx, dword[esi+1]
    jz  .out

    lea ecx, [ebp+edi*4]
    mov edx, [esi+1]
    mov [ecx], edx

    mov ebp, PlayerEventCounts
    lea ecx, [ebp+edi*4]
    inc dword[ecx]

.out:
    pop ecx
    jmp hackend
