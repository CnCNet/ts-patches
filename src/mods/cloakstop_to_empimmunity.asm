%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "TiberianSun.inc"
 
; Removes the broken CloakStop logic and instead units with CloakStop=yes
; become EMP immune
; Author: Iran

@LJMP 0x00492E84, _Check_For_EMP_Immunity_Add_Check_For_CloakStop
@LJMP 0x004A686E, 0x004A6897 ; Remove CloakStop logic (it's broken)
@LJMP 0x0063C29A, _TechnoTypeClass__Read_Ini_Change_CloakStop_To_EMPImmune
 
section .rdata
    str_EMPImmune          db "EMPImmune", 0
 
section .text
 
_Check_For_EMP_Immunity_Add_Check_For_CloakStop:
    mov     eax, [esi+360h]
    mov     cl, [eax+443h] ; Check for CloakStop
    test    cl, cl
    jnz     0x00492F78
 
.Normal_Code:
    mov     eax, [esi+32Ch]
    jmp     0x00492E8A
 
_TechnoTypeClass__Read_Ini_Change_CloakStop_To_EMPImmune:
    push    str_EMPImmune
    jmp     0x0063C29F