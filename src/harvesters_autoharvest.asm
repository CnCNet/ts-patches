; Harvesters and Weeders Automatically Start to Harvest When Built

; After leaving the factory, Harvesters and Weeders will now start to harvest
; instead of waiting there until the player commanded them to do so.
;
; Patch based on information by CCHyper
; http://www.ppmforums.com/viewtopic.php?p=552284#552284
;
; Author: AlexB
; Date: 2016-11-22

%include "macros/patch.inc"
%include "macros/hack.inc"

@LJMP 0x006517BE, _UnitClass_UpdatePosition_Harvester

section .text

_UnitClass_UpdatePosition_Harvester:
    mov ecx, [ebp+360h]; UnitClass::Type

    mov ax, [ecx+48Eh]; UnitClass::Harvester and UnitClass::Weeder
    test ax, ax
    jz .Return

    mov eax, [ebp]; UnitClass::vtbl
    push 9; Mission::Harvest
    mov ecx, ebp
    call [eax+158h]; UnitClass::QueueMission

    jmp 0x0065194E

  .Return:
    push 0
    push 0x006F2EE8; BuildingClassTypeDescriptor
    jmp 0x006517C5
