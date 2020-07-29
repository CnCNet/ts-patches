%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Changes the cursor for deployable units with repair weapons into
; "deploy" instead of guard when pointing at the unit itself
; by Rampastring

; 0x00656281 in UnitClass::What_Action calls TechnoClass::Combat_Dmaage, 
; it is followed by a jump if damage >= 0
; units with repair weapons (damage < 0) don't jump there without this hack
; Currently this has the downside that non-deployable
; repair units lose the guard cursor as well


hack 0x00656294
    call 0x004CB950 ; HouseClass::Is_Player
    test al, al
    jz   0x0065641F
    cmp  esi, ebx   ; Check if the object under the cursor is the same as "this" object
    je   0x0065641F
    jmp  0x006562A1 ; continue original code
    
