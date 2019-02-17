%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

;mov eax, [edi] ; UnitClass::vtbl
;mov ecx, edi
;call [eax+88h]; ObjectClass::GetType

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



;0040B86A