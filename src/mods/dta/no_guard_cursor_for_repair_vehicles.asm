%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Changes the cursor for deployable units with repair weapons into
; "deploy" instead of guard
; by Rampastring

; 0x00656281 in UnitClass::What_Action calls TechnoClass::Combat_Dmaage, 
; it is followed by a jump if damage >= 0
; units with repair weapons (damage < 0) don't jump there without this hack
; Currently this has the downside that non-deployable
; repair units lose the guard cursor as well
@LJMP 0x00656288, 0x0065641F
