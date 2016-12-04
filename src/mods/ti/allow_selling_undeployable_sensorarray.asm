%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"

; Allows selling buildings that have SensorArray=yes and UndeploysInto= set
; In the vanilla game they just undeploy when attempting to be sold
; Author: Iran

;@LJMP 0x00443EC0, _Sell_Or_Undeploy_Allow_Selling_SensorArray_With_UndeployInto
 
hack 0x00443EC0
_Sell_Or_Undeploy_Allow_Selling_SensorArray_With_UndeployInto:
    mov     al, [ecx+827h]
    test    al, al          ; SensorArray=
    jnz     .Check_For_Undeploy
    jmp     0x00443ECA

.Check_For_Undeploy:
    cmp dword [ecx+0x278], 0
    jnz 0x00443ECA  ; Jump to remaining checks, if UndeploysInto= is set
 
    jmp 0x00443F13 ; Undeploy