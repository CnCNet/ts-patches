%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Makes air transports undeployable on buildings (like helipads)
; This prevents unloading units while on helipads, which caused
; the units to disappear, making the player that owned the units unable
; to lose the game
; Author: Iran
 
;@LJMP 0x0040B8C7, _AircraftClass__What_Action_Check_For_Building_On_Cell

hack 0x0040B8C7 
_AircraftClass__What_Action_Check_For_Building_On_Cell:
    mov     edx, [edi]
    lea     eax, [esp+20h] ; get ObjectClass we're hovering over (ourselves in this case)
    push    eax
    mov     ecx, edi
    call    dword [edx+18Ch] ; get coord cell
    mov     eax, [eax]
    cmp     ax, word [0x0074CB08] ; no idea, map bounds?
    mov     [esp+24h], eax
    jnz     .Jmp ; get saved coords in right format
    mov     cx, word  [esp+26h]
    cmp     cx, word [0x0074CB08+2] ; no idea, map bounds?
    jz      short .Normal_Code
 
.Jmp:
    lea     edx, [esp+24h] ; get saved coords in right format
    mov     ecx, 0x00748348 ; offset MouseClass Map
    push    edx
    call    0x0050F280 ; MapClass__Get_Cell
    mov     ecx, eax
    call    0x00452160 ; CellClass__Cell_Building
    test    eax, eax        ; if null, no building found
    jnz     .Ret_No_Deploy_Cursor
 
.Normal_Code:
    mov     eax, [esi+0A0h]
    jmp     0x0040B8CD
 
.Ret_No_Deploy_Cursor:
    mov     ebx, 0x1d ; CANT_DEPLOY cursor
    jmp     0x0040B8CD