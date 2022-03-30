%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern IsNoCD

hack 0x004E0469 ; _Init_Game_NoCD_Check
    cmp byte [IsNoCD], 1
    jz 0x004E06F5
    cmp eax, ebp
    jnz 0x004E06F5
    jmp 0x004E0471

    
hack 0x0044E7C0 ; _CD_NeverAsk
    cmp byte [IsNoCD], 0
    jz .Normal_Code

.NoCD:
    mov al, 1
    jmp 0x0044E96B; jump to retn instruction

.Normal_Code:
    sub esp, 184h
    jmp 0x0044E7C6

    
hack 0x0044E7A0 ; _CD_AlwaysAvailable
    cmp byte [IsNoCD], 0
    jz .Normal_Code

.NoCD:
    mov al, 1
    jmp 0x0044E7BB ; jump to retn instruction

.Normal_Code:
    mov eax, [esp+4] ; arg_0
    cmp eax, 0FFFFFFFEh
    jmp 0x0044E7A7

    
hack 0x004754A0 ; _CD_AlwaysFindTS
    cmp byte [IsNoCD], 0
    jz .Normal_Code

.NoCD: 
    mov eax, 0
    jmp 0x004756AB ; jump to retn instruction

.Normal_Code:
    sub     esp, 0x148
    push    ebx
    push    ebp
    mov     ebx, ecx
    push    esi
    push    edi
    jmp     0x004754AC
