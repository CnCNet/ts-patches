%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Converts CloakStop= to TooBigForCarryalls=. Vehicles with this key set to true
; cannot be picked up by carryalls.
; Author: Rampastring

sstring str_TooBigForCarryalls, "TooBigForCarryalls"

@LJMP 0x004A686E, 0x004A6897 ; Remove CloakStop logic (it's broken)
@CLEAR 0x0040B81E, 0x90, 0x0040B826 ; Prevent alt-moving with carryalls

; AircraftClass::What_Action_Disllow_Carrying_Units_With_CloakStop
hack 0x0040B86A
    mov eax, [edi]
    mov ecx, edi
    call [eax+84h]
    mov cl, [eax+443h] ; Check for CloakStop
    test cl, cl
    jz .Normal_Code
    mov ebx, 2 ; ACTION_NOMOVE
    jmp 0x0040B871

.Normal_Code:
    mov ebx, 10h
    jmp 0x0040B8EB

; _TechnoTypeClass__Read_Ini_Change_CloakStop_To_TooBigForCarryalls
hack 0x0063C29A
    push    str_TooBigForCarryalls
    jmp     0x0063C29F
	
