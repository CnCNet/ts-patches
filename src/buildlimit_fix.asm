%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; If a buildable object type has BuildLimit > 1, the game only allows queuing 
; up to (BuildLimit - 1) objects in case the factory is already building the specific object type.
; For example, DTA's GDI A-10 plane has a built limit of 3, but if you start
; producing an A-10 (without having any other aircraft in production / queued already),
; you can only queue 2 to be built at once. This fixes the behaviour.

; Author: Rampastring

; HouseClass_ShouldDisableCameo_4CB720_BuildLimit_Fix
hack 0x004CB778
    call 0x00497990 ; FactoryClass::Get_Index_From_Queue
    
    ; EAX = queued count
    ; ESI = EDI = TechnoTypeClass*
    
    ; After FactoryClass::Get_Index_From_Queue call, ecx contains object in production (if not null)
    ; check that the factory is producing something, jump out if it's not
    test ecx, ecx
    je .out
    
    ; Jump out if QueuedCount == 0
    test eax, eax
    je .out
    
    ; Save original value of eax in edx, because function calls will modify eax
    ; We can safely modify ecx and edx, because the original code will overwrite them right afterwards (0x004CB783)
    mov edx, eax
    
    ; Check if ObjectClass (ebx)->GetType() == ESI,
    ; check whether the factory is creating the object type that the player is trying to queue
    mov eax, [ecx]
    call [eax+88h] ; ObjectTypeClass *__thiscall (*Class_Of)(ObjectClass *this);
    cmp eax, esi
    
    ; if not, jump out
    jne .restore_value
   
    ; Check that the object type has a build limit
    mov ecx, [esi+238h] ; TechnoTypeClass->BuildLimit
    cmp ecx, 1
    jl .restore_value
    
    dec edx
    
.restore_value:
    mov eax, edx
    
.out:
    jmp 0x004CB77D
