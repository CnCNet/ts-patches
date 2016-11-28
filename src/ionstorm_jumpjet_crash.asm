; Fix for the Ion Storm Jump Jet Crash

; Prevents the game from crashing when a Jump Jet Infantry is flying or trying
; to take off just when an Ion Storm starts.

; Detailled description: http://www.ppmforums.com/viewtopic.php?p=540944#540944

; Author: AlexB
; Date: 2016-01-31, 2016-11-24

%include "macros/patch.inc"

@LJMP 0x004F96FF, _JumpjetLocomotionClass_ILocomotion_Process_JumpJet

_JumpjetLocomotionClass_ILocomotion_Process_JumpJet:
    call [edx+140h]; ObjectClass::ReceiveDamage
    jmp 0x004F986C; jumping out fixes the crash
