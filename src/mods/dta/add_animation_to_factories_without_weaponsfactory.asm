%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Normally only factories with WeaponsFactory=true make use of
; their ProductionAnim. This patch makes other factories use
; their ProductionAnim= as well.
; -------------------
; Author: Rampastring

; BuildingClass::Exit_Object_Use_ProductionAnim
hack 0x0042CE6E

    call dword [edx+158h]
    
    ; Our code
    mov  ecx, [esi+220h] ; get BuildingTypeCLass instance
    xor  eax, eax
    mov  al, [ecx+81Dh]  ; WeaponsFactory
    cmp  al, 1           
    je  .Reg             ; Buildings with WeaponsFactory=yes get their
                         ; production anim applied by BuildingClass::Mission_Unload
    
    add  ecx, 6E0h
    jz  .Reg
    cmp  byte [ecx], 0
    jz  .Reg
    
    ; Do animation
    push 0
    push 0
    push 8 ; AnimType
    push ecx
    mov  ecx, esi
    call BuildingClass__Do_Animation
    
.Reg:
    jmp 0x0042CE74
