%include "macros/patch.inc"

; Patches out HouseClass::Flag_To_Win() and HouseClass::Flag_To_Lose()

@SET 0x004BFC50, retn 4
@SET 0x004BFE00, retn 4

