%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; When an AI-controlled team receives damage, the team attempts to retaliate
; against the object that dealt damage. However, the team doesn't check
; whether the object that dealt the damage is an ally, leading
; the team to attempt to 'retaliate' against a friendly object,
; causing the team members to simply stall until the next time an actual 
; enemy fires at them.
;
; This fixes the bug by making the team check whether the object
; is friendly before deciding to retaliate.
;
; Note: Hunt-mode teams don't suffer from this bug, but teams using 
; regular "attack X" scripts do.
; *******************
; Author: Rampastring

hack 0x0062453A
    ; restore original code destroyed by our jump
    ; checks whether the object that damaged us was an aircraft
    call [eax+2Ch]
    cmp  eax, 2     ; RTTI_AIRCRAFT
    jz   0x006245A4 ; return from function
    
    mov  ecx, [esi+1Ch] ; esi = pointer to TeamClass instance (this), 1Ch = TeamClass.House
                        ; iow. fetch owning house of team
                        ; initialize it as "this" pointer (ecx) for HouseClass::Is_Ally(AbstractClass *) call
                        
    push ebp            ; push pointer to object to check alliance with
    call HouseClass__Is_Ally_Abstract
    cmp  al, 1
    je   0x006245A4 ; don't retaliate, return from function instead
    
    ; it's an enemy, let's allow retaliation and kill them
    jmp  0x00624542

