%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Normally only factories with WeaponsFactory=true make use of
; their ProductionAnim. This patch makes other factories use
; their ProductionAnim= as well.
; -------------------
; Author: Rampastring

; BuildingClass::Exit_Object_Use_ProductionAnim
hack 0x0042CF07
    ; Decrement some scenario variable as in the original code
    mov  eax, [0x007E4394]
    dec  eax
    mov  [0x007E4394], eax
    
    ; Our code
    cmp esi, 0
    je .Reg
    mov  ecx, [esi+220h] ; get BuildingTypeCLass instance
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
    pop  edi
    pop  esi
    pop  ebp
    mov  eax, 2
    pop  ebx
    add  esp, 0F8h
    retn 4
