%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Makes it possible to place buildings over overlay 
; types that have Insignificant=yes.
; *******************
; Author: Rampastring


; change default of Insignificant= to no for overlay
@SET 0x0058D09D, { mov byte [esi+0CBh], 0 }


; hack CellClass::Is_Clear_To_Build to allow placement over certain overlay
hack 0x004525A2
    ; this is a complete rewrite of the game's code at 0x004525A2 - 0x004525C7
    ; 0CBh = Insignificant
    
    ; fetch type of overlay on cell
    mov  edx, [edi+30h]    ; CellClass.Overlay
    mov  eax, [0x007E22A4] ; DynamicVectorClass<OverlayTypeClass> entries
    mov  ecx, [eax+edx*4]  ; fetch OverlayTypeClass instance from vector, using edx as index
    
    ; like the original game, don't allow building over walls
    mov  al, [ecx+138h]    ; OverlayTypeClass.IsWall
    test al, al
    jnz  0x004522FB        ; return false
    
    ; if it's not a wall, then rely on Insignificant
    mov  al, [ecx+0CBh]    ; ObjectTypeClass.IsInsignificant
    test al, al

    jnz  0x004525C8        ; this overlay is insignificant, don't let it affect building placement
    jmp  0x004522FB        ; return false


; Hack BuildingTypeClass::Flush_For_Placement to allow placement over insignificant overlay
; This is necessary for the AI. Human players do not hit this code path, instead the
; CellClass::Is_Clear_To_Build hack above is enough for them
hack 0x004401B9
    mov  ecx, [eax+30h]  ; CellClass.Overlay, eax is a pointer to a CellClass instance
    cmp  ecx, 0FFFFFFFFh ; if the overlay type is -1, then proceed as usual
    je   0x004401DC

    mov  esi, [0x007E22A4] ; DynamicVectorClass<OverlayTypeClass> entries
                           ; we can safely use esi here as it's immediately
                           ; re-assigned at 0x004401DC and also at the "bail out" code path

    mov  edx, [esi+ecx*4]  ; fetch OverlayTypeClass instance from vector
    cmp  byte [edx+0CBh], 1     ; ObjectTypeClass.IsInsignificant, if set, then proceed
    je   0x004401DC

    ; otherwise, if the overlay is not insignicant, proceed to the game's original WallTower-on-wall check
    jmp  0x004401C1
