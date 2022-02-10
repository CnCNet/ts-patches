%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; When a terrain object is blocking a unit's way and the unit has a weapon
; that can destroy wood (trees), the unit attempts to destroy the obstacle 
; on its way. This is normally desirable, but the unit also attempts to do
; this even if the terrain object on its way has Immune=yes.

; This leads to the unit firing endlessly at the terrain object that won't
; be ever actually destroyed, only stalling AI armies and hurting friendly
; units in the process.

; This fixes the bug by making the unit check for Immune=no on the terrain
; object before attempting to fire its way through the object.

; Author: Rampastring

; hack UnitClass::Can_Enter_Cell to check for IsImmune on the terrain object
hack 0x00655E0A
    ; original code, cehcks for WarheadTypeClass.IsWoodDestroyer
    test cl, cl
    jz   0x00655F13      ; return what I'm assuming is MOVE_NO (there's a permanent block, not a destroyable one)

    ; check for immunity on terrain object
    mov  ecx, [esi+64h]  ; TerrainClass.Class (fetch TerrainTypeClass instance)
    mov  al,  [ecx+0CCh] ; ObjectTypeClass.IsImmune
    test al, al
    jnz  0x00655F13      ; see comment on conditional jump above
    jmp  0x00655E12      ; handle a destroyable movement blocker

