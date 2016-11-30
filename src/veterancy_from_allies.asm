; Units and Structures Can No Longer Gain Experience From Killing Friendlies

; The game did not do any alliance checks when awarding experience for a kill.
; This hack adds a check and only awards experience for killing enemies

; Author: AlexB
; Date: 2016-11-29

%include "macros/patch.inc"

@LJMP 0x006337E8, _TechnoClass_RegisterDestruction_Veterancy

section .text

_TechnoClass_RegisterDestruction_Veterancy:
    mov cl, [eax+43Eh]; TechnoTypeClass::Trainable
    test cl, cl
    jz .Skip

    push esi
    mov ecx, [edi+0ECh]; TechnoClass::Owner
    call 0x004BDA60; HouseClass::AlliedWithObject

    test al, al
    jz 0x006337F2

  .Skip:
    jmp 0x0063381A
