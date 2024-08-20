%include "TiberianSun.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; http://www.ppmforums.com/viewtopic.php?t=38895
; # Units in Guard mode will no longer chase after enemies that move out of firing range
; @CLEAR 0x004A1AA8, 0x90, 0x004A1AAA

; Hack FootClass::Mission_Guard
; Follow current target only if we are an AI-controlled aircraft.
; Author: Rampastring
hack 0x004A1AA0
    ; Restore original code. Follow target if we are an engineer
    test al, al
    jnz  0x004A1AD6 ; continue with current target

    mov  ecx, esi   ; this
    mov  eax, [esi] ; vtable
    call [eax+2Ch]  ; ObjectClass::What_Am_I()
    cmp  eax, 2     ; RTTI_AIRCRAFT
    jne  0x004A1AAE ; if not aircraft: seek new target, idle if not found

    mov  ecx, [esi+0ECh] ; Owner
    call 0x004CB990 ; HouseClass::Is_Human_Control()
    test al, al
    jnz  0x004A1AAE ; if human-controlled: seek new target, idle if not found

    ; if we get here we know that 1) the foot object is an aircraft and 2) the aircraft is AI-controlled
    ; check for its TarCom
    mov  ecx, [esi+11Ch] ; TechnoClass.TarCom
    test ecx, ecx
    jnz  0x004A1AD6 ; continue with current target
    jmp  0x004A1AAE ; our tarcom is null, seek new target and idle if one is not found
